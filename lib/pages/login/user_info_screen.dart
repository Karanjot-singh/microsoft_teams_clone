
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/config/custom_colors.dart';
import 'package:microsoft_teams_clone/pages/home/home_page.dart';
import 'package:microsoft_teams_clone/routes/app_routes.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:microsoft_teams_clone/services/stream_chat/app_config.dart';
import 'package:microsoft_teams_clone/services/stream_chat/stream_api.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../../services/authentication/authentication.dart';

// To be written by flutter secure storage for persistence
const kStreamApiKey = 'STREAM_API_KEY';
const kStreamUserId = 'STREAM_USER_ID';
const kStreamToken = 'STREAM_TOKEN';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required Firebase.User user})
      : _user = user,
        super(key: key);

  final Firebase.User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late Firebase.User _user;
  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          'User Login',
          style: TextStyle(
              color: StreamChatTheme.of(context).colorTheme.black,
              fontSize: 16.0),
        ),
        backgroundColor: appPurpleColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: CustomColors.firebaseGrey,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                'Welcome',
                style: StreamChatTheme.of(context).textTheme.title,
              ),
              SizedBox(height: 8.0),
              Text(
                _user.displayName!,
                style: TextStyle(
                  color: CustomColors.firebaseYellow,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '( ${_user.email!} )',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                StreamConfig.kDefaultStreamClient
                    .devToken(_user.uid)
                    .rawValue
                    .toString(),
                style: TextStyle(
                    color: CustomColors.firebaseGrey.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),
              SizedBox(height: 24.0),
              Text(
                _user.uid.toString(),
                style: TextStyle(
                    color: CustomColors.firebaseGrey.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),

              SizedBox(height: 24.0),
              Text(
                'Sign out',
                style: TextStyle(
                    color: CustomColors.firebaseGrey.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),
              SizedBox(height: 16.0),
              _isSigningOut
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.redAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });
                        await Authentication.signOut(context: context);
                        setState(() {
                          _isSigningOut = false;
                        });
                        Navigator.of(context)
                            .pushReplacement(routeToSignInScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 24.0),
              //TODO: Modular Buttons
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.redAccent,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    barrierColor:
                        StreamChatTheme.of(context).colorTheme.overlay,
                    builder: (context) => Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: StreamChatTheme.of(context).colorTheme.white,
                        ),
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: appAccentColor,
                          ),
                        ),
                      ),
                    ),
                  );
                  String? name = _user.displayName!;
                  final client = StreamChatClient(
                    kDefaultStreamApiKey,
                    logLevel: Level.INFO,
                  )..chatPersistenceClient = StreamApi.chatPersistentClient;
                  final token = StreamConfig.kDefaultStreamClient
                      .devToken(_user.uid)
                      .rawValue
                      .toString();
                      //TODO: Test EmailID instead of UserID
                  User newUser = User(
                    id: _user.uid,
                    extraData: {
                      'name': name,
                      'image': _user.photoURL!,
                    },
                  );
                  await client.connectUser(newUser, token);

                  //Serialisation of UserID
                  // to save the user state on second visit

                  final secureStorage = FlutterSecureStorage();
                  secureStorage.write(
                    key: kStreamApiKey,
                    value: kDefaultStreamApiKey,
                  );
                  secureStorage.write(
                    key: kStreamUserId,
                    value: _user.uid,
                  );
                  secureStorage.write(
                    key: kStreamToken,
                    value: token,
                  );
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.HOME,
                    ModalRoute.withName(Routes.HOME),
                    arguments: HomePageArgs(client),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

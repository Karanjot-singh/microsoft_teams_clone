import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:video_player/video_player.dart';

class PinnedMessagesPage extends StatefulWidget {
  final List<SortOption>? sortOptions;

  final PaginationParams? paginationParams;

  final WidgetBuilder? emptyBuilder;

  final ShowMessageCallback? onShowMessage;

  final MessageTheme messageTheme;

  const PinnedMessagesPage({
    required this.messageTheme,
    this.sortOptions,
    this.paginationParams,
    this.emptyBuilder,
    this.onShowMessage,
  });

  @override
  _PinnedMessagesPageState createState() => _PinnedMessagesPageState();
}

class _PinnedMessagesPageState extends State<PinnedMessagesPage> {
  Map<String?, VideoPlayerController?> controllerCache = {};

  @override
  void initState() {
    super.initState();
    final messageSearchBloc = MessageSearchBloc.of(context);
    messageSearchBloc.search(
      filter: Filter.in_(
        'cid',
        [StreamChannel.of(context).channel.cid!],
      ),
      messageFilter: Filter.equal(
        'pinned',
        true,
      ),
      sort: widget.sortOptions,
      pagination: widget.paginationParams,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.white,
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Pinned Messages',
          style: TextStyle(
            color: StreamChatTheme.of(context).colorTheme.black,
            fontSize: 16.0,
          ),
        ),
        leading: StreamBackButton(),
        backgroundColor: appPurpleColor,
      ),
      body: _buildMediaGrid(),
    );
  }

  Widget _buildMediaGrid() {
    final messageSearchBloc = MessageSearchBloc.of(context);

    return StreamBuilder<List<GetMessageResponse>>(
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: const CircularProgressIndicator(
              color: appAccentColor,
            ),
          );
        }

        if (snapshot.data!.isEmpty) {
          if (widget.emptyBuilder != null) {
            return widget.emptyBuilder!(context);
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamSvgIcon.pin(
                  size: 136.0,
                  color: StreamChatTheme.of(context).colorTheme.greyGainsboro,
                ),
                SizedBox(height: 16.0),
                Text(
                  'No pinned items',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: StreamChatTheme.of(context).colorTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Long-press an important message and\nchoose ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: appPurpleColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Pin to conversation',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: StreamChatTheme.of(context)
                            .colorTheme
                            .black
                            .withOpacity(0.5),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        }

        var data = snapshot.data ?? [];

        return LazyLoadScrollView(
          onEndOfPage: () => messageSearchBloc.search(
            filter: Filter.in_(
              'cid',
              [StreamChannel.of(context).channel.cid!],
            ),
            messageFilter: Filter.equal(
              'pinned',
              true,
            ),
            sort: widget.sortOptions,
            pagination: widget.paginationParams!.copyWith(
              offset: messageSearchBloc.messageResponses?.length ?? 0,
            ),
          ),
          child: ListView.builder(
            itemBuilder: (context, position) {
              var user = data[position].message.user!;
              var attachments = data[position].message.attachments;
              var text = data[position].message.text ?? '';

              return ListTile(
                leading: UserAvatar(
                  user: user,
                  constraints: BoxConstraints(
                    maxWidth: 40.0,
                    minHeight: 40.0,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                title: Text(
                  user.name,
                  style: TextStyle(
                      color: StreamChatTheme.of(context).colorTheme.black,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  text != ''
                      ? text
                      : (attachments.isNotEmpty
                          ? '${attachments.length} attachment${attachments.length > 1 ? 's' : ''}'
                          : ''),
                ),
                onTap: () {
                  widget.onShowMessage?.call(data[position].message,
                      StreamChannel.of(context).channel);
                },
              );
            },
            itemCount: snapshot.data!.length,
          ),
        );
      },
      stream: messageSearchBloc.messagesStream,
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var c in controllerCache.values) {
      c!.dispose();
    }
  }
}

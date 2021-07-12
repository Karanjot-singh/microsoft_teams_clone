import 'package:flutter/material.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelFilePage extends StatefulWidget {

  final List<SortOption>? sortOptions;

  final PaginationParams? paginationParams;

  final WidgetBuilder? emptyBuilder;

  const ChannelFilePage({
    this.sortOptions,
    this.paginationParams,
    this.emptyBuilder,
  });

  @override
  _ChannelFilePageState createState() =>
      _ChannelFilePageState();
}

class _ChannelFilePageState extends State<ChannelFilePage> {
  @override
  void initState() {
    super.initState();
    final messageSearchBloc = MessageSearchBloc.of(context);
    messageSearchBloc.search(
      filter: Filter.in_(
        'cid',
        [StreamChannel.of(context).channel.cid!],
      ),
      messageFilter: Filter.in_(
        'attachments.type',
        ['file'],
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
          'Files',
          style: TextStyle(
              color: StreamChatTheme.of(context).colorTheme.black,
              fontSize: 16.0),
        ),
        leading: Center(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 24.0,
              height: 24.0,
              child: StreamSvgIcon.left(
                color: StreamChatTheme.of(context).colorTheme.black,
                size: 24.0,
              ),
            ),
          ),
        ),
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
                StreamSvgIcon.files(
                  size: 136.0,
                  color: StreamChatTheme.of(context).colorTheme.greyGainsboro,
                ),
                SizedBox(height: 16.0),
                Text(
                  'No Files',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: StreamChatTheme.of(context).colorTheme.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Files sent in this chat will appear here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: appAccentIconColor,
                  ),
                ),
              ],
            ),
          );
        }

        final media = <Attachment, Message>{};

        for (var item in snapshot.data!) {
          item.message.attachments.where((e) => e.type == 'file').forEach((e) {
            media[e] = item.message;
          });
        }

        return LazyLoadScrollView(
          onEndOfPage: () => messageSearchBloc.search(
            filter: Filter.in_(
              'cid',
              [StreamChannel.of(context).channel.cid!],
            ),
            messageFilter: Filter.in_(
              'attachments.type',
              ['file'],
            ),
            sort: widget.sortOptions,
            pagination: widget.paginationParams!.copyWith(
              offset: messageSearchBloc.messageResponses?.length ?? 0,
            ),
          ),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FileAttachment(
                    message: media.values.toList()[position],
                    attachment: media.keys.toList()[position],
                  ),
                ),
              );
            },
            itemCount: media.length,
          ),
        );
      },
      stream: messageSearchBloc.messagesStream,
    );
  }
}

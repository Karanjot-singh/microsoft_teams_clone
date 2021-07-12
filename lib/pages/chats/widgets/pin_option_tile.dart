import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/pages/chats/chat_info_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:microsoft_teams_clone/pages/chats/group_chat/channel_page.dart';
import 'package:microsoft_teams_clone/pages/chats/pinned_messages_page.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';

class PinOptionTile extends StatelessWidget {
  const PinOptionTile({
    Key? key,
    required this.context,
    required this.widget,
  }) : super(key: key);

  final BuildContext context;
  final ChatInfoPage widget;

  @override
  Widget build(BuildContext context) {
    return OptionListTile(
      title: 'Pinned Messages',
      tileColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      titleTextStyle: StreamChatTheme.of(context).textTheme.body,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: StreamSvgIcon.pin(
          size: 24.0,
          color: appAccentIconColor,
        ),
      ),
      trailing: StreamSvgIcon.right(
          color: StreamChatTheme.of(context).colorTheme.black.withOpacity(0.5)),
      onTap: () {
        final channel = StreamChannel.of(context).channel;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StreamChannel(
              channel: channel,
              child: MessageSearchBloc(
                child: PinnedMessagesPage(
                  messageTheme: widget.messageTheme,
                  sortOptions: [
                    SortOption(
                      'created_at',
                      direction: SortOption.ASC,
                    ),
                  ],
                  paginationParams: PaginationParams(limit: 20),
                  onShowMessage: (m, c) async {
                    final client = StreamChat.of(context).client;
                    final message = m;
                    final channel = client.channel(
                      c.type,
                      id: c.id,
                    );
                    if (channel.state == null) {
                      await channel.watch();
                    }
                    Navigator.pushNamed(
                      context,
                      Routes.CHANNEL_PAGE,
                      arguments: ChannelPageArgs(
                        channel: channel,
                        initialMessage: message,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

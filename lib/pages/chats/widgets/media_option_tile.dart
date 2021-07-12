import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/pages/chats/chat_info_page.dart';
import 'package:microsoft_teams_clone/pages/chats/group_chat/channel_info_page.dart';
import 'package:microsoft_teams_clone/pages/chats/group_chat/channel_media_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:microsoft_teams_clone/pages/chats/group_chat/channel_page.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';

/*
Option Tile Widgets for info screen of channels and private chats.
Generalised and Modular Tiles implemented
*/


class MediaOptionsTile extends StatelessWidget {
  const MediaOptionsTile({
    Key? key,
    required this.context,
    this.channelWidget,
    this.chatWidget,
  }) : super(key: key);

  final BuildContext context;
  final ChannelInfoPage? channelWidget;
  final ChatInfoPage? chatWidget;

  @override
  Widget build(BuildContext context) {
    return OptionListTile(
      tileColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      separatorColor: StreamChatTheme.of(context).colorTheme.greyGainsboro,
      title: 'Photos & Videos',
      titleTextStyle: StreamChatTheme.of(context).textTheme.body,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: StreamSvgIcon.pictures(
          size: 32.0,
          color: appAccentIconColor,
        ),
      ),
      trailing: StreamSvgIcon.right(
        color: appLightColor,
      ),
      onTap: () {
        var channel = StreamChannel.of(context).channel;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StreamChannel(
              channel: channel,
              child: MessageSearchBloc(
                child: ChannelMediaPage(
                  //Added Modularity
                  messageTheme: chatWidget == null
                      ? channelWidget!.messageTheme
                      : chatWidget!.messageTheme,
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
                    await Navigator.pushNamed(
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

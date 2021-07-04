import 'package:flutter/foundation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// For Web
class ChannelProvider extends ChangeNotifier {
  Channel _selectedChannel;

  Channel get selectedChannel => _selectedChannel;

  void setChannel(Channel channel) {
    _selectedChannel = channel;
    notifyListeners();
  }
}

import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class StreamApi {
  // Initialised client instance for Chat persistent storage
  static final chatPersistentClient = StreamChatPersistenceClient(
    logLevel: Level.SEVERE,
    connectionMode: ConnectionMode.background,
  );
}

class InitData {
  final StreamChatClient client;
  final StreamingSharedPreferences preferences;

  InitData(this.client, this.preferences);
}

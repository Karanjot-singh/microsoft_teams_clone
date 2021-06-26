import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

class StreamApi {
  // Initialised client instance for Chat persistent storage
  static final chatPersistentClient = StreamChatPersistenceClient(
    logLevel: Level.SEVERE,
    connectionMode: ConnectionMode.background,
  );
}

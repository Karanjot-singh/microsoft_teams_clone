## Codebase Overview

### Overview
1. A bridge has been created to connect the firebase auth &  StreamChat SDK

![Client](https://user-images.githubusercontent.com/55680995/125423195-bef102f1-12c4-4adb-b53f-b072351ab961.png) 

2. There are three important things to notice that are common to all Flutter application using StreamChat:

> * The Dart API client is initialized with your API Key
> * The current user is set by calling connectUser on the client
> * The client is then passed to the top-level StreamChat widget

3. The top level StreamChatClient is returned in ```home_page.dart```, StreamChat is an inherited widget and must be the parent of all Chat related widgets, we will cover later how you can leverage the inherited widget APIs to build more advanced customizations to your application.

4. A channel contains messages and a list of members who are permanently associated with the channel and a list of watchers currently watching the channel.

5. The `ChannelListPage` widget retrieves the list of channels based on a custom query and ordering using the `ChannelsBloc` inherited widget

6. To add data persistence `ChatPersistenceClient` is extended and passed as an instance to the `StreamChatClient`.

7. To read more, Please refer to the [tutorial](https://getstream.io/chat/flutter/tutorial/#flutter-chat-sdk-setup) for steps.



### Directory Structure of /lib
1. A good, structured catalogue of projects and relevant resources proofs design-processes and teamwork, speed-ups designer’s work. It helps new employees to natively understand the catalogue. It also allows separate accesses for security issues.
2. In order to develop a scalable application that can be **extended to ios, web, and desktop using flutter cross-platform**, I have maintained a clean directory structure in line with **Agile methodologies** as follows:

(Self-explanatory / Internal files are not mentioned.)

* [config/](./lib/config) - constants used in the application
  * [constants.dart](./lib/config/constants.dart)
  * [custom_colors.dart](./lib/config/custom_colors.dart)
* [pages/](./lib/pages) - The Widgets of all the pages / screens in the application
  * [chats/](./lib/pages/chats) - All Pages related to the chat functionality
    * [group_chat/](./lib/pages/chats/group_chat) - All Pages related to group chats or channels
      * [channel_file_page.dart](./lib/pages/chats/group_chat/channel_file_page.dart)
      * [channel_info_page.dart](./lib/pages/chats/group_chat/channel_info_page.dart)
      * [channel_media_page.dart](./lib/pages/chats/group_chat/channel_media_page.dart)
      * [channel_name_page.dart](./lib/pages/chats/group_chat/channel_name_page.dart)
      * [channel_page.dart](./lib/pages/chats/group_chat/channel_page.dart)
    * [new_chat/](./lib/pages/chats/new_chat) - All Pages related to Create a new group / Chat Functionality
      * [add_channel_members_page.dart](./lib/pages/chats/new_chat/add_channel_members_page.dart)
      * [chips_input_text_field.dart](./lib/pages/chats/new_chat/chips_input_text_field.dart)
      * [new_chat_page.dart](./lib/pages/chats/new_chat/new_chat_page.dart)
    * [widgets/](./lib/pages/chats/widgets) - Modular Widgets used commonly in this chat sub directory
      * [files_option_tile.dart](./lib/pages/chats/widgets/files_option_tile.dart)
      * [media_option_tile.dart](./lib/pages/chats/widgets/media_option_tile.dart)
      * [mute_option_tile.dart](./lib/pages/chats/widgets/mute_option_tile.dart)
      * [pin_option_tile.dart](./lib/pages/chats/widgets/pin_option_tile.dart)
    * [chat_info_page.dart](./lib/pages/chats/chat_info_page.dart)
    * [chats_home_page.dart](./lib/pages/chats/chats_home_page.dart) - The home page of all the chats
    * [pinned_messages_page.dart](./lib/pages/chats/pinned_messages_page.dart)
    * [thread_page.dart](./lib/pages/chats/thread_page.dart)
  * [login/](./lib/pages/login) - All Pages related to Login
    * [google_sign_in_button.dart](./lib/pages/login/google_sign_in_button.dart)
    * [sign_in_page.dart](./lib/pages/login/sign_in_page.dart)
    * [user_info_page.dart](./lib/pages/login/user_info_page.dart)
  * [meetings/](./lib/pages/meetings) - All Pages related to Create & Join Meeting Functionality
    * [create_meetings_page.dart](./lib/pages/meetings/create_meetings_page.dart)
    * [join_meetings_page.dart](./lib/pages/meetings/join_meetings_page.dart)
    * [meetings_page.dart](./lib/pages/meetings/meetings_page.dart)
  * [mentions/](./lib/pages/mentions) - The mentions page to list user mentions
    * [user_mentions_page.dart](./lib/pages/mentions/user_mentions_page.dart)
  * [onboarding/](./lib/pages/onboarding) - All Pages related to the onboarding screen
    * [share_screen.dart](./lib/pages/onboarding/share_screen.dart)
    * [splash_screen.dart](./lib/pages/onboarding/splash_screen.dart)
    * [video_screen.dart](./lib/pages/onboarding/video_screen.dart)
    * [welcome_screen.dart](./lib/pages/onboarding/welcome_screen.dart)
* [routes/](./lib/routes) - Contains all the routes used and generated in the application
  * [app_routes.dart](./lib/routes/app_routes.dart)
  * [routes.dart](./lib/routes/routes.dart)
* [services/](./lib/services) - Contains The service initialisation logic for StreamChat & Authentication using Firebase in the application
  * [authentication/](./lib/services/authentication)
    * [authentication.dart](./lib/services/authentication/authentication.dart)
  * [notifications/](./lib/services/notifications) - Work in progress Notification implementation for android
    * [notifications_service.dart](./lib/services/notifications/notifications_service.dart)
  * [stream_chat/](./lib/services/stream_chat)
    * [chat_list.dart](./lib/services/stream_chat/chat_list.dart)
    * [stream_api.dart](./lib/services/stream_chat/stream_api.dart)
* [widgets/](./lib/widgets)
  * [drawer.dart](./lib/widgets/drawer.dart) - The Drawer Widget of the Application
  * [rounded_button.dart](./lib/widgets/rounded_button.dart)
  * [search_text_field.dart](./lib/widgets/search_text_field.dart)
* [home_page.dart](./lib/home_page.dart) - **Contains the top level Stream Chat widget**
* [main.dart](./lib/main.dart) - The entry point for execution


### Coding Style & Conventions

  * This application follows the [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) & the repository is 
    maintained following [Agile Methodologies](https://www.atlassian.com/agile) and [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
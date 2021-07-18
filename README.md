# Microsoft Teams Clone by [Karanjot Singh](https://github.com/Karanjot-singh/)
## About
<img src="https://user-images.githubusercontent.com/55680995/125406184-2f3d8700-e3d6-11eb-9327-09c2dd584893.png" alt="drawing" width="100"/>

Microsoft Teams Clone is a Video conference application with a rich integrated chat experience, to connect with friends,family & colleagues.
It was developed as a redesign of Microsoft Teams during my menteeship at [Microsoft Engage 2021](https://microsoft.acehacker.com/engage2021/index.html).
The following features of the original app were implemented
  * [Instant Messaging](https://www.microsoft.com/en-in/microsoft-teams/instant-messaging)
    Share your opinion and have fun with your team. Send GIFs, stickers and emojis in a group chat or in one-to-one messages.
  * [Online Meetings](https://www.microsoft.com/en-in/microsoft-teams/online-meetings)
    Instantly go from group chat to video conference with the touch of a button.
  * [Collaborate](https://www.microsoft.com/en-in/microsoft-teams/online-meetings)
    Easily find, share files in real time, in chat to keep the work on :)

This application is written using Flutter & Dart. It leverages Gradle and AndroidX and utilises StreamChat SDK, Google Firebase and Jisi Meet Android SDK.

## Contents
- [Download](#download)
- [Features](#features)
- [Development](#development)
  * [Project Setup](#project-setup)
  * [Coding Style & Conventions](#coding-style)
  * [Overview of the codebase](#overview-of-the-codebase)
  * [Contributing](#contributing)
- [Implementation](#implementation)
  * [Technologies Used](#technologies-used)
  * [Agile Methodologies](#agile-methodologies)
  * [App Permissions](#app-permissions)
- [Demo & Screenshots](#demo)
- [Wiki](#wiki)
- [Project References](#project-references)
- [License](#license)
- [Connect with me](#connect-with-me)

## Download
**Android 6.0 and above only**
### FAT APK Bundle
- [Download](https://drive.google.com/drive/folders/1HlLm0pWeH9ETQ5cIsXBsXDIgd5tPvsrT?usp=sharing)

### Architecture Specific APK's
- [Download](https://drive.google.com/drive/folders/1zr3_bMxjsstKzExge0ti6x29zryIYrDE?usp=sharing)

**Please refer to the [Guide](https://flutter.dev/docs/deployment/android#building-the-app-for-release) here to know the difference.**
## Features

**Chat Functionality**

* Google Sign In
* **Upto 2000 Active users at same time**
* Create Group / personal chats outside a meeting
* Pin messages.
* Delete / edit messages.
* Photo, Audio, Videos, etc.
* GIFs via GIPHY
* Chat reactions & Emojis.
* Reply on threads.
* Integrated Video rooms.
* User mentions.
* Mute Conversations


**Video Conferencing Functionality**
* Toggle Video / Audio
* Share Screen
* Anonymous Join In
* Raise Hand
* Set Meeting Password
* Share files
* In meet private chat
* Record the meeting
* Share Links
* Broadcast Live
* Low Bandwidth mode
* Minimised mode

**UI / UX**
* Onboarding Screens
* Fully Responsive UI
* Minimalist UI
* Dark / Light Theme

**Complete [Feature List](https://github.com/Karanjot-singh/microsoft_teams_clone/blob/main/docs/Features%20%26%20Screenshots.pdf)**

## Development
### Project Setup
  * Please refer to the [Project setup wiki page](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki#project-setup) for full instructions.

### Coding Style
  * Please refer to the [Coding style wiki page](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki#coding-style--conventions) for full instructions.

### Overview of the codebase
![Untitled (1)](https://user-images.githubusercontent.com/55680995/125423592-534262ae-a1f3-4757-abb7-0e39a2ea97f7.jpg)

  * For more please refer to the [Codebase overview wiki page](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki/Codebase-Overview) for detailed explanation.

### Contributing
  * Please refer to the [Contributor wiki page](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki/Contribute) for steps.

## Implementation

### Technologies Used
- [Flutter](https://flutter.dev/) null safe 2.2.2
- Google Firebase for user authentication
  - [firebase_core](https://pub.dev/packages/firebase_core)
  - [firebase_auth](https://pub.dev/packages/firebase_auth)
  - [google_sign_in](https://pub.dev/packages/google_sign_in)
- Stream Chat SDK for integrated chat functionality
  - [stream_chat_flutter](https://pub.dev/packages/stream_chat_flutter)
  - [stream_chat_persistence](https://pub.dev/packages/stream_chat_persistence)
  - [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
  - [streaming_shared_preferences](https://pub.dev/packages/streaming_shared_preference)
- Jitsi Meet SDK for video meetings & conferences
  - [jitsi_meet](https://pub.dev/packages/firebase_core)
- Other dependencies in ```pubspec.yaml```

### Agile Methodologies

- Agile software development refers to a group of software development methodologies based on iterative development, where requirements and solutions evolve through collaboration between self-organizing cross-functional teams.

![scrum-1](https://user-images.githubusercontent.com/55680995/125426790-39644a1f-c45e-4f37-8c0f-04e7934c2295.png)

  * This application follows the [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) & the repository is
    maintained following [Agile Methodologies](https://www.atlassian.com/agile) and [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

    ![image](https://user-images.githubusercontent.com/55680995/125493294-18bcb908-d230-4790-bbc4-7b9acffe65d9.png)


 - Hence, the development of this project was iterative: Design, Code, Redesign, Fix Errors. All new features were created using new git branches and merged into main from time to time. [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
 - Issues, ideas and TOODs were tracked using a board for each sprint - Design, Build & Adapt


### App Permissions
- Internet access
- Access to camera
- Access to microphone
- Access to Storage

## Demo
Click to play

[![Demo](https://user-images.githubusercontent.com/55680995/125494808-c6d0e73e-3ade-4e2e-8a07-b9da101e6068.png)](https://youtu.be/gfOrD80Qvcc)

**- [Screenshots](https://github.com/Karanjot-singh/microsoft_teams_clone/blob/main/docs/Features%20%26%20Screenshots.pdf)**
## Project References
- [Flutter API reference](https://api.flutter.dev/index.html)
- [Stream Chat Flutter Docs](https://getstream.io/chat/docs/flutter-dart/)
- [pub.dev API reference](https://pub.dev/packages/stream_chat_flutter/versions/2.0.0-nullsafety.7)
- [Flutter Samples](https://github.com/GetStream/flutter-samples)
- [Undraw](https://undraw.co/)
- Special Thanks to @imtoori (Stream SDK Devloper) for helping me throughout this project.

## Wiki
Please head to the [Wiki page](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki) here.

## License

Microsoft Teams Clone is released under the [MIT License](https://github.com/Karanjot-singh/microsoft_teams_clone/blob/main/LICENSE).

## Connect with me
Drop by and say hello!

[<img height="30" src="https://img.shields.io/badge/linkedin-0077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" />][LinkedIn]
[<img height="30" src="https://img.shields.io/badge/twitter-1DA1F2.svg?&style=for-the-badge&logo=twitter&logoColor=white" />][twitter]

[linkedIn]: https://www.linkedin.com/in/karanjot-singh-
[twitter]: https://twitter.com/Rocketsingh06

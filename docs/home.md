## Welcome to Microsoft Teams Wiki

Microsoft Teams Clone is a Video conference application with a rich integrated chat experience, to connect with friends,family & colleagues.
Developed as a redesign of Microsoft Teams during my menteeship at [Microsoft Engage 2021](https://microsoft.acehacker.com/engage2021/index.html)

## Coding Style & Conventions

  * This application follows the [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) & the repository is 
    maintained following [Agile Methodologies](https://www.atlassian.com/agile) and [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
## Overview of the codebase
  * Please refer to the [Codebase overview wiki page](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki#coding-style--conventions) for detailed explanation.

## Project Setup

Before running this project please ensure Flutter is installed and configured on your machine. If you're new to Flutter, please checkout the [official guide](https://flutter.dev/docs/get-started/install) with installation instructions for your OS. 

This project is only configured to support the following platforms:

- Android
- iOS

Web and Desktop are not supported at this time. 

After installing Flutter and the necessary toolchain for your device (Android or iOS), connect your device or open your emulator before running the following:

**Clone the repo**

```bash
git clone https://https://github.com/Karanjot-singh/microsoft_teams_clone/
```

**Open the app folder** 

```bash
cd microsoft_teams_clone
```

**Install package dependencies:**

```bash
flutter packages get 
```

**Open or create an emulator**

```bash
# To run an emulator, run 'flutter emulators --launch <emulator id>'.
# To create a new emulator, run 'flutter emulators --create [--name xyz]'.
# You can find more information on managing emulators at the links below:
# [https://developer.android.com/studio/run/managing-avds](https://developer.android.com/studio/run/managing-avds)[https://developer.android.com/studio/command-line/avdmanager](https://developer.android.com/studio/command-line/avdmanager)
```

**Run the project on your device or emulator:**

```bash
flutter run 
```

## Setup Stream Chat SDK
- Sign up for an account [here](https://getstream.io/chat/)
- Follow the guide [here](https://getstream.io/chat/flutter/tutorial/#flutter-chat-sdk-setup)
- Login to your dashboard and configure your project.

## Setup Google Firebase
- Please refer to the [Official guide](https://firebase.google.com/docs/flutter/setup?platform=ios) here.

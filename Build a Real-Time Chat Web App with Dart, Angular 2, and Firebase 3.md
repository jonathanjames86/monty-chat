In this tutorial, you're going to build a real-time chat web app that supports Google authentication and both text and image messages, and you're going to do it without writing a single line of server-side code. "But how?" you may exclaim. [Dart](https://www.dartlang.org/), with its comprehensive core libraries and well-honed syntax, combined with the awesome power of [Firebase](https://firebase.google.com/), an application platform with a real-time database, authentication, file storage, and static hosting. That's how!

Oh, and let's not forget that the app will be structured by everyone's favorite framework, [Angular 2](https://angular.io/). With such a structure in place, it will be easy to maintain and expand the code to create a more full-featured chat app. It will also save you from having to write lots of DOM-manipulation code, and it will divide up code tasks into services and components to maximize reusability.

The code was tested with Dart SDK 1.19.0 and Angular Dart 2.0.0-beta.20.

## Credit
This tutorial was modeled after the JavaScript version appearing here: [Firebase: Build a Real Time Web Chat App](https://codelabs.developers.google.com/codelabs/firebase-web/).

## What You'll Learn

- Sync data using the Firebase Realtime Database and Firebase Storage.
- Authenticate your users using Firebase Auth.
- Deploy your web app on Firebase static hosting.
- Create a web app using the Angular 2 framework.

## What You Won't Learn

This is an intermediate tutorial intended for those who are familiar with basic programming concepts and HTML/CSS. We will not spend time on these topics, instead focusing on Angular 2 and Firebase.

## The Stack

### Dart
[Dart](https://www.dartlang.org) is an open-source, scalable, object-oriented programming language, with robust libraries and runtimes, for building web, server, and mobile apps. It was originally developed by Google, but has since become an [ECMA standard](http://www.ecma-international.org/publications/standards/Ecma-408.htm).

#### Dart Primers
Check out the [Dart Language Tour](https://www.dartlang.org/guides/language/language-tour) for a crash course in the Dart language. If you already know JavaScript, Java, PHP, ActionScript, C/C++/C#, or another "curly brace" language, you'll find Dart to be familiar, and you can be productive with Dart within an hour or so.

If you like learning from videos, take a look at [Learn Dart in One Video](https://www.youtube.com/watch?v=OLjyCy-7U2U&feature=autoshare).

#### Get Dart
Before you can get into the exciting world of writing Dart code, you need to download the Dart <abbr title="Software Development Kit">SDK</abbr> and, for web apps, a special browser called [Dartium](https://webdev.dartlang.org/tools/dartium):

 - [Dart SDK and Dartium](https://www.dartlang.org/downloads/)
     - On Windows? Try the [Dart for Windows](http://www.gekorm.com/dart-windows/) installer, or use [Chocolatey](https://www.dartlang.org/downloads/windows.html).
     - On Mac? Use [Homebrew](https://www.dartlang.org/downloads/mac.html).
     - On Linux? Use [apt-get or the Dart Debian package](https://www.dartlang.org/downloads/linux.html).
     - [Dart-Up](https://www.npmjs.com/package/dart-up) is a great option for Windows, Mac, or Linux.
     
#### Dart Tools and IDEs
For ideas on what editor you should use to work on a Dart project, or to learn more about Dart's awesome suite of developer tools, check out the [Dart Tools](https://www.dartlang.org/tools) page. Note that since you need to import external libraries for this project, you will not be able to use the online [DartPad](https://www.dartlang.org/tools/dartpad) environment.

### Angular 2
[Angular 2](https://angular.io) is the much anticipated successor to the popular Angular web application framework, featuring many of the same concepts, but with a greatly simplified syntax. The framework is available for Dart, JavaScript, and TypeScript.

#### Other Tutorials
To get an Angular 2 Dart app up and running quickly, try the [5-Minute Quickstart](https://angular.io/docs/dart/latest/quickstart.html) tutorial. There was also a great code lab at Google I/O 2016: [Try the Tech Stack Powering the Next Generation of AdWords](https://codelabs.developers.google.com/codelabs/ng2-dart/index.html).

### Firebase
Firebase is a powerful back-end platform that provides data storage, file storage, user authentication, static hosting, and more. It's Firebase that makes it possible to create a complex, multi-user app with persistent data using so little front-end code. It has APIs for [Android](https://firebase.google.com/docs/database/android/start/), [iOS](https://firebase.google.com/docs/database/ios/start), and [JavaScript](https://firebase.google.com/docs/database/web/start), as well as a [REST API](https://firebase.google.com/docs/database/rest/start). For this project, you'll make use of a thin [Dart wrapper](https://pub.dartlang.org/packages/firebase3) around the JavaScript API.

## The Chat App
The world could always use another chat application, right? Yes! So let's make one. When you're finished, you'll have something that looks like this:

![A screen shot of dart_chat.](http://i.imgur.com/cOSituo.png)

### How It Works
Your chat app will be a web application written with Dart and Angular 2, and it will run in a web browser. During development, you'll run it in [Dartium](https://webdev.dartlang.org/tools/dartium), which is a special build of Chromium that includes the Dart virtual machine. Each running client will post a user's chat messages to a Firebase NoSQL database (sometimes just called a Firebase), and all clients will automatically receive any changes to it. Changes in hand, the client will update the display.

## Step 1: Get the Starter Code
Since this tutorial isn't about HTML, CSS, or UI, you're going to start off with all of that already done.

### Download
Visit the [GitHub repository](https://github.com/montyr75/dart_chat_ng2_fb3_start/) and either clone it or download a ZIP file. You'll see a handy, green _Clone or download_ button on the site to help you with this.

### Open Project and Acquire Dependencies
Open the project in your favorite IDE. If you're using WebStorm (recommended), you need only open the **pubspec.yaml** file and you'll see a _Get dependencies_ link in the upper-right of the editor. Alternatively, this command is available from the file's context menu in the Project panel.

With lesser editors, you can get your dependencies using the command line. Be sure to navigate to your project's root first:

    pub get

## Step 2: Create a Firebase Project and Set Up Your App
Before you can use a Firebase database, you need to log into the Firebase site and create a new project.

### Create Project
In the [Firebase Console](https://console.firebase.google.com/), click on _CREATE NEW PROJECT_. You can name it whatever you like, but it can help to give it the same name as your app. And don't worry! Firebase has a very generous free tier, so it typically won't cost you anything to develop a new app.

![Create a new project.](https://codelabs.developers.google.com/codelabs/firebase-web/img/b956b992f90b2076.png)

### Get Your Web App Credentials
In the Firebase Console, in the _Overview_ section, click the _Add Firebase to your web app_ button.

![Add Firebase to your web app.](https://codelabs.developers.google.com/codelabs/firebase-web/img/7b81812f17feca63.png)

This will reveal an HTML/JavaScript snippet that looks something like this:

![Initialization code.](https://codelabs.developers.google.com/codelabs/firebase-web/img/2d1763dad02edba6.png)

> **Warning!**
> If your `storageBucket` property is empty (`""`), you've just encountered an unfortunate bug. If you close the dialog and re-open it, it will correct itself.

Of course, the values of the properties will be different from those shown here. They will be unique to your project.

### Add the Credentials to Your App

Since we're not dealing with JavaScript here, we can't use this snippet directly, but almost. Simply copy each property's value into the corresponding empty strings inside your Angular service file:

**lib/services/firebase_service.dart**

    fb.initializeApp(
        apiKey: "",
        authDomain: "",
        databaseURL: "",
        storageBucket: ""
    );

We'll go over everything in this file and what it means later. For now, just get your Firebase project's values in there.

### Enable Google Auth
Your chat users are going to use their Google IDs to log into your app, and Firebase is going to help you make that possible. First, you need to enable Google authentication in your Firebase Console.

Click _Auth_ in the left-side navigation, then select the _SIGN-IN METHOD_ tab. Edit the _Google_ provider entry, and you should see something like this:

![Goolge auth.](https://codelabs.developers.google.com/codelabs/firebase-web/img/1e7a17d97761d124.png)

Make sure the _Enable_ switch is turned on, then click _SAVE_.

## Step 3: Install the Firebase Command-Line Interface
In order to host your app on Firebase's servers, you'll need the Firebase command-line interface (CLI). If you're not interested in hosting there, you can skip this step.

In the Firebase Console for your project, go to the _Hosting_ section, click _GET STARTED_, and follow the instructions to download and install the CLI. Note that it's a [NodeJS](https://nodejs.org/en/) app, so you'll need to have installed that already.

![Firebase CLI.](https://codelabs.developers.google.com/codelabs/firebase-web/img/25e5a43c5b6268c7.png)

Once you've got it installed, open a terminal and run:

    firebase version
    
Make sure the response indicates that the version is 3.x.x. If it's 2.x.x, you're using an older Firebase CLI which you've either installed by mistake, or if both versions are on your system, may have precedence in your system PATH.

Next, authorize the Firebase CLI by running:

    firebase login

Now you need to initialize your project for use by the Firebase CLI. From your project's root, run:

    firebase init

You will be asked a series of questions. (Questions from Firebase CLI version 3.0.7.)

1. **Are you ready to proceed?** Yes. (Probably.)
2. **What Firebase CLI feaatures do you want to setup for this folder?** You may deselect `Database: Deploy Firebase Realtime Database Rules`, but you will need the `Hosting` option to be selected.
3. **What Firebase project do you want to associate as default?** Select your project's ID.
4. **What do you want to use as your public directory?** For Dart projects, you'll typically want to enter `build/web` here.
5. **Configure as a single-page app (rewrite all urls to /index.html)?** No.

At this point, the CLI will write a few files to your project's **build** directory, but those will be overwritten by Dart's build process later, anyway.

## Step 4: Run the App
Now it's time to make sure you can run this thing. With a properly set-up WebStorm, this is as easy as choosing _Debug_ from the context menu (right-click, <kbd>Ctrl</kbd>-click, whatever...) of **web/index.html**. That will normally run your project in [Dartium](https://webdev.dartlang.org/tools/dartium), using [Pub Serve](https://webdev.dartlang.org/tools/pub/pub-serve).

If you need to do things the hard way, navigate to your project's root directory in a terminal and run:

    pub serve

By default, Dart's server will run on `localhost:8080`.

To launch Dartium, navigate to its directory in your finder or file explorer and double-click the Chromium executable file.

> **Note:** While this tool is _referred to_ as Dartium, the executable on Mac/Linux is named `Chromium`, and on Windows it's named `chrome.exe`. For instance, if you used Dart for Windows to install the Dart SDK and Dartium, the default path to Dartium would be something like `C:\Program Files\dart\chromium\chrome.exe`. Since you'll be running this often, it might be a good idea to create a desktop shortcut for Dartium (on Windows, right-click your Desktop and select _New_ -> _Shortcut_).

Enter `localhost:8080` into the address bar. If it's your first execution of a new project, be patient as Dart runs transformers on your build. Before long, you should see your running project appear.

The header will look a little goofy just now, but you'll use some Angular features to fix that up soon enough. Also, the UI doesn't do anything yet; you'll add the code for that in upcoming steps.
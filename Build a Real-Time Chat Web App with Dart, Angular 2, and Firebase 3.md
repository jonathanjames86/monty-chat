In this tutorial, you're going to build a real-time chat web app that supports Google authentication and both text and image messages, and you're going to do it without writing a single line of server-side code. "But how?" you may exclaim. [Dart](https://www.dartlang.org/), with its comprehensive core libraries and well-honed syntax, combined with the awesome power of [Firebase](https://firebase.google.com/), an application platform with a real-time database, authentication, file storage, and static hosting. That's how!

Oh, and let's not forget that the app will be structured by everyone's favorite framework, [Angular 2](https://angular.io/). With such a structure in place, it will be easy to maintain and expand the code to create a more full-featured chat app. It will also save you from having to write lots of DOM-manipulation code, and it will divide up code tasks into services and components to maximize reusability.

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
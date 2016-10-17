import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase3/firebase.dart' as fb;
import '../models/message.dart';

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefMessages;
  fb.User user;
  List<Message> messages;

  void _newMessage(fb.QueryEvent event) {
  Message msg = new Message.fromMap(event.snapshot.val());
  messages.add(msg);
}

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
    if (user != null) {
      messages = [];
    _fbRefMessages.limitToLast(12).onChildAdded.listen(_newMessage);
}
  }

  Future signIn() async {
  try {
    await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
  }
  catch (error) {
    print("$runtimeType::login() -- $error");
  }
}

void signOut() {
  _fbAuth.signOut();
}


  FirebaseService() {
    fb.initializeApp(
        apiKey: "AIzaSyAApBHjVvZwOpS4rShhyrzYBX__uK8cgaQ",
        authDomain: "dartchat-1ce85.firebaseapp.com",
        databaseURL: "https://dartchat-1ce85.firebaseio.com",
        storageBucket: "dartchat-1ce85.appspot.com"
    );
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
    _fbDatabase = fb.database();
    _fbRefMessages = _fbDatabase.ref("messages");
  }
}

import 'dart:html';

import 'package:angular2/core.dart';

import '../../directives/vu_scroll_down.dart';
import '../../directives/vu_hold_focus.dart';

import '../app_header/app_header.dart';
import '../../services/firebase_service.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [AppHeader, VuScrollDown, VuHoldFocus],
    providers: const [FirebaseService],
    styleUrls: const ['app_component.css']
)
class AppComponent {
  final FirebaseService fbService;
  String inputText = "";
  AppComponent(FirebaseService this.fbService);

  void sendTextMessage() {
    final rightNow = '${new DateTime.now()}';
    final rightTime = '${DateTime.parse(rightNow)}';
  String messageText = inputText.trim();
    if (messageText.isNotEmpty) {
      fbService.sendMessage(text: messageText, date: rightTime);
      inputText = "";
    }
  }

  void sendImageMessage(FileList files) {
    if (files.isNotEmpty) {
      fbService.sendImage(files.first);
    }
  }
}

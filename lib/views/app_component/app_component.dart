import 'dart:html';

import 'package:angular2/core.dart';

import '../app_header/app_header.dart';
import '../../services/firebase_service.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [AppHeader],
    providers: const [FirebaseService],
    styleUrls: const ['app_component.css']
)
class AppComponent {
  final FirebaseService fbService;
  String inputText = "";
  AppComponent(FirebaseService this.fbService);

  void sendTextMessage() {
  String messageText = inputText.trim();

  if (messageText.isNotEmpty) {
    fbService.sendMessage(text: messageText);
    inputText = "";
  }
}
}

import 'package:flutter/services.dart';

void keyboardHide() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

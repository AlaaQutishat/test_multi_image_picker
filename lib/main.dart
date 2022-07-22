import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_multi_image_picker/domain/utilities/config.dart';
import 'package:test_multi_image_picker/presentation/core/app_widget.dart';

Future<void> serverApiSetup() async {
  try {
    await Config().load();
  } catch (e) {
    if (kDebugMode) {
      print("Error from main function:$e");
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serverApiSetup();
  runApp(const AppWidget());
}

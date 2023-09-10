import 'package:first_app/app_screens/dash.dart';
import 'package:first_app/utils/userPregerences.dart';
import 'package:flutter/material.dart';
import 'app_screens/no_login.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final storage = FlutterSecureStorage();
  // String? existing = await storage.read(key: "userid") ?? "";
  await UserSimplePreferences.init();
  String existing = UserSimplePreferences.getUsername() ?? "";
  print(existing.toString());
  print("--------");

  if (existing.toString().length == 0) {
    print(existing);
    print(existing.runtimeType);
    print("NEW USER---");
    runApp(Registration());
  } else {
    print(existing.toString());
    print(existing.runtimeType.toString());
    print("existing-=-=-=-");
    runApp(dash_screen(existing.toString()));
  }
}

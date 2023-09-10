import 'package:first_app/app_screens/dash.dart';
import 'package:first_app/utils/userPregerences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Registration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Registration();
  }
}

class _Registration extends State<Registration> {
  final userid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Users Verification",
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("Registration"),
            ),
            body: Center(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: userid,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username/mobile no.',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // await storage.write(key: "userid", value: userid.text);
                      // await UserSimplePreferences.init();
                      await UserSimplePreferences.setUsername(userid.text);
                      print(userid.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return dash_screen(
                          userid.text,
                        );
                      }));
                    },
                    child: const Text('Submit'),
                  ),
                )
              ],
            )),
          ),
        ));
  }
}

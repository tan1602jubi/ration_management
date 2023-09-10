import 'package:first_app/app_screens/no_login.dart';
import 'package:first_app/app_screens/pinfo.dart';
import 'package:first_app/app_screens/usetlist.dart';
import 'package:first_app/utils/userPregerences.dart';
import 'package:flutter/material.dart';

class dash_screen extends StatefulWidget {
  final String user_id;

  const dash_screen(this.user_id);

  @override
  State<StatefulWidget> createState() {
    return _dash_screen();
  }
}

class _dash_screen extends State<dash_screen> {
  String dash_item = "";

  @override
  void initState() {
    print("init state runn");
    String existing = UserSimplePreferences.getUsername() ?? "";
    print(existing);
    Object allKeys = UserSimplePreferences.getallKeys() ?? [];
    Object savedList =
        UserSimplePreferences.getKlist("kinaraList[][]mylist1") ?? [];

    print("Saved info");
    print(allKeys);
    print(savedList);
    super.initState();
  }

  @override
  void remove_login_page() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Registration()),
        (Route<dynamic> route) => false);
  }

  @override
  Future<void> logout() async {
    print("logging out ....");
    await UserSimplePreferences.removeUsername();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Registration();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.redAccent, title: Text("DashBoard")),
          body: Center(
            child: Container(
                // margin: EdgeInsets.all(30),
                child: Column(
              children: [
                // Expanded(
                //     child:

                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 244, 200),
                    border: Border.all(color: Colors.lightBlue, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    crossAxisCount: 2,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          setState(() {
                            dash_item = "Personal Information";
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return personalInfo(widget.user_id);
                          }));
                        },
                        child: const Text('Personal Information'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          print("Tapped a Container");
                          setState(() {
                            dash_item = "My Lists";
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return addListScreen();
                          }));
                        },
                        child: const Text('Kirana Lists'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text("You have just pressed $dash_item"),
                )
              ],
            )),
          ),
          // --------------------drawer------------------------------------
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text("Hello user"),
                ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    logout();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class personalInfo extends StatefulWidget {
  final String user_id;

  const personalInfo(this.user_id);
  @override
  State<StatefulWidget> createState() {
    return _personalInfo();
  }
}

class _personalInfo extends State<personalInfo> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Scaffold(
              appBar: AppBar(title: Text("Personal Information")),
              body: Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('./assets/images/pIcon.png'),
                    ),
                    Text(
                      widget.user_id,
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          print("User Info");
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                      ),
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.lightBlue, width: 2.0),
                            borderRadius: BorderRadius.circular(12)),
                        // BorderRadius.all(Radius.circular(10.0))),

                        child: Row(children: <Widget>[
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                // ignore: prefer_const_constructors
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),
                              ],
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Text("Firstname",
                                textAlign: TextAlign.center),
                          ),
                        ]))
                  ],
                ),
              ),
            ));
  }
}

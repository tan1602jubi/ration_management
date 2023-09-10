import 'package:editable/editable.dart';
import 'package:first_app/utils/userPregerences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _addListScreen();
  }
}

class _addListScreen extends State<StatefulWidget> {
  int itemPresent = 0;
  bool deleteButton = false;
  List<bool> selected = [];
  late List existingList;
  List current_list_row = [];
  List current_list_col = [
    {"title": "Item", "widthFactor": 0.2, "index": 1, "key": "item"},
    {"title": "Price", "widthFactor": 0.2, "index": 2, "key": "price"},
    {"title": "Expiry Date", "widthFactor": 0.2, "index": 3, "key": "expiry"},
  ];

  void deleteItems(List updatedList) {
    // List<String>.from(processedList);
    UserSimplePreferences.setKlist(List<String>.from(updatedList), "mylist1");
  }

  void set_current_list() {
    List latestList =
        UserSimplePreferences.getKlist("kinaraList[][]mylist1") ?? [];
    existingList = latestList;
    current_list_row = latestList.map((item) {
      var today = DateTime.now().microsecondsSinceEpoch;
      var expiryTime = int.parse(item.split('|#|')[2]);
      var index = latestList.indexOf(item);
      if (expiryTime - today < 0) {
        print("expired!!!");
        selected.insert(index, true);
        deleteButton = true;
      } else {
        selected.insert(index, false);
      }
      return {
        "item": item.split('|#|')[0],
        "price": item.split('|#|')[1],
        "expiry": DateTime.fromMicrosecondsSinceEpoch(expiryTime)
            .toString()
            .split(" ")[0]
      };
    }).toList();
    itemPresent = current_list_row.length;
  }

  @override
  void initState() {
    set_current_list();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Kirana Lists"),
          ),
          body: Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("New List to be added");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return createList();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                          color: Colors.pink, // Set border color
                          width: 2.0), // Set border width
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text("Add New Item"),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text("Non Expired and remiaing Items"),
                        Visibility(
                            visible: deleteButton,
                            child: GestureDetector(
                              onTap: () {
                                print(selected);
                                print(existingList);
                                print("Delete items");

                                for (var selInd in selected) {
                                  if (selInd == true) {
                                    var removeItem =
                                        existingList[selected.indexOf(selInd)];
                                    existingList.remove(removeItem);
                                  }
                                }
                                print(existingList);
                                deleteItems(existingList);
                                setState(() {
                                  initState();
                                });
                              },
                              child: Icon(Icons.delete),
                            ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Expiry Date')),
                        ],
                        rows: List<DataRow>.generate(
                            itemPresent,
                            (index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(
                                          current_list_row[index]["item"])),
                                      DataCell(Text(
                                          current_list_row[index]["price"])),
                                      DataCell(Text(
                                          current_list_row[index]["expiry"])),
                                    ],
                                    selected: selected[index],
                                    onSelectChanged: (bool? value) {
                                      setState(() {
                                        selected[index] = value!;
                                        if (selected.contains(true)) {
                                          deleteButton = true;
                                        } else {
                                          deleteButton = false;
                                        }
                                      });
                                    })))),
              ],
            ),
          ))),
    );
  }
}

//-------------------------------------------------add list-----------------------------------------------

class createList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _createList();
  }
}

class _createList extends State<StatefulWidget> {
  DateTime expiryDate = DateTime.now();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  String itemName = "";
  String item_expiryDate = "";
  String price = "0";
  String listName = "mylist1";
  List listItems = [];

  void saveData(List listItems) {
    List existingList =
        UserSimplePreferences.getKlist("kinaraList[][]mylist1") ?? [];

    var processedList = listItems.map((item) {
      return item["item"] + "|#|" + item["price"] + "|#|" + item["expiry"];
    }).toList();
    var listString = List<String>.from(processedList);
    print(listString);
    UserSimplePreferences.setKlist([...existingList, ...listString], listName);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text("Create New List"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: "Enter Item Name"),
                        onChanged: (value) {
                          setState(() {
                            itemName = value;
                          });
                        },
                        controller: itemNameController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                          decoration:
                              InputDecoration(labelText: "Enter Item Price"),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              price = value;
                            });
                          },
                          controller: itemPriceController),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Set Expiry Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: expiryDate,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() {
                            expiryDate = newDateTime;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          print("add data");
                          print(expiryDate.millisecondsSinceEpoch);
                          print(listItems);
                          // expiryDate = DateTime.now();
                          itemNameController.clear();
                          itemPriceController.clear();
                          listItems.add({
                            "item": itemName,
                            "price": price,
                            "expiry":
                                expiryDate.microsecondsSinceEpoch.toString()
                          });
                        },
                        child: const Text('Add'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          print("saved data");
                          saveData(listItems);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
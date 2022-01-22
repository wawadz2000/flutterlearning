import 'package:flutter/material.dart';
import 'package:flutterlearning/Shared/Components.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var database;
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var TitleController = TextEditingController();
  var TimeController = TextEditingController();

  bool isbutton = false;
  late IconData DIcon = Icons.add;
  @override
  void initState() {
    super.initState();
    CreateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(),
      body: Container(
        child: Text("smg"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isbutton) {
            Navigator.pop(context);
            isbutton = false;
            setState(() {
              DIcon = Icons.add;
            });
          } else {
            ScaffoldKey.currentState!.showBottomSheet((context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextFormField(
                        controller: TitleController,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please add smg';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "label",
                          prefixIcon: Icon(
                            Icons.text_fields,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                       TextFormField(
                        controller: TimeController,
                        keyboardType: TextInputType.datetime,
                        obscureText: false,
                        onTap: (){
                          showTimePicker(
                            context: context, 
                            initialTime: TimeOfDay.now()
                            );
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please add smg';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "time",
                          prefixIcon: Icon(
                            Icons.timer,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ]),
                  ),
                ));
            isbutton = true;
            setState(() {
              DIcon = Icons.remove;
            });
          }
        },
        child: Icon(DIcon),
      ),
    );
  }

  void CreateDatabase() async {
    database = await openDatabase(
      "MyDatabase.db",
      version: 1,
      onCreate: (database, version) {
        print("db has been created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, fullName TEXT, date TEXT)')
            .then((value) {
          print("has been created");
        }).catchError((error) {
          print("a problem in the work :  ${error.toString()}");
        });
      },
      onOpen: (Database) {
        print("db has been opened");
      },
    );
  }

  void InsertToDatabase() {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO  tasks(title, fullName) VALUES("Algeria", "Besadi")')
          .then((value) {
        print("item has been added");
      }).catchError((error) {
        print("error exist :  ${error.toString()}");
      });
      return null;
    });
  }
}

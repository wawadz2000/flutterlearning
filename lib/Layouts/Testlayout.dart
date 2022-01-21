import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var database;
  var ScaffoldKey = GlobalKey<ScaffoldState>();
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
        onPressed: (){
          if (isbutton) {
            Navigator.pop(context);
            isbutton=false;
            setState(() {
              DIcon = Icons.add;
            });
          } else {
            ScaffoldKey.currentState!.showBottomSheet((context) => Container(
                width: double.infinity,
                color: Colors.blue,
                height: 120,
                child: Center(child: Text("has been inserted"),),
              ));
               isbutton=true;
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
    database.transaction((txn){
      txn.rawInsert('INSERT INTO  tasks(title, fullName) VALUES("Algeria", "Besadi")'
      )
      .then((value){
        print("item has been added");
      })
      .catchError((error){
          print("error exist :  ${error.toString()}");
      });
      return null;
    });
    }
}

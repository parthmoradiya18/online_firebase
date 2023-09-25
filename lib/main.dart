import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:online_firebase/view.dart';
import 'package:intl/intl.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  String? id;
  Map? m;

  Home([this.id, this.m]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController hooby = TextEditingController();

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if (widget.id != null) {
      name.text = widget.m!['name'];
      contact.text = widget.m!['contact'];
      email.text = widget.m!['about']['email'];
      data.text = widget.m!['about']['data'];
      hooby.text = widget.m!['about']['hooby'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Firebase"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Enter Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: contact,
                decoration: InputDecoration(
                    labelText: "Enter Contact",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: "Enter Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: data,onTap: () {
                showDatePicker(context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1949),
                  lastDate: DateTime(2025),
                ).then((value) {

                  var month=DateFormat("MM").format(value!);
                  var day=DateFormat("d").format(value!);
                  var year=DateFormat("yyyy").format(value!);
                  String date=month+"/"+day+"/"+year;
                  data.text=date;
                });
                },
                decoration: InputDecoration(
                    labelText: "Enter Birth Of Date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: hooby,
                decoration: InputDecoration(
                    labelText: "Enter Hobby",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (widget.id != null) {
                    DatabaseReference ref = FirebaseDatabase.instance
                        .ref("parth")
                        .child(widget.id!);

                    await ref.set({
                      "name": "${name.text}",
                      "contact": "${contact.text}",
                      "about": {
                        "email": "${email.text}",
                        "data": "${data.text}",
                        "hooby": "${hooby.text}",
                      }
                    });
                  } else {
                    DatabaseReference ref =
                        FirebaseDatabase.instance.ref("parth").push();

                    await ref.set({
                      "name": "${name.text}",
                      "contact": "${contact.text}",
                      "about": {
                        "email": "${email.text}",
                        "data": "${data.text}",
                        "hooby": "${hooby.text}",
                      }
                    });
                  }
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(StadiumBorder(
                        side: BorderSide(
                            color: Colors.orange,
                            width: 3,
                            style: BorderStyle.solid))),
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                child: Text("Submit")),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return view();
              },));
            }, style: const ButtonStyle(
                shape: MaterialStatePropertyAll(StadiumBorder(
                    side: BorderSide(
                        color: Colors.orange,
                        width: 3,
                        style: BorderStyle.solid))),
                backgroundColor: MaterialStatePropertyAll(Colors.black)),child: Text("view")),
          ],
        ),
      ),
    );
  }
}

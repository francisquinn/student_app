import 'package:flutter/material.dart';
import 'package:student_app/model/api.dart';
import 'package:student_app/pages/student_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        child: FutureBuilder(
          future: getStudent(),
          builder: (context, snapshot){
            if (snapshot.data == null){
              return Container(
                child: Center(
                  child: Text('No Students'),
                ),
              );
            } else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    onTap:(){
                      Navigator.push( context,
                        MaterialPageRoute(builder: (context) => StudentPage(snapshot.data[index]))
                      );
                    }
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
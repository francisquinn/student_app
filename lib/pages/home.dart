import 'package:flutter/material.dart';
import 'package:student_app/model/api.dart';
import 'package:student_app/pages/student_page.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int _selectedIndex = 0;
List<Widget> _widgetOptions = <Widget>[
  StudentList(),
  GradePage(),
  ProfilePage(),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: StudentDrawer(),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), title: Text('Grades')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getStudent(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('No Students'),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        leading:
                            Icon(Icons.account_box, color: Colors.greenAccent),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].studentEmail),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StudentPage(snapshot.data[index])));
                        }),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}

class GradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Grade Page'),
      ),
    );
  }
}

class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: getStudent(), // get teacher 
          builder: (context, snapshot){
          DrawerHeader(
            child: Text('Drawer'),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          );
          ListTile(
            title: Text('item 1'),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => ProfilePage()));
            },
          
          );
          },
        ),
      ],
    );
  }
}

/*
return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Text('Drawer'),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        ),
        ListTile(
          title: Text('item 1'),
          onTap: () {
            
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ProfilePage()));
          },
        ),
      ],
    );
    */

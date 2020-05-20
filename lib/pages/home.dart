import 'package:flutter/material.dart';
import 'package:student_app/model/api.dart';
import 'package:student_app/pages/student_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_app/pages/grades.dart';
import 'package:student_app/pages/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int _selectedIndex = 0;
List<BottomNavigationBarItem> bottomNavigationPages (){
  return [
  BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
  BottomNavigationBarItem(icon: Icon(Icons.bookmark), title: Text('Grades')),
  BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile')),
  ];
}

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
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationPages(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        //onTap: _onItemTapped,
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }

  // PageController to manage the sliding pages
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  // build the page that the controller is on
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomePage(),
        GradePage(),
        ProfilePage(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // slide animation when icon is tapped
  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}

// Home page 
class HomePage extends StatelessWidget {
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
                              CupertinoPageRoute(
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
// drawer slider 
class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}
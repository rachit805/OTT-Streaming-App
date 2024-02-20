import 'package:flutter/material.dart';
import 'package:ott/screens/bottom_tabs/channel_screen_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/home_tab.dart';
import 'package:ott/screens/bottom_tabs/home_screen.dart';
import 'package:ott/screens/bottom_tabs/mystuff_screen_tab.dart';
import 'package:ott/screens/bottom_tabs/store_tab.dart';
import 'package:ott/screens/widgets/seachMulti.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> screen = <Widget>[
    HomeScreenTab(),
    ChannelScreenTab(),
    Store_Screen_Tab(),
    MyStuffScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 45,
              height: 40,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => SearchMulti()));
            //   },
            //   icon: Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: screen[_selectedIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    top: BorderSide(color: Colors.transparent),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 300,
                    height: 55,
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      type: BottomNavigationBarType.fixed,
                      selectedLabelStyle: TextStyle(
                        color: Color(0xFFF18847),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      unselectedItemColor: Colors.white,
                      elevation: 10,
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          tooltip: "home",
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.home_filled),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon:
                              // Icon(Icons.line_style),
                              Container(
                            child: Image.asset(
                              "assets/images/channel.png",
                              width: 20,
                              height: 20,
                              color: _selectedIndex == 1
                                  ? Color(0xFFF18847)
                                  : Colors.white,
                            ),
                          ),
                          label: "Channel",
                        ),
                        BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Stack(
                            children: [
                              Positioned(
                                  child:
                                      Icon(Icons.local_grocery_store_rounded)),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    child: Text(
                                      '2',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 6,
                                        fontFamily: 'Arial',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    width: 9,
                                    height: 9,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF27F46),
                                      shape: OvalBorder(),
                                    ),
                                  ))
                            ],
                          ),
                          label: "Store",
                        ),
                        BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          label: "My Stuff",
                          icon: Icon(Icons.person_2_outlined),
                        ),
                      ],
                      currentIndex: _selectedIndex,
                      selectedItemColor: Color(0xFFF18847),
                      iconSize: 20,
                      onTap: _onItemTapped,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

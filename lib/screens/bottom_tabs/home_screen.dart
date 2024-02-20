import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/home_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/kids_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/livetv_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/movies_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/music_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/tvShow_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/anime_tab.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({super.key});

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 10),
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  dividerColor: Colors.black,
                  indicator: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(1.00, -0.08),
                      end: Alignment(-1, 0.08),
                      colors: [Color(0xFFF09047), Color(0xFFF46B45)],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  controller: _tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 0),
                  tabs: [
                    Tab(
                      child: Center(
                        child: Text(
                          'Home',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Movies',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'TV Show',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Music',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Anime',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Kids',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    // Tab(
                    //   child: Center(
                    //     child: Text(
                    //       'Tv Shows',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 12,
                    //         fontFamily: 'Inter',
                    //         fontWeight: FontWeight.w700,
                    //         height: 0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HomeTab(),
                  MoviesTab(),
                  LiveTvTab(),
                  MusicTab(),
                  AnimeTab(),
                  KidsTab(),
                  // TvShowTab()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

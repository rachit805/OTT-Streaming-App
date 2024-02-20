import 'package:flutter/material.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/hollywoodmusic.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/hollywoodMusicDetail.dart';

class SeeAllHollywoodMusic extends StatefulWidget {
  const SeeAllHollywoodMusic({Key? key}) : super(key: key);

  @override
  State<SeeAllHollywoodMusic> createState() => _SeeAllHollywoodMusicState();
}

class _SeeAllHollywoodMusicState extends State<SeeAllHollywoodMusic> {
  late Future<List<HollywoodMusic>> hollywoodMusicList;

  @override
  void initState() {
    super.initState();
    hollywoodMusicList = Api().fetchHollywoodMusicData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFF09047),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<HollywoodMusic>>(
        future: hollywoodMusicList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF09047),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<HollywoodMusic> musicList = snapshot.data!;
            return customGridCard(musicList);
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget customGridCard(List<HollywoodMusic> musicList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.7,
        ),
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          HollywoodMusic music = musicList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicDetailPage(
                    musicList: musicList,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 150,
                      child: Image.network(
                        music.image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    "${music.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF09047),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 120,
            child: Shimmer.fromColors(
              baseColor: Colors.black!,
              highlightColor: Colors.white!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 150,
                          color: Colors.white,
                        ),
                        // SizedBox(height: 8),
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.2,
                        //   height: 16,
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

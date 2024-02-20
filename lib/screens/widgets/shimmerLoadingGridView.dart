import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.7,
        child: Shimmer.fromColors(
          baseColor: Colors.black!,
          highlightColor: Colors.white!,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.7, // Adjust this value as needed
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ))
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
    );
  }
}

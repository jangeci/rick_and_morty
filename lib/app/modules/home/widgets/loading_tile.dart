import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.only(
        bottom: 6,
        left: 12,
        right: 12,
      ),
      child: Card(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              SizedBox(width: 12),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4),
                    Container(
                      margin: const EdgeInsets.only(right: 40),
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 22),
            ],
          ),
        ),
      ),
    );
  }
}

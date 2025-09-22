import 'package:flutter/material.dart';

class SkeletonRefreshWidget extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonRefreshWidget({
    super.key,
    this.width = double.infinity,
    this.height = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[600]
        : Colors.grey[400];

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: width,
      height: height,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300.0,
                    height: 10.0,
                    color: highlightColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: 10.0,
                    color: highlightColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

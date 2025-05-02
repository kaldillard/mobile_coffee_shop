import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPlaceholder extends StatelessWidget {
  const CategoryPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade700,
        highlightColor: Colors.grey.shade600,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5, // Adjust the count based on your needs
          itemBuilder: (context, index) {
            return Container(
              height: 29,
              width: 83,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  }
}

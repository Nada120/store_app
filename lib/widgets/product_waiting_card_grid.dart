import 'package:flutter/material.dart';

class ProductWaitingCardGrid extends StatelessWidget {
  const ProductWaitingCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: (size.width / size.height * 1.2),
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}

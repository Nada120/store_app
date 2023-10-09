import 'package:flutter/material.dart';
import '../helper/colors.dart';
import '../views/search_result_view.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchResultView(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        margin: const EdgeInsets.symmetric(horizontal: 23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 20),
            Text(
              'Search For A Product',
              style: TextStyle(
                color: blueDark2,
              ),
            ),
            SizedBox(width: 30),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              backgroundColor: blueBright3,
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

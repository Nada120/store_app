import 'package:flutter/material.dart';
import '../widgets/categories_name_list.dart';
import '../helper/colors.dart';
import '../services/get_all_categories.dart';

class CategoriesNameListBuilder extends StatelessWidget {
  const CategoriesNameListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetAllCategories().getAllCategoriesNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: blueDark2,
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SliverToBoxAdapter(
              child: CategoriesNameList(categories: snapshot.data!),
            );
          } else {
            return const SliverToBoxAdapter(
              child: SizedBox(),
            );
          }
        });
  }
}

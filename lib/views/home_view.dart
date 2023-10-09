import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/login_view.dart';
import '../widgets/products_card_grid_builder.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_field.dart';
import '../helper/colors.dart';
import '../widgets/categories_name_list_builder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String username = '';

  @override
  void initState() {
    super.initState();
    setUserName();
  }

  void setUserName() async {
    var prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blueBright1,
            blueBright2,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppBar(title: username, context: context),
        body: const CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  CustomSearchField(),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: blueDark2,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CategoriesNameListBuilder(),
            ProductsCardGridBuilder(),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SharedPreferences.getInstance().then((prefs) {
              prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
                (context) => false,
              );
            });
          },
          backgroundColor: blueDark2,
          child: const Icon(
            Icons.logout,
            color: blueBright1,
          ),
        ),
      ),
    );
  }
}

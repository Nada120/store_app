import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../services/get_all_productes.dart';
import '../models/product_model.dart';
import '../helper/colors.dart';
import '../widgets/custom_text_form_field.dart';

class SearchResultView extends StatefulWidget {
  const SearchResultView({super.key});

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  List<ProductModel> results = [];
  bool isSearched = false;

  void searchReasultfunction(String value) async {
    await GetAllProductes().getAllProducts().then((products) {
      setState(() {
        isSearched = true;
        results = products
            .where((element) =>
                element.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBright2,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: blueDark2,
          size: 40,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_circle_left_rounded),
        ),
        elevation: 0,
        backgroundColor: blueBright2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, top: 30),
            color: blueBright2,
            width: double.infinity,
            height: 70,
            child: const Text(
              'Search For A Product',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: blueDark2,
              ),
            ),
          ),
          Container(
            color: blueBright2,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextFormField(
              hintText: 'Find Product',
              elevation: 5,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: CircleAvatar(
                  backgroundColor: blueBright3,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
              onChange: (value) {
                searchReasultfunction(value);
                debugPrint('kkkkkkkkkkkkk $value');
                debugPrint('lllllllllllll ${results.map((e) => e.title)}');
                setState(() {});
              },
              paddingWidth: 20,
              controller: null,
              validateMode: AutovalidateMode.disabled,
              backColor: Colors.white,
              borderRadius: 20,
              validate: (value) {
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          isSearched
              ? results.isEmpty
                  ? Center(
                      child: Text(
                        'No Result Was Matched',
                        style: TextStyle(
                            color: blueDark2.withOpacity(0.4),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 3),
                          child: ListTile(
                            tileColor: Colors.white.withOpacity(0.5),
                            title: Text(
                              results[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            leading: CachedNetworkImage(
                              imageUrl: results[index].image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const SizedBox(
                                width: 40,
                                height: 40,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: blueDark2,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                'assets/error.gif',
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                            ),
                            subtitle: Text(
                              results[index].description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: grey,
                              ),
                            ),
                            trailing: Text(
                              'PRICE ${results[index].price} \$',
                              style: const TextStyle(
                                color: blueBright3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
              : const SizedBox(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

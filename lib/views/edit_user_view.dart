import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/services/update_user.dart';
import 'package:store_app/widgets/custom_button.dart';
import '../models/user_model.dart';
import '../services/get_user_data.dart';
import '../widgets/custom_text_form_field.dart';
import '../helper/colors.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({super.key});

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var validateMode = AutovalidateMode.disabled;
  UserModel? userData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.get('username').toString();
    userData = await GetUserData().getUserData(userName: username);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: blueDark2,
      progressIndicator: const CircularProgressIndicator(
        color: blueDark2,
      ),
      child: Container(
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
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: blueDark2,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: userData != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          hintText: userData!.email,
                          paddingWidth: 0,
                          backColor: Colors.white.withOpacity(0.4),
                          icon: const Icon(Icons.email),
                          controller: emailController,
                          validateMode: validateMode,
                          validate: (value) => null,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: userData!.username,
                          paddingWidth: 0,
                          backColor: Colors.white.withOpacity(0.4),
                          icon: const Icon(Icons.person),
                          controller: userNameController,
                          validateMode: validateMode,
                          validate: (value) => null,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: CustomTextFormField(
                                hintText: userData!.firstName,
                                icon: null,
                                backColor: Colors.white.withOpacity(0.4),
                                paddingWidth: 0,
                                controller: firstNameController,
                                validateMode: validateMode,
                                validate: (value) => null,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: CustomTextFormField(
                                hintText: userData!.lastName,
                                backColor: Colors.white.withOpacity(0.4),
                                paddingWidth: 0,
                                icon: null,
                                controller: lastNameController,
                                validateMode: validateMode,
                                validate: (value) => null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: userData!.password,
                          paddingWidth: 0,
                          backColor: Colors.white.withOpacity(0.4),
                          icon: const Icon(Icons.lock_rounded),
                          validateMode: validateMode,
                          controller: passwordController,
                          validate: (value) => null,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: userData!.phone,
                          paddingWidth: 0,
                          backColor: Colors.white.withOpacity(0.4),
                          icon: const Icon(Icons.phone),
                          controller: phoneController,
                          validateMode: validateMode,
                          validate: (value) => null,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: userData!.address.city,
                          paddingWidth: 0,
                          backColor: Colors.white.withOpacity(0.4),
                          icon: const Icon(Icons.home_filled),
                          controller: cityController,
                          validateMode: validateMode,
                          validate: (value) => null,
                        ),
                        const SizedBox(height: 40),
                        CustomButton(
                            title: 'UPDATE',
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              UpdateUser()
                                  .updateProduct(
                                user: userData!,
                                username: userNameController.text.isEmpty
                                    ? userData!.username
                                    : userNameController.text,
                                password: passwordController.text.isEmpty
                                    ? userData!.password
                                    : passwordController.text,
                                email: emailController.text.isEmpty
                                    ? userData!.email
                                    : emailController.text,
                                firstName: firstNameController.text.isEmpty
                                    ? userData!.firstName
                                    : firstNameController.text,
                                lastName: lastNameController.text.isEmpty
                                    ? userData!.lastName
                                    : lastNameController.text,
                                phone: phoneController.text.isEmpty
                                    ? userData!.phone
                                    : phoneController.text,
                                city: cityController.text.isEmpty
                                    ? userData!.address.city
                                    : cityController.text,
                              )
                                  .then((data) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                        'The Data Was Updated Successfully'),
                                  ),
                                );
                              }).catchError((error) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: red,
                                    content: Text(error.toString()),
                                  ),
                                );
                              });
                            }),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: blueDark2,
                  ),
                ),
        ),
      ),
    );
  }
}

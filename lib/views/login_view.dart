import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/services/get_user_data.dart';
import '../helper/colors.dart';
import '../services/login_user.dart';
import '../views/home_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_avatar_person.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var validateMode = AutovalidateMode.disabled;
  bool isObscure = true;
  bool isLoading = false;

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
          resizeToAvoidBottomInset: true,
          backgroundColor: blueDark1.withOpacity(0.4),
          body: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomAvaterPerson(),
                CustomTextFormField(
                  hintText: 'User Name',
                  icon: const Icon(Icons.person),
                  validateMode: validateMode,
                  controller: userNameController,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter User Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                CustomTextFormField(
                  hintText: 'Password',
                  icon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  iconColor: isObscure ? grey : blueDark2,
                  validateMode: validateMode,
                  controller: passwordController,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  isObscure: isObscure,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  title: 'LOGIN',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });
                      LoginUser()
                          .loginUser(
                        username: userNameController.text,
                        password: passwordController.text,
                      )
                          .then((token) {
                        saveUserName(userNameController.text);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                          (route) => false,
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: red,
                          content: Text(
                            'username or password is incorrect',
                          ),
                        ));
                      });
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        validateMode = AutovalidateMode.always;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveUserName(String username) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    var userData = await GetUserData().getUserData(userName: username);
    prefs.setInt("userId", userData!.id!);
  }
}

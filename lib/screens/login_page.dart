import 'package:cabzing/api_services/api_service.dart';
import 'package:cabzing/screens/home_page.dart';
import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/build_elivated_button_widget.dart';
import 'package:cabzing/widgets/build_text_feild_widget.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController usernameController = TextEditingController(text: "Rabeeh@vk");
  final TextEditingController passwordController = TextEditingController(text: "Rabeeh@000");
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final apiService = ApiService();
      bool success = await apiService.login(
        usernameController.text,
        passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Icons/language_icon.svg',
                          height: 32,
                          width: 32,
                        ),
                         BuildTextWidget(
                          text: "English",
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight / 4.2),
                   BuildTextWidget(
                    text: 'Login',
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                   BuildTextWidget(
                    text: 'Login to your vikn account',
                    fontWeight: FontWeight.w200,
                    fontSize: 18,
                    color: AppColors.light_white,
                  ),
                  Form(
                    child: BuildTextFeildWidget(
                      usernameController: usernameController,
                      passwordController: passwordController,
                      formKey:_formKey ,
                    ),
                  ),
                   BuildTextWidget(
                    text: 'Forgotten Password?',
                    color: AppColors.blue,
                  ),
                  const SizedBox(height: 25),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : BuildElevatedButtonWidget(
                    buttonText: "Sign in",
                    onPressed: _login,
                    borderRadius: 120,
                    suffixIcon: Icons.arrow_forward,
                  ),
                  const SizedBox(height: 80),
                   BuildTextWidget(
                    text: 'Don’t have an Account?',
                    color: AppColors.white,
                  ),
                  BuildTextWidget(
                    text: 'Sign up now!',
                    color: AppColors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

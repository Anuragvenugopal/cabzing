import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildTextFeildWidget extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const BuildTextFeildWidget({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<BuildTextFeildWidget> createState() => _BuildTextFeildWidgetState();
}

class _BuildTextFeildWidgetState extends State<BuildTextFeildWidget> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height / 4.2,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: AppColors.dark_blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextFormField(
                  controller: widget.usernameController,
                  style:  TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:  EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                    hintText: 'Enter your username',
                    hintStyle:  TextStyle(color: AppColors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(
                        'assets/images/Icons/user_icon.svg',
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                 Divider(color: AppColors.grey),
                 Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.passwordController,
                        obscureText: !isPasswordVisible,
                        style:  TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                          border: InputBorder.none,
                          hintText: 'Enter your password',
                          hintStyle:  TextStyle(color: AppColors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'assets/images/Icons/key_round_Icons.svg',
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: IconButtonWidget(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.blue,
                        ),
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cabzing/screens/home_page.dart';
import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/build_bottom_navbar_widget.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:cabzing/widgets/icon_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    void _onTabTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    return Scaffold(backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButtonWidget(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
          },
        ),
        title: BuildTextWidget(
          text: 'booking Page',
          color: AppColors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: BuildTextWidget(
            text: 'booking page',
            color: AppColors.blue,
          )),
        ],
      ),
      bottomNavigationBar:  CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

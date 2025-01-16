import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabzing/utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: AppColors.lite_black,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Icons/home_icon.svg',
            color: selectedIndex == 0 ? AppColors.white : AppColors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Icons/route_icon.svg',
            color: selectedIndex == 1 ? AppColors.white : AppColors.grey,
          ),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Icons/notification_icon.svg',
            color: selectedIndex == 2 ? AppColors.white : AppColors.grey,
          ),
          label: 'Invoices',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Icons/profile_icon.svg',
            color: selectedIndex == 3 ? AppColors.white : AppColors.grey,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
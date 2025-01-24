import 'package:cabzing/screens/booking_page.dart';
import 'package:cabzing/screens/history_page.dart';
import 'package:cabzing/screens/home_page.dart';
import 'package:cabzing/screens/profile_page.dart';
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
      onTap: (index) {
        onTap(index); // Update the state or handle the tap
        _navigateToPage(context, index); // Handle navigation
      },
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/Icons/home_icon.svg',
            selectedIndex == 0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/Icons/route_icon.svg',
            selectedIndex == 1,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/Icons/notification_icon.svg',
            selectedIndex == 2,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/Icons/profile_icon.svg',
            selectedIndex == 3,
          ),
          label: '',
        ),
      ],
    );
  }

  Widget _buildIcon(String assetPath, bool isSelected) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          assetPath,
          color: isSelected ? AppColors.white : AppColors.off_white,
        ),
        if (isSelected)
          Positioned(
            top: 35,
            right: 10,
            child: Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookingPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      default:
        break;
    }
  }
}

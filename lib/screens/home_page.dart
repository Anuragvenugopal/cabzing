import 'package:cabzing/Models/profile_model.dart';
import 'package:cabzing/api_services/api_service.dart';
import 'package:cabzing/screens/booking_page.dart';
import 'package:cabzing/screens/history_page.dart';
import 'package:cabzing/screens/invoice_page.dart';
import 'package:cabzing/screens/profile_page.dart';
import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/build_bottom_navbar_widget.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:cabzing/widgets/chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Bookings',
      'value': '123',
      'subtitle': 'Reserved',
      'iconPath': 'assets/images/list_image1.svg',
      'navigateTo': BookingPage(),
    },
    {
      'title': 'Invoices',
      'value': '10,232.00',
      'subtitle': 'Rupees',
      'iconPath': 'assets/images/list_image2.svg',
      'navigateTo': InvoicePage(),
    },
    {
      'title': 'History',
      'value': '236',
      'subtitle': 'Trips',
      'iconPath': 'assets/images/list_image3.svg',
      'navigateTo': HistoryPage(),
    },
  ];

  int _selectedIndex = 0;



  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isProfileImageLoading = true;
  GetProfileModel? profileModel;

  getProfileData() async {
    final response = await ApiService().getProfile();
    if (response != null) {
      setState(() {
        profileModel = response;
        isProfileImageLoading = false;
      });
    } else {
      print("no data");
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 19),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/images/logos/logo1.svg'),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.lite_black,
                          radius: 32,
                          child: isProfileImageLoading
                              ? CircularProgressIndicator()
                              : SizedBox(),
                          backgroundImage: !isProfileImageLoading
                              ? NetworkImage(profileModel?.customerData?.photo ?? "")
                              : null,
                        ),
                        Positioned(
                          top: 5,
                          left: 50,
                          child: Container(
                            height: 15,
                            width: 17,
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Container(
                height: screenHeight / 2.5,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.lite_black,
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildTextWidget(
                          text: 'SAR',
                          color: AppColors.light_white,
                        ),
                        BuildTextWidget(
                          text: ' 2,78,000.00',
                          color: AppColors.white,
                        ),
                        Spacer(),
                        BuildTextWidget(
                          text: 'Revenue',
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BuildTextWidget(
                          text: '+21%',
                          color: AppColors.green,
                          fontWeight: FontWeight.w400,
                        ),
                        BuildTextWidget(
                          text: '  than last month.',
                          color: AppColors.light_white,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Expanded(
                      child: AreaChartWidget(),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item['navigateTo']),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6.6,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: AppColors.lite_black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: AppColors.lite_black,
                            ),
                            child: SvgPicture.asset(
                              item['iconPath'],
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['title'],
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item['value'],
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item['subtitle'],
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.lite_black1,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(25),
                              child: SvgPicture.asset(
                                'assets/images/Icons/arrow-down.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:  CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}



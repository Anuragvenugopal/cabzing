import 'package:cabzing/Models/profile_model.dart';
import 'package:cabzing/api_services/api_service.dart';
import 'package:cabzing/screens/login_page.dart';
import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/build_elivated_button_widget.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GetProfileModel? profileModel;

  getProfileData()async{
    final response = await    ApiService().getProfile();
    if(response!=null) {
      setState(() {
        profileModel = response;
      });
    }else{
      print("no data");
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }


  Future<void> fetchUserProfile({required String token}) async {

  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> menuItems = [
      {'icon': 'assets/images/Icons/help_icon.svg', 'text': 'Help'},
      {'icon': 'assets/images/Icons/faq_icon.svg', 'text': 'FAQ'},
      {'icon': 'assets/images/Icons/invite_icon.svg', 'text': 'Invite Friends'},
      {
        'icon': 'assets/images/Icons/terms_and_service.svg',
        'text': 'Terms of Service'
      },
      {
        'icon': 'assets/images/Icons/privacy_icon.svg',
        'text': 'Privacy Policy'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: screenHeight / 2.3,
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
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33),
                            color: AppColors.black,
                            image: DecorationImage(
                              image: NetworkImage(profileModel?.customerData?.photo??""),fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 18,top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildTextWidget(
                                  text: profileModel?.data?.firstName?? '',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 5),
                                BuildTextWidget(
                                  text:  profileModel?.data?.email?? '',
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, ),
                          child: SvgPicture.asset(
                              'assets/images/Icons/edit_icon.svg'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          height: 105,
                          width: screenWidth / 2.6,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/rides_image.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BuildTextWidget(
                                      text: '4.3 ★',
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    BuildTextWidget(
                                      text: '2,211',
                                      color: AppColors.light_white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    BuildTextWidget(
                                      text: 'rides',
                                      color: AppColors.purple,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 13),
                        Container(
                          height: 105,
                          width: screenWidth / 2.6,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration:  BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/kyc_images.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        BuildTextWidget(
                                          text: 'KYC',
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        const SizedBox(width: 5),
                                        Image.asset(
                                          'assets/images/Icons/tik_icon.png',
                                          height: 15,
                                          width: 15,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                    BuildTextWidget(
                                      text: 'Verified',
                                      color: AppColors.light_green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    BuildElevatedButtonWidget(
                      buttonText: "Logout",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      width: screenWidth,
                      height: 62,
                      borderRadius: 174,
                      backgroundColor: AppColors.black,
                      textColor: AppColors.red,
                      svgPrefixIcon: 'assets/images/Icons/logot_icon.svg',
                    )
                  ],
                ),
              ),
              Container(
                height: screenHeight / 2.5,
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return ListTile(
                      leading: SvgPicture.asset(
                        item['icon'],
                        width: 24.0,
                        height: 24.0,
                      ),
                      title: Text(
                        item['text'],
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      trailing:
                      Icon(Icons.arrow_forward_ios, color: AppColors.white),
                      onTap: () {},
                    );
                  },
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

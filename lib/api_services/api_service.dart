
import 'package:cabzing/Models/get_sale_list_response_model.dart';
import 'package:cabzing/Models/post_sale_list_request_model.dart';
import 'package:cabzing/utils/hive.dart';
import 'package:dio/dio.dart';
import 'package:cabzing/Models/profile_model.dart';

class ApiService {
  static const String loginUrl = 'https://api.accounts.vikncodes.com/api/v1/users/login';
  static const String profileUrl = 'https://www.api.viknbooks.com/api/v10/users/user-view/62/';
  static const String saleListUrl = 'https://www.api.viknbooks.com/api/v10/sales/sale-list-page/';

  Future<bool> login(String username, String password) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        loginUrl,
        data: {
          "username": username,
          "password": password,
          "is_mobile": true
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print('hi' * 100);
        print(data);
        print(response.data['data']['access']);
        print("response.data['data']['access']");
        // print('Login successful: ${data['access']}');
        await AppHive().putToken(token: response.data['data']['access']);
        return true;
      } else {
        print('Login failed: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }


  Future<GetProfileModel?> getProfile() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        profileUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppHive().getToken()}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        print("profile data");
        final profileModel = GetProfileModel.fromJson(response.data);
        print(profileModel.data?.username);
        print("profileModel.data?.username");
        print('Profile data retrieved successfully');
        return profileModel;
      } else {
        print('Failed to retrieve profile: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error during profile fetch: $e');
      return null;
    }
  }


  Future<GetSaleListResponseModel?> getSaleList({required PostSaleListRequestModel postSaleListRequestModel})async{
    try {
      final dio = Dio();
      final response = await dio.post(
        saleListUrl,
        data: postSaleListRequestModel.toJson(),
        options: Options(headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${AppHive().getToken()}',}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print('db' * 100);
        print(data);
        final saleListResponse =GetSaleListResponseModel.fromJson(data);
        return saleListResponse;
      } else {
        print('Login failed: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }


}
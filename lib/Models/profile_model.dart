// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
  final int? statusCode;
  final Data? data;
  final CustomerData? customerData;

  GetProfileModel({
    this.statusCode,
    this.data,
    this.customerData,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    statusCode: json["StatusCode"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    customerData: json["customer_data"] == null ? null : CustomerData.fromJson(json["customer_data"]),
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "data": data?.toJson(),
    "customer_data": customerData?.toJson(),
  };
}

class CustomerData {
  final DateTime? dateOfBirth;
  final String? country;
  final int? phone;
  final String? state;
  final dynamic city;
  final String? address;
  final String? photo;
  final String? countryName;
  final String? stateName;

  CustomerData({
    this.dateOfBirth,
    this.country,
    this.phone,
    this.state,
    this.city,
    this.address,
    this.photo,
    this.countryName,
    this.stateName,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    dateOfBirth: json["DateOfBirth"] == null ? null : DateTime.parse(json["DateOfBirth"]),
    country: json["Country"],
    phone: json["Phone"],
    state: json["State"],
    city: json["City"],
    address: json["Address"],
    photo: json["photo"],
    countryName: json["CountryName"],
    stateName: json["StateName"],
  );

  Map<String, dynamic> toJson() => {
    "DateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "Country": country,
    "Phone": phone,
    "State": state,
    "City": city,
    "Address": address,
    "photo": photo,
    "CountryName": countryName,
    "StateName": stateName,
  };
}

class Data {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;

  Data({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "email": email,
  };
}

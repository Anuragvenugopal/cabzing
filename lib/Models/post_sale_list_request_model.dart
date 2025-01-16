// To parse this JSON data, do
//
//     final postSaleListRequestModel = postSaleListRequestModelFromJson(jsonString);

import 'dart:convert';

PostSaleListRequestModel postSaleListRequestModelFromJson(String str) => PostSaleListRequestModel.fromJson(json.decode(str));

String postSaleListRequestModelToJson(PostSaleListRequestModel data) => json.encode(data.toJson());

class PostSaleListRequestModel {
  final int? branchId;
  final String? companyId;
  final String? createdUserId;
  final int? priceRounding;
  final int? pageNo;
  final int? itemsPerPage;
  final String? type;
  final int? warehouseId;

  PostSaleListRequestModel({
    this.branchId,
    this.companyId,
    this.createdUserId,
    this.priceRounding,
    this.pageNo,
    this.itemsPerPage,
    this.type,
    this.warehouseId,
  });

  factory PostSaleListRequestModel.fromJson(Map<String, dynamic> json) => PostSaleListRequestModel(
    branchId: json["BranchID"],
    companyId: json["CompanyID"],
    createdUserId: json["CreatedUserID"],
    priceRounding: json["PriceRounding"],
    pageNo: json["page_no"],
    itemsPerPage: json["items_per_page"],
    type: json["type"],
    warehouseId: json["WarehouseID"],
  );

  Map<String, dynamic> toJson() => {
    "BranchID": branchId,
    "CompanyID": companyId,
    "CreatedUserID": createdUserId,
    "PriceRounding": priceRounding,
    "page_no": pageNo,
    "items_per_page": itemsPerPage,
    "type": type,
    "WarehouseID": warehouseId,
  };
}

// To parse this JSON data, do
//
//     final getSaleListResponseModel = getSaleListResponseModelFromJson(jsonString);

import 'dart:convert';

GetSaleListResponseModel getSaleListResponseModelFromJson(String str) =>
    GetSaleListResponseModel.fromJson(json.decode(str));

// String getSaleListResponseModelToJson(GetSaleListResponseModel data) =>
//     json.encode(data.toJson());

class GetSaleListResponseModel {
  final int? statusCode;
  final List<Datum>? data;
  final int? totalCount;

  GetSaleListResponseModel({
    this.statusCode,
    this.data,
    this.totalCount,
  });

  factory GetSaleListResponseModel.fromJson(Map<String, dynamic> json) =>
      GetSaleListResponseModel(
        statusCode: json["StatusCode"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalCount: json["total_count"],
      );

// Map<String, dynamic> toJson() => {
//       "StatusCode": statusCode,
//       "data": data == null
//           ? []
//           : List<dynamic>.from(data!.map((x) => x.toJson())),
//       "total_count": totalCount,
//     };
}

class Datum {
  final int? index;
  final String? id;
  final String? voucherNo;
  final DateTime? date;
  final String? ledgerName;
  final double? totalGrossAmtRounded;
  final double? totalTaxRounded;
  final double? grandTotalRounded;
  final String? customerName;
  final double? totalTax;
  final String? status;
  final double? grandTotal;
  final bool? isBillwised;
  final BillwiseStatus? billwiseStatus;

  Datum({
    this.index,
    this.id,
    this.voucherNo,
    this.date,
    this.ledgerName,
    this.totalGrossAmtRounded,
    this.totalTaxRounded,
    this.grandTotalRounded,
    this.customerName,
    this.totalTax,
    this.status,
    this.grandTotal,
    this.isBillwised,
    this.billwiseStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    index: json["index"],
    id: json["id"],
    voucherNo: json["VoucherNo"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    ledgerName: json["LedgerName"],
    totalGrossAmtRounded: json["TotalGrossAmt_rounded"]?.toDouble(),
    totalTaxRounded: json["TotalTax_rounded"]?.toDouble(),
    grandTotalRounded: json["GrandTotal_Rounded"]?.toDouble(),
    customerName: json["CustomerName"],
    totalTax: json["TotalTax"]?.toDouble(),
    status: json["Status"],
    grandTotal: json["GrandTotal"]?.toDouble(),
    isBillwised: json["is_billwised"],
    billwiseStatus: billwiseStatusValues.map[json["billwise_status"]],
  );

//   Map<String, dynamic> toJson() => {
//         "index": index,
//         "id": id,
//         "VoucherNo": voucherNo,
//         "Date":
//             "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//         "LedgerName": ledgerName,
//         "TotalGrossAmt_rounded": totalGrossAmtRounded,
//         "TotalTax_rounded": totalTaxRounded,
//         "GrandTotal_Rounded": grandTotalRounded,
//         "CustomerName": customerName,
//         "TotalTax": totalTax,
//         "Status": status,
//         "GrandTotal": grandTotal,
//         "is_billwised": isBillwised,
//         "billwise_status": billwiseStatusValues.reverse[billwiseStatus],
//       };
}

enum BillwiseStatus { PAID, UNPAID }

final billwiseStatusValues =
EnumValues({"paid": BillwiseStatus.PAID, "unpaid": BillwiseStatus.UNPAID});

// enum ErName {
//   CASH_IN_HAND,
//   JASMAL
// }
//
// final erNameValues = EnumValues({
//   "Cash In Hand": ErName.CASH_IN_HAND,
//   "Jasmal": ErName.JASMAL
// });
//
// enum Status {
//   INVOICED
// }
//
// final statusValues = EnumValues({
//   "Invoiced": Status.INVOICED
// });

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

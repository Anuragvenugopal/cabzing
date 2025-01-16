import 'package:cabzing/Models/get_sale_list_response_model.dart';
import 'package:cabzing/Models/post_sale_list_request_model.dart';
import 'package:cabzing/api_services/api_service.dart';
import 'package:cabzing/screens/add_filters_page.dart';
import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:cabzing/widgets/icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final List<Map<String, dynamic>> invoices = [
    {
      'status': 'Pending',
      'customerName': 'Customer Name 1',
      'amount': 'SAR. 10,000.00',
      'statusColor': Colors.red,
    },
    {
      'status': 'Invoiced',
      'customerName': 'Customer Name 2',
      'amount': 'SAR. 10,000.00',
      'statusColor': Colors.blue,
    },
    {
      'status': 'Cancelled',
      'customerName': 'Customer Name 3',
      'amount': 'SAR. 10,000.00',
      'statusColor': Colors.grey,
    },
    {
      'status': 'Pending',
      'customerName': 'Customer Name 4',
      'amount': 'SAR. 10,000.00',
      'statusColor': Colors.red,
    },
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredInvoices = [];
  GetSaleListResponseModel?getSaleListResponseModel;

  getSaleListData()async{
   final respons= await ApiService().getSaleList(postSaleListRequestModel: PostSaleListRequestModel(
      branchId: 1,
      companyId: "1901b825-fe6f-418d-b5f0-7223d0040d08",
      createdUserId: "62",
      priceRounding: 2,
      pageNo: 1,
      itemsPerPage: 10,
      type: "Sales",
      warehouseId: 1
    ));
   setState(() {
     getSaleListResponseModel=respons;

   });
  }

  @override
  void initState() {
    super.initState();
    getSaleListData();
    filteredInvoices = invoices;
  }

  void filterInvoices() {
    setState(() {
      filteredInvoices = invoices
          .where((invoice) =>
      invoice['customerName']
          .toLowerCase()
          .contains(searchController.text.toLowerCase()) ||
          invoice['status']
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButtonWidget(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: BuildTextWidget(
          text: 'Invoices',
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Divider(color: AppColors.light_grey),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.dark_blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: IconButtonWidget(
                            icon: Icon(
                              Icons.search,
                              color: AppColors.white,
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              filterInvoices();
                            },
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: AppColors.grey),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.grey_off,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddFiltersPage()),
                      );
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: SvgPicture.asset(
                              'assets/images/Icons/filter_icon.svg'),
                        ),
                        BuildTextWidget(
                          text: 'Add Filters',
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.light_grey),
            Expanded(
              child: ListView.builder(
                itemCount: getSaleListResponseModel?.data?.length,
                itemBuilder: (context, index) {
                  // final invoice = filteredInvoices[index];
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            BuildTextWidget(
                              text:getSaleListResponseModel?.data?[index].voucherNo??'no data',
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                            Spacer(),
                            BuildTextWidget(
                              text: getSaleListResponseModel?.data?[index].status??"",
                              color: getSaleListResponseModel?.data?[index].status=="Invoiced"?AppColors.blue:getSaleListResponseModel?.data?[index].status=="Cancelled"?AppColors.grey:AppColors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                BuildTextWidget(
                                  text: getSaleListResponseModel?.data?[index].customerName??'no data',
                                  color: AppColors.grey,
                                  fontSize: 14,
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                            BuildTextWidget(
                              text: getSaleListResponseModel?.data?[index].grandTotalRounded?.toString()??"",
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: AppColors.light_grey),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

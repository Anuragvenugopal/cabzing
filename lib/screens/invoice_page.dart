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
  TextEditingController searchController = TextEditingController();


  List<Map<String, dynamic>> filteredInvoices = [];
  List<Map<String, dynamic>> allInvoices = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  bool hasMore = true;
  int currentPage = 1;
  final int itemsPerPage = 10;
  @override
  void initState() {
    super.initState();
    getSaleListData();
    searchController.addListener(filterInvoices);

  }


  Future<void> getSaleListData({bool isLoadMore = false}) async {
    if (isLoadingMore) return;

    setState(() {
      if (isLoadMore) {
        isLoadingMore = true;
      } else {
        isLoading = true;
      }
    });

    try {
      final response = await ApiService().getSaleList(
        postSaleListRequestModel: PostSaleListRequestModel(
          branchId: 1,
          companyId: "1901b825-fe6f-418d-b5f0-7223d0040d08",
          createdUserId: "62",
          priceRounding: 2,
          pageNo: 20,
          itemsPerPage: itemsPerPage,
          type: "Sales",
          warehouseId: 1,
        ),
      );

      setState(() {
        if (response?.data != null && response!.data!.isNotEmpty) {
          allInvoices.addAll(response.data!.map((invoice) => {
            'voucherNo': invoice.voucherNo,
            'status': invoice.status,
            'customerName': invoice.customerName,
            'grandTotalRounded': invoice.grandTotalRounded,
          }));
          filteredInvoices = allInvoices;
          currentPage++;
        } else {
          hasMore = false;
        }
      });
    } catch (e) {
      print('Error fetching sale list: $e');
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }




  void filterInvoices() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredInvoices = allInvoices
          .where((invoice) {
        final customerName = invoice['customerName']?.toLowerCase() ?? '';
        final status = invoice['status']?.toLowerCase() ?? '';
        final voucherNo = invoice['voucherNo']?.toLowerCase() ?? '';
        return customerName.contains(query) ||
            status.contains(query) ||
            voucherNo.contains(query);
      })
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
                          child: SvgPicture.asset('assets/images/Icons/filter_icon.svg'),
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
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              )
                  : filteredInvoices.isEmpty
                  ? Center(
                child: BuildTextWidget(
                  text: 'No invoices found.',
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              )
                  : NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                      hasMore &&
                      !isLoadingMore) {
                    getSaleListData(isLoadMore: true);
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: filteredInvoices.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == filteredInvoices.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.blue,
                          ),
                        ),
                      );
                    }

                    final invoice = filteredInvoices[index];
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              BuildTextWidget(
                                text: invoice['voucherNo'] ?? 'No Data',
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                              Spacer(),
                              BuildTextWidget(
                                text: invoice['status'] ?? "",
                                color: invoice['status'] == "Invoiced"
                                    ? AppColors.blue
                                    : invoice['status'] == "Cancelled"
                                    ? AppColors.grey
                                    : AppColors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
                                    text: invoice['customerName'] ?? 'No Data',
                                    color: AppColors.grey,
                                    fontSize: 14,
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                              BuildTextWidget(
                                text: invoice['grandTotalRounded']?.toString() ?? "",
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
            ),
          ],
        ),
      ),
    );
  }
}

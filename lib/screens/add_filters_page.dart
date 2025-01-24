import 'package:cabzing/utils/app_colors.dart';
import 'package:cabzing/widgets/build_drop_down_button_form_widget.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:cabzing/widgets/icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFiltersPage extends StatefulWidget {
  const AddFiltersPage({super.key});

  @override
  State<AddFiltersPage> createState() => _AddFiltersPageState();
}

class _AddFiltersPageState extends State<AddFiltersPage> {
  String selectedDateRange = 'This Month';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String selectedStatus = 'Pending';
  String selectedCustomer = 'savad farooque';

  final List<String> dateRangeOptions = ['This Month', 'Last Month', 'Custom'];
  final List<String> statusOptions = ['Pending', 'Invoiced', 'Cancelled'];
  final List<String> customers = ['savad farooque', 'Anurag', 'Anjoom'];

  void _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  void _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        title:
        BuildTextWidget(text:'Filters',color: AppColors.white,),
        actions: [
          TextButton(
            onPressed: () {
            },
            child: BuildTextWidget(text:'Filter',color: AppColors.blue,fontSize: 16,)
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: AppColors.light_grey),
            Center(
              child: BuildDropDownButtonFormWidget(
                selectedValue: selectedDateRange,
                items: dateRangeOptions,
                onChanged: (value) {
                  setState(() {
                    selectedDateRange = value!;
                  });
                },
                hintText: 'Select Date Range',
                dropdownColor: AppColors.grey_off,
                fillColor:AppColors.dark_blue,
                textColor: AppColors.white,
                icon: Icons.keyboard_arrow_down,
                width: 180,
                height: 50,
                borderRadius: 41,
              ),
            ),
             SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _pickStartDate,
                  child: Container(
                    padding:  EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                      color: AppColors.grey_off,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/Icons/calendar_icon.svg'),
                         SizedBox(width: 8),
                        BuildTextWidget(text: '${startDate.day}/${startDate.month}/${startDate.year}', color: AppColors.white,)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _pickEndDate,
                  child: Container(
                    padding:  EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                      color: AppColors.grey_off,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/Icons/calendar_icon.svg'),
                         SizedBox(width: 8),
                        BuildTextWidget(text:'${endDate.day}/${endDate.month}/${endDate.year}',color: AppColors.white, )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.light_grey),
             SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: statusOptions.map((status) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStatus = status;
                      });
                    },
                    child: Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 0, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: selectedStatus == status
                            ? AppColors.blue
                            : AppColors.grey_off,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: BuildTextWidget(text: status,color: AppColors.white,)
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCustomer,
              dropdownColor: AppColors.dark_blue,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.dark_blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              items: customers
                  .map(
                    (customer) => DropdownMenuItem<String>(
                  value: customer,
                  child: BuildTextWidget(text: customer, color: AppColors.white),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCustomer = value!;
                });
              },
              isExpanded: true,
              icon: IconButtonWidget(
                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.white),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: AppColors.light_grey),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: BuildTextWidget(text: selectedCustomer,color: AppColors.white,),
                  backgroundColor: AppColors.grey_off,
                  deleteIcon: IconButtonWidget(icon: Icon(Icons.close,color: AppColors.blue,), onTap: () {
                  },),
                  onDeleted: () {
                    setState(() {
                      selectedCustomer = '';
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

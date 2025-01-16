import 'package:cabzing/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailePage extends StatefulWidget {
  const DetailePage({super.key});

  @override
  State<DetailePage> createState() => _DetailePageState();
}

class _DetailePageState extends State<DetailePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
    );
  }
}

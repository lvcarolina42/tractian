import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/domain/models/company.dart';
import 'package:tractian/presentation/pages/menu/controller/menu_controller.dart' as controller;

import '../../../shared/paths.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final controller.MenuController _menuController = Get.find<controller.MenuController>();

  @override
  Widget build(BuildContext context) {
    final List<Company> companies = _menuController.getCompanies();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Image.asset(
          AppImages.tractianLogo,
          width: 200,
          height: 200,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final Company company = companies[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(Paths.assetsPage, arguments: company);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blue4,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  company.name,
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


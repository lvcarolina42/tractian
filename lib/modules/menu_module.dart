import 'package:get/get.dart';
import 'package:tractian/data/repository/companies_repository.dart';
import 'package:tractian/domain/use_cases/get_companies.dart';

import '../presentation/pages/menu/controller/menu_controller.dart';

class MenuModule extends Bindings {
  MenuModule();

  @override
  void dependencies() {
    Get.put(MenuController(GetCompanies(CompaniesRepositoryImpl())));
  }
}

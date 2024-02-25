import 'package:get/get.dart';
import 'package:tractian/data/repository/companies_repository.dart';
import 'package:tractian/domain/repository/companies_repository_impl.dart';
import 'package:tractian/domain/use_cases/get_company_assets.dart';
import 'package:tractian/presentation/pages/assets/controller/assets_controller.dart';

import '../domain/use_cases/get_company_locations.dart';

class AssetsModule extends Bindings {
  AssetsModule();

  @override
  void dependencies() {
    final CompaniesRepository companiesRepository = CompaniesRepositoryImpl();
    Get.put(AssetsController(
      GetCompanyAssets(companiesRepository),
      GetCompanyLocations(companiesRepository),
    ));
  }
}

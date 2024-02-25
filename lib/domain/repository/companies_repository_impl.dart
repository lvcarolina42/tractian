import 'package:tractian/domain/models/company.dart';
import 'package:tractian/domain/models/location.dart';

import '../../domain/models/asset.dart';

abstract class CompaniesRepository {
  List<Company> getDatasets();
  String getCompanyPath(CompanyEnum company);
  Future<List<Asset>> getCompanyAssets(CompanyEnum company);
  Future<List<Location>> getCompanyLocations(CompanyEnum company);
}
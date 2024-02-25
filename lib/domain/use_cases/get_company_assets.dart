import 'package:tractian/domain/models/company.dart';
import 'package:tractian/domain/repository/companies_repository_impl.dart';

import '../models/asset.dart';

class GetCompanyAssets {
  late final CompaniesRepository _repository;

  GetCompanyAssets(this._repository);

  Future<List<Asset>> call(CompanyEnum company) async => await _repository.getCompanyAssets(company);
}

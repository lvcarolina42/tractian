import 'package:tractian/domain/models/company.dart';
import 'package:tractian/domain/repository/companies_repository_impl.dart';

import '../models/location.dart';

class GetCompanyLocations {
  late final CompaniesRepository _repository;

  GetCompanyLocations(this._repository);

  Future<List<Location>> call(CompanyEnum company) async => await _repository.getCompanyLocations(company);
}

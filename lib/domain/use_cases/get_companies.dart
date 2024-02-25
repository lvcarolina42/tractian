import 'package:tractian/domain/repository/companies_repository_impl.dart';

import '../models/company.dart';

class GetCompanies {
  late final CompaniesRepository _repository;

  GetCompanies(this._repository);

  List<Company> call() => _repository.getDatasets();
}

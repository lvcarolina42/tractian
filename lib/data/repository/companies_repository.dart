
import 'dart:convert';
import 'dart:io';

import 'package:tractian/domain/models/company.dart';
import 'package:tractian/domain/models/location.dart';

import '../../domain/models/asset.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../domain/repository/companies_repository_impl.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  @override
  List<Company> getDatasets() {
    return [
      Company(
        name: "Apex Unit",
        companyEnum: CompanyEnum.apex,
        path: getCompanyPath(CompanyEnum.apex),
      ),
      Company(
        name: "Jaguar Unit",
        companyEnum: CompanyEnum.jaguar,
        path: getCompanyPath(CompanyEnum.jaguar),
      ),
      Company(
        name: "Tobias Unit",
        companyEnum: CompanyEnum.tobias,
        path: getCompanyPath(CompanyEnum.tobias),
      ),
    ];
  }

  @override
  String getCompanyPath(CompanyEnum company) {
    switch(company) {
      case CompanyEnum.apex:
        return "apex_unit";
      case CompanyEnum.jaguar:
        return "jaguar_unit";
      case CompanyEnum.tobias:
        return "tobias_unit";
    }
  }

  @override
  Future<List<Asset>> getCompanyAssets(CompanyEnum company) async {
    final File file = File('datasets/${getCompanyPath(company)}/assets.json');
    final String jsonString = await rootBundle.loadString(file.path);

    final List<dynamic> jsonList = json.decode(jsonString);

    final List<Asset> assets = jsonList.map((json) => Asset.fromJson(json)).toList();

    return assets;
  }

  @override
  Future<List<Location>> getCompanyLocations(CompanyEnum company) async {
    final File file = File('datasets/${getCompanyPath(company)}/locations.json');
    final String jsonString = await rootBundle.loadString(file.path);

    final List<dynamic> jsonList = json.decode(jsonString);

    final List<Location> locations = jsonList.map((json) => Location.fromJson(json)).toList();

    return locations;
  }
}
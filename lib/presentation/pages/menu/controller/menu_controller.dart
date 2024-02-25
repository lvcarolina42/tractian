import 'package:mobx/mobx.dart';
import 'package:tractian/domain/use_cases/get_companies.dart';

import '../../../../domain/models/company.dart';

part 'menu_controller.g.dart';

class MenuController = MenuControllerStore with _$MenuController;

abstract class MenuControllerStore with Store {
  final GetCompanies _getCompanies;

  MenuControllerStore(this._getCompanies);

  @action
  List<Company> getCompanies() => _getCompanies();
}
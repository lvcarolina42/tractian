import 'package:get/get.dart';
import 'package:tractian/modules/menu_module.dart';
import 'package:tractian/presentation/pages/menu/menu_page.dart';
import 'package:tractian/shared/paths.dart';

import '../modules/assets_module.dart';
import '../presentation/pages/assets/assets_page.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(name: Paths.menuPage, page: () => const MenuPage(), binding: MenuModule()),
    GetPage(name: Paths.assetsPage, page: () => const AssetsPage(), binding: AssetsModule()),
  ];
}

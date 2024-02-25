import 'package:flutter/cupertino.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:tractian/domain/use_cases/get_company_assets.dart';

import '../../../../domain/models/asset.dart';
import '../../../../domain/models/company.dart';
import '../../../../domain/models/location.dart';
import '../../../../domain/use_cases/get_company_locations.dart';
import '../widgets/tree_tile.dart';

part 'assets_controller.g.dart';

class AssetsController = AssetsControllerStore with _$AssetsController;

enum AssetType {
  asset,
  component,
  location,
}

abstract class AssetsControllerStore with Store {
  final GetCompanyAssets _getCompanyAssets;
  final GetCompanyLocations _getCompanyLocations;

  AssetsControllerStore(this._getCompanyAssets, this._getCompanyLocations);

  List<Asset> assets = [];
  List<Location> locations = [];
  List<Asset> assetsInitialNode = [];
  List<Location> locationsInitialNode = [];
  List<Asset> assetsChildren = [];
  List<Location> locationsChildren = [];

  final Company company = Get.arguments as Company;

  late final TextEditingController searchBarTextEditingController;
  late TreeController<TreeNode> treeController = TreeController<TreeNode>(
    roots: <TreeNode>[],
    childrenProvider: getChildren,
  );

  TreeSearchResult<TreeNode>? filter;
  Pattern? searchPattern;

  Iterable<TreeNode> getChildren(TreeNode node) {
    if (filter case TreeSearchResult<TreeNode> filter?) {
      return node.children.where(filter.hasMatch);
    }
    return node.children;
  }

  void search(String query) {
    filter = null;

    Pattern pattern;
    try {
      pattern = RegExp(query, caseSensitive: false);
    } on FormatException {
      pattern = query;
    }
    searchPattern = pattern;

    filter = treeController.search((TreeNode node) => node.name.contains(pattern));
    treeController.rebuild();
    treeController.expandAll();
  }

  void clearSearch() {
    if (filter == null) return;
  }

  void onSearchQueryChanged() {
    final String query = searchBarTextEditingController.text.trim();

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    search(query);
  }

  void onSearchBySensorType() {
    const SensorType searchByEnergy = SensorType.energy;

    if (filter == null) {
      filter = treeController.search((TreeNode node) => node.sensorType == searchByEnergy);
    } else {
      filter = treeController.search((TreeNode node) => node.sensorType == searchByEnergy && filter!.hasMatch(node));
    }
    treeController.rebuild();
    treeController.expandAll();
  }

  void onSearchByStatus() {
    const Status searchByCritical = Status.alert;

    if (filter == null) {
      filter = treeController.search((TreeNode node) => node.status == searchByCritical);
    } else {
      filter = treeController.search((TreeNode node) => node.status == searchByCritical && filter!.hasMatch(node));
    }
    treeController.rebuild();
    treeController.expandAll();
  }

  Future<List<TreeNode>> setTree() async {
    assets = await _getCompanyAssets(company.companyEnum);
    locations = await _getCompanyLocations(company.companyEnum);
    assetsInitialNode = assets.where((element) => element.parentId == null && element.locationId == null).toList();
    locationsInitialNode = locations.where((element) => element.parentId == null).toList();
    assetsChildren = assets.where((element) => element.parentId != null || element.locationId != null).toList();
    locationsChildren = locations.where((element) => element.parentId != null).toList();

    List<TreeNode> treeNodes = [];
    for (var element in locationsInitialNode) {
      treeNodes.add(
          TreeNode(
            name: element.name,
            type: AssetType.location,
            children: nodes(assetsChildren, locationsChildren, element.id),
          )
      );
    }

    for (var element in assetsInitialNode) {
      treeNodes.add(
          TreeNode(
            name: element.name,
            type: (element.sensorType != null ? AssetType.component : AssetType.asset),
            children: nodes(assetsChildren, locationsChildren, element.id),
            sensorType: element.sensorType,
            status: element.status,
          )
      );
    }

    return [TreeNode(name: company.name, type: AssetType.asset, children: treeNodes)];
  }

  List<TreeNode> nodes(List<Asset> assetsChildren, List<Location> locationsChildren, String id) {
    List<TreeNode> children = [];

    for (var element in assetsChildren) {
      if (element.parentId == id || element.locationId == id) {
        children.add(
            TreeNode(
              name: element.name,
              type: (element.sensorType != null ? AssetType.component : AssetType.asset),
              children: nodes(assetsChildren, locationsChildren, element.id),
              sensorType: element.sensorType,
              status: element.status,),
        );
      }
    }

    for (var element in locationsChildren) {
      if (element.parentId == id) {
        children.add(
            TreeNode(
              name: element.name,
              type: AssetType.location,
              children: nodes(assetsChildren, locationsChildren, element.id),
            )
        );
      }
    }

    return children;
  }
}
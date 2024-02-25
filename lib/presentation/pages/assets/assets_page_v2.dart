// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
// import 'package:tractian/domain/models/company.dart';
// import 'package:tractian/domain/models/location.dart';
// import 'package:tractian/presentation/pages/assets/widgets/tree_tile.dart';
//
// import '../../../data/repository/companies_repository.dart';
// import '../../../domain/models/asset.dart';
// import '../../constants/app_colors.dart';
// import '../../constants/app_images.dart';
//
// class AssetsPage extends StatefulWidget {
//   const AssetsPage({super.key});
//
//   @override
//   State<AssetsPage> createState() => _AssetsPageState();
// }
//
// enum AssetType {
//   asset,
//   component,
//   location,
// }
//
// class _AssetsPageState extends State<AssetsPage> {
//   List<Asset> assets = [];
//   List<Location> locations = [];
//   List<Asset> assetsInitialNode = [];
//   List<Location> locationsInitialNode = [];
//   List<Asset> assetsChildren = [];
//   List<Location> locationsChildren = [];
//
//
//   late final TextEditingController searchBarTextEditingController;
//   late TreeController<TreeNode> treeController = TreeController<TreeNode>(
//     roots: <TreeNode>[],
//     childrenProvider: getChildren,
//   );
//
//   TreeSearchResult<TreeNode>? filter;
//   Pattern? searchPattern;
//
//   Iterable<TreeNode> getChildren(TreeNode node) {
//     if (filter case TreeSearchResult<TreeNode> filter?) {
//       return node.children.where(filter.hasMatch);
//     }
//
//     return node.children;
//   }
//
//   void search(String query) {
//     filter = null;
//
//     Pattern pattern;
//     try {
//       pattern = RegExp(query, caseSensitive: false);
//     } on FormatException {
//       pattern = query;
//     }
//     searchPattern = pattern;
//
//     filter = treeController.search((TreeNode node) => node.name.contains(pattern));
//     treeController.rebuild();
//     treeController.expandAll();
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   void clearSearch() {
//     if (filter == null) return;
//
//     setState(() {
//       filter = null;
//       searchPattern = null;
//       treeController.rebuild();
//       treeController.collapseAll();
//       searchBarTextEditingController.clear();
//     });
//   }
//
//   void onSearchQueryChanged() {
//     final String query = searchBarTextEditingController.text.trim();
//
//     if (query.isEmpty) {
//       clearSearch();
//       return;
//     }
//
//     search(query);
//   }
//
//   Future<List<TreeNode>> setTree() async {
//     assets = await CompaniesRepositoryImpl().getCompanyAssets(CompanyEnum.jaguar);
//     locations = await CompaniesRepositoryImpl().getCompanyLocations(CompanyEnum.jaguar);
//     assetsInitialNode = assets.where((element) => element.parentId == null && element.locationId == null).toList();
//     locationsInitialNode = locations.where((element) => element.parentId == null).toList();
//     assetsChildren = assets.where((element) => element.parentId != null || element.locationId != null).toList();
//     locationsChildren = locations.where((element) => element.parentId != null).toList();
//
//     List<TreeNode> treeNodes = [];
//     for (var element in locationsInitialNode) {
//       treeNodes.add(
//           TreeNode(
//             name: element.name,
//             type: AssetType.location,
//             trailingIcon: null,
//             children: nodes(assetsChildren, locationsChildren, element.id),
//           )
//       );
//     }
//
//     for (var element in assetsInitialNode) {
//       treeNodes.add(
//           TreeNode(
//             name: element.name,
//             trailingIcon: null,
//             type: (element.sensorType != null ? AssetType.component : AssetType.asset),
//             children: nodes(assetsChildren, locationsChildren, element.id),
//           )
//       );
//     }
//
//     return [TreeNode(name: CompanyEnum.jaguar.name, type: AssetType.asset, trailingIcon: null, children: treeNodes)];
//   }
//
//   List<TreeNode> nodes(List<Asset> assetsChildren, List<Location> locationsChildren, String id) {
//     List<TreeNode> children = [];
//
//     for (var element in assetsChildren) {
//       if (element.parentId == id || element.locationId == id) {
//         children.add(
//             TreeNode(
//               name: element.name,
//               type: (element.sensorType != null ? AssetType.component : AssetType.asset),
//               trailingIcon: null,
//               children: nodes(assetsChildren, locationsChildren, element.id),
//             )
//         );
//       }
//     }
//
//     for (var element in locationsChildren) {
//       if (element.parentId == id) {
//         children.add(
//             TreeNode(
//               name: element.name,
//               type: AssetType.location,
//               trailingIcon: null,
//               children: nodes(assetsChildren, locationsChildren, element.id),
//             )
//         );
//       }
//     }
//
//     return children;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     setTree().then((value) {
//       setState(() {
//         treeController = TreeController<TreeNode>(
//           roots: value,
//           childrenProvider: getChildren,
//         );
//         treeController.expand(value.first);
//       });
//     });
//
//     searchBarTextEditingController = TextEditingController();
//     searchBarTextEditingController.addListener(onSearchQueryChanged);
//   }
//
//   @override
//   void dispose() {
//     filter = null;
//     searchPattern = null;
//     treeController.dispose();
//     searchBarTextEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appBarColor,
//         title: Image.asset(
//           AppImages.tractianLogo,
//           width: 200,
//           height: 200,
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SearchBar(
//             controller: searchBarTextEditingController,
//             hintText: 'Buscar Ativo ou Local',
//             leading: const Padding(
//               padding: EdgeInsets.all(8),
//               child: Icon(Icons.filter_list),
//             ),
//             trailing: [
//               Badge(
//                 isLabelVisible: filter != null,
//                 label: Text(
//                   '${filter?.totalMatchCount}/${filter?.totalNodeCount}',
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: clearSearch,
//               )
//             ],
//           ),
//           Expanded(
//             child: AnimatedTreeView<TreeNode>(
//               treeController: treeController,
//               nodeBuilder: (BuildContext context, TreeEntry<TreeNode> entry) {
//                 return TreeTile(
//                   key: ValueKey(entry.node),
//                   entry: entry,
//                   controller: treeController,
//                   match: filter?.matchOf(entry.node),
//                   searchPattern: searchPattern,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UserName {
//   final String firstName;
//   final String lastName;
//
//   UserName(this.firstName, this.lastName);
// }
//

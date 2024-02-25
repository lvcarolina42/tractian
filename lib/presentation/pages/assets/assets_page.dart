import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get/get.dart';
import 'package:tractian/presentation/constants/app_fonts.dart';
import 'package:tractian/presentation/pages/assets/widgets/filter_item.dart';
import 'package:tractian/presentation/pages/assets/widgets/tree_tile.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import 'controller/assets_controller.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AssetsController _assetsController = Get.find<AssetsController>();

  @override
  void initState() {
    super.initState();

    _assetsController.setTree().then((value) {
      setState(() {
        _assetsController.treeController = TreeController<TreeNode>(
          roots: value,
          childrenProvider: _assetsController.getChildren,
        );
        _assetsController.treeController.expand(value.first);
      });
    });

    _assetsController.searchBarTextEditingController = TextEditingController();
    _assetsController.searchBarTextEditingController.addListener(
      () {
        _assetsController.onSearchQueryChanged();
        if(_assetsController.searchBarTextEditingController.text.isEmpty) {
          _assetsController.treeController.collapseAll();
          _assetsController.filter = null;
          _assetsController.searchPattern = null;
        }
        if (mounted) {
          setState(() {});
        }
      }
    );
  }

  @override
  void dispose() {
    _assetsController.filter = null;
    _assetsController.searchPattern = null;
    _assetsController.treeController.dispose();
    _assetsController.searchBarTextEditingController.dispose();
    super.dispose();
  }

  var filterEnergySelected = false;
  var filterCriticalSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Image.asset(
          AppImages.tractianLogo,
          width: 200,
          height: 200,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(AppColors.neutralGray100),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              controller: _assetsController.searchBarTextEditingController,
              hintText: 'Buscar Ativo ou Local',
              hintStyle: MaterialStateProperty.all(regularSm.defaultStyle(context)),
              leading: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.search, color: AppColors.neutralGray500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                FilterItem(
                  onTap: () => setState(() {
                    filterCriticalSelected = false;
                    filterEnergySelected = !filterEnergySelected;
                    if(filterEnergySelected) {
                      _assetsController.filter = null;
                      _assetsController.searchPattern = null;
                      _assetsController.onSearchBySensorType();
                    } else {
                      _assetsController.treeController.collapseAll();
                      _assetsController.treeController.collapse(_assetsController.treeController.roots.first);
                      _assetsController.filter = null;
                      _assetsController.searchPattern = null;
                    }
                  }),
                  isSelected: filterEnergySelected,
                  text: 'Sensor de Energia',
                  icon: Icons.bolt,
                ),
                const SizedBox(width: 8),
                FilterItem(
                  onTap: () => setState(() {
                    filterEnergySelected = false;
                    filterCriticalSelected = !filterCriticalSelected;

                    if(filterCriticalSelected) {
                      _assetsController.filter = null;
                      _assetsController.searchPattern = null;
                      _assetsController.onSearchByStatus();
                    } else {
                      _assetsController.treeController.collapseAll();
                      _assetsController.treeController.collapse(_assetsController.treeController.roots.first);
                      _assetsController.filter = null;
                      _assetsController.searchPattern = null;
                    }
                  }),
                  isSelected: filterCriticalSelected,
                  text: 'Crítico',
                  icon: Icons.error_outline,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AnimatedTreeView<TreeNode>(
                treeController: _assetsController.treeController,
                nodeBuilder: (BuildContext context, TreeEntry<TreeNode> entry) {
                  return TreeTile(
                    key: ValueKey(entry.node),
                    entry: entry,
                    controller: _assetsController.treeController,
                    match: _assetsController.filter?.matchOf(entry.node),
                    searchPattern: _assetsController.searchPattern,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:tractian/presentation/constants/app_fonts.dart';
import '../../../../domain/models/asset.dart';
import 'custom_folder_button.dart' as custom;

import '../../../constants/app_colors.dart';
import '../../../icons/custom_icons.dart';
import '../controller/assets_controller.dart';

class TreeNode {
  final String name;
  final AssetType type;
  final List<TreeNode> children;
  final SensorType? sensorType;
  final Status? status;

  const TreeNode({
    required this.name,
    required this.type,
    this.children = const <TreeNode>[],
    this.sensorType,
    this.status,
  });
}

class TreeTile extends StatefulWidget {
  final TreeEntry<TreeNode> entry;
  final TreeController controller;
  final TreeSearchMatch? match;
  final Pattern? searchPattern;

  const TreeTile({
    super.key,
    required this.entry,
    required this.controller,
    required this.match,
    required this.searchPattern,
  });

  @override
  State<TreeTile> createState() => _TreeTileState();
}

class _TreeTileState extends State<TreeTile> {
  late InlineSpan titleSpan;

  TextStyle? dimStyle;
  TextStyle? highlightStyle;

  bool get show =>
      !widget.entry.isExpanded && (widget.match?.subtreeMatchCount ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.controller.toggleExpansion(widget.entry.node),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TreeIndentation(
          entry: widget.entry,
          guide: const IndentGuide.connectingLines(
            padding: EdgeInsets.zero,
            color: AppColors.neutralGray200,
            thickness: 1,
          ),
          child: Row(
            children: [
              custom.FolderButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                hasChildren: widget.entry.hasChildren,
                isOpen: widget.entry.hasChildren ? widget.entry.isExpanded : false,
                onPressed: widget.entry.hasChildren ? () => widget.controller.toggleExpansion(widget.entry.node) : null,
                color: AppColors.blue4,
                disabledColor: AppColors.blue4,
                icon: Container(),
                openedIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
                closedIcon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ),
              widget.entry.node.type == AssetType.location
                  ? const Icon(CustomIcons.location, color: AppColors.blue4)
                  : (
                  widget.entry.node.type == AssetType.component
                      ? const Icon(CustomIcons.component, color: AppColors.blue4)
                      : const Icon(CustomIcons.asset, color: AppColors.blue4)
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Text(
                    widget.entry.node.name.toUpperCase(),
                    style: bodyRegular.customColor(Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8,),
              if(widget.entry.node.sensorType == SensorType.energy)
                const Icon(Icons.bolt, color: AppColors.greenEnergy, size: 16),
              if(widget.entry.node.status == Status.alert)
                ...[
                  const Icon(Icons.circle, color: AppColors.feedbackDanger, size: 8),
                  const SizedBox(width: 4),
                ]
            ],
          ),
        ),
      ),
    );
  }
}
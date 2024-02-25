import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';

class FilterItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String text;
  final IconData icon;

  const FilterItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 2, bottom: 2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blue4 : Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.blue4 : AppColors.neutralGray200,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16.0,
                color: isSelected ? Colors.white : AppColors.writingBodyText2,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: regularSm.customColor(isSelected ? Colors.white : AppColors.writingBodyText2),
              ),
            ],
          )
      ),
    );
  }
}

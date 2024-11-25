import 'package:flutter/material.dart';
import 'package:tekvando/core/extension/screen_size.dart';
import 'package:tekvando/core/utilty/border_radius_items.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.width,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF7265E3),
          borderRadius: BorderRadiusItem.medium.str(),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}

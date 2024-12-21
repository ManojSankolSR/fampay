import 'package:flutter/material.dart';

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onpress,
  });

  final String icon;
  final String title;
  final Color color;
  final void Function() onpress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onpress();
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Image.asset(icon, height: 28, width: 28),
              SizedBox(
                height: 8,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

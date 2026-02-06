import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final String iconPath;
  final String iconName;

  const MyTab({
    super.key,
    required this.iconPath,
    required this.iconName,

  });


  @override
  Widget build(BuildContext context) {
    return Tab (
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            //Borde circular
            borderRadius: BorderRadius.circular(16),
          ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                iconPath,
             color: Colors.grey[600]),
            ),
            Text(iconName, style: TextStyle(fontSize: 12)),
          ]
        )
        ),
        )
      );
  }
}
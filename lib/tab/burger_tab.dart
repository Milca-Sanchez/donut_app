import 'package:donut_app/utils/burger_tile.dart';
import 'package:flutter/material.dart';

class BurgerTab extends StatelessWidget {
  BurgerTab({super.key});

  // Lista de hamburguesas
  final List burgerOnSale = [
    [
      'Classic Burger',
      '120',
      Colors.orange,
      'lib/images/burger-4.png',
      'McDonalds',
    ],
    [
      'Cheese Burger',
      '135',
      Colors.yellow,
      'lib/images/burger-3.png',
      'Burger King',
    ],
    [
      'Double Burger',
      '160',
      Colors.red,
      'lib/images/burger-2.png',
      'Carl’s Jr',
    ],
    [
      'Classic Chicken Delight',
      '110',
      Colors.green,
      'lib/images/burger-1.png',
      'Popeyes',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemCount: burgerOnSale.length,
      itemBuilder: (context, index) {
        return BurgerTile(
          burgerFlavor: burgerOnSale[index][0],
          burgerPrice: burgerOnSale[index][1],
          burgerColor: burgerOnSale[index][2],
          burgerImagePath: burgerOnSale[index][3],
          burgerProvider: burgerOnSale[index][4],
        );
      },
    );
  }
}

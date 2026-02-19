import 'package:donut_app/utils/pancake_tile.dart';
import 'package:flutter/material.dart';

class PancakeTab extends StatelessWidget {
   PancakeTab({super.key});

  //List of donuts
  final List pancakeOnSale = [
    // donutFlavor, donutPrice, donutColor, donutImagePath, donutProvider
    [
      'Strawberry ice cream',
      '140',
      Colors.pink,
      "lib/images/pancake-1.png",
      'Vips',
    ],
    [
      'Butter',
      '89',
      Colors.green,
      "lib/images/pancake-2.png",
      'Trecaffé',
    ],
    [
      'Chocolate',
      '130',
      Colors.brown,
      "lib/images/pancake-3.png",
      'Amada Mia Bistro',
    ],
    ['Honey', '120', Colors.yellow, "lib/images/pancake-4.png", 'Rosagante'],
  ];


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //Se encarga de acomodar elementos dentro del grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //Cantidad de columnas
      crossAxisCount: 2,
      //Tamaño de cada columna
      childAspectRatio: 1 / 1.5,
      ),
      //Cantidad de elementos
      itemCount: pancakeOnSale.length,
      //Lo que se va a construir
      itemBuilder: (context, index) {
      return PancakeTile(
        pancakeFlavor: pancakeOnSale[index][0],
        pancakePrice: pancakeOnSale[index][1],
        pancakeColor: pancakeOnSale[index][2],
        pancakeImagePath: pancakeOnSale[index][3],
        pancakeProvider: pancakeOnSale[index][4],
        );
      },
    );
  }
}
 
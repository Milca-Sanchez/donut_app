import 'package:donut_app/utils/pizza_tile.dart';
import 'package:flutter/material.dart';

class PizzaTab extends StatelessWidget {
   PizzaTab({super.key});

  //List of donuts
  final List pizzaOnSale = [
    // donutFlavor, donutPrice, donutColor, donutImagePath, donutProvider
    [
      'Spinach',
      '210',
      Colors.brown,
      "lib/images/pizza-1.png",
      'Pizza Hut',
    ],
    [
      'Spices',
      '230',
      Colors.red,
      "lib/images/pizza-2.png",
      'Messinas',
    ],
    [
      'Mushroom and salami',
      '180',
      Colors.blue,
      "lib/images/pizza-3.png",
      'Litlle Caesars',
    ],
    ['Pepperoni', '195', Colors.purple, "lib/images/pizza-4.png", 'Ajedrez'],
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
      itemCount: pizzaOnSale.length,
      //Lo que se va a construir
      itemBuilder: (context, index) {
      return PizzaTile(
        pizzaFlavor: pizzaOnSale[index][0],
        pizzaPrice: pizzaOnSale[index][1],
        pizzaColor: pizzaOnSale[index][2],
        pizzaImagePath: pizzaOnSale[index][3],
        pizzaProvider: pizzaOnSale[index][4],
        );
      },
    );
  }
}
 
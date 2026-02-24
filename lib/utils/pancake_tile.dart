import 'package:donut_app/models/cart.dart';
import 'package:donut_app/models/cart_item.dart';
import 'package:flutter/material.dart';

class PancakeTile extends StatelessWidget {

  final String pancakeFlavor;
  final String pancakePrice;
  final dynamic pancakeColor;
  final String pancakeImagePath;
  final String pancakeProvider;
  final VoidCallback onCartUpdated; // actualice el contador

  const PancakeTile ({super.key,
  required this.pancakeFlavor,
  required this.pancakePrice,
  required this.pancakeColor,
  required this.pancakeImagePath,
  required this.pancakeProvider,
  required this.onCartUpdated });

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container (
        decoration: BoxDecoration(
          color:pancakeColor[100],
          //Bordes redondeados
          borderRadius: BorderRadius.circular(24),
          ),
        child: Column(
          children: [
            //Etiqueta del precio
            Row(
              //Alinear a la derecha
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical:8,
                    horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: pancakeColor[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      )),
                      child: Text('\$$pancakePrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: pancakeColor[800],

                        ),
                      )
                    ),
                  ],
              ),
              //Imagen del donut
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24),
                  child: Image.asset(pancakeImagePath),
                ),
                //Nombre del donut
                Text(
                  pancakeFlavor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                //Espacio entre textos
                const SizedBox(height: 4),
                //Nombre del proveedor
                Text(pancakeProvider, style: 
                  TextStyle(
                    color: Colors.grey[600])),
                //Icono de favorito y carrito de compras
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.favorite_border, color: Colors.pink[400]),
                      GestureDetector(
                        onTap: () {
                          //Agregar al carrito
                          Cart.addItem(CartItem(
                            name: pancakeFlavor,
                            price: pancakePrice,
                            imagePath: pancakeImagePath,
                          ));
                          //Actualizar el contador 
                          onCartUpdated();
                          //Mensaje de confirmación
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$pancakeFlavor added to cart!'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.pink[400],
                            ),
                          );
                        },
                        child: Text("Add", 
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                        ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      );
    }
}

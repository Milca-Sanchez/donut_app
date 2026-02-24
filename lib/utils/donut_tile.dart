import 'package:donut_app/models/cart.dart';
import 'package:donut_app/models/cart_item.dart';
import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {

  final String donutFlavor;
  final String donutPrice;
  final dynamic donutColor;
  final String donutImagePath;
  final String donutProvider;
  final VoidCallback onCartUpdated; // actualice el contador

  const DonutTile ({super.key,
  required this.donutFlavor,
  required this.donutPrice,
  required this.donutColor,
  required this.donutImagePath,
  required this.donutProvider,
  required this.onCartUpdated });

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container (
        decoration: BoxDecoration(
          color:donutColor[100],
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
                      color: donutColor[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      )),
                      child: Text('\$$donutPrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: donutColor[800],

                        ),
                      )
                    ),
                  ],
              ),
              //Imagen del donut
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24),
                  child: Image.asset(donutImagePath),
                ),
                //Nombre del donut
                Text(
                  donutFlavor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                //Espacio entre textos
                const SizedBox(height: 4),
                //Nombre del proveedor
                Text(donutProvider, style: 
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
                            name: donutFlavor,
                            price: donutPrice,
                            imagePath: donutImagePath,
                          ));
                          //Actualizar el contador 
                          onCartUpdated();
                          //Mensaje de confirmación
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$donutFlavor added to cart!'),
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

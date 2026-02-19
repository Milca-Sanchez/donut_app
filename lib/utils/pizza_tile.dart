import 'package:flutter/material.dart';

class PizzaTile extends StatelessWidget {

  final String pizzaFlavor;
  final String pizzaPrice;
  final dynamic pizzaColor;
  final String pizzaImagePath;
  final String pizzaProvider;

  const PizzaTile ({super.key,
  required this.pizzaFlavor,
  required this.pizzaPrice,
  required this.pizzaColor,
  required this.pizzaImagePath,
  required this.pizzaProvider });

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container (
        decoration: BoxDecoration(
          color:pizzaColor[100],
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
                      color: pizzaColor[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      )),
                      child: Text('\$$pizzaPrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: pizzaColor[800],

                        ),
                      )
                    ),
                  ],
              ),
              //Imagen del donut
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24),
                  child: Image.asset(pizzaImagePath),
                ),
                //Nombre del donut
                Text(
                  pizzaFlavor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                //Espacio entre textos
                const SizedBox(height: 4),
                //Nombre del proveedor
                Text(pizzaProvider, style: 
                  TextStyle(
                    color: Colors.grey[600])),
                //Icono de favorito y carrito de compras
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.favorite_border, color: Colors.pink[400]),
                      Text("Add", 
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
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
import 'package:flutter/material.dart';

class SmoothieTile extends StatelessWidget {

  final String smoothieFlavor;
  final String smoothiePrice;
  final dynamic smoothieColor;
  final String smoothieImagePath;
  final String smoothieProvider;

  const SmoothieTile ({super.key,
  required this.smoothieFlavor,
  required this.smoothiePrice,
  required this.smoothieColor,
  required this.smoothieImagePath,
  required this.smoothieProvider });

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container (
        decoration: BoxDecoration(
          color:smoothieColor[100],
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
                      color: smoothieColor[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      )),
                      child: Text('\$$smoothiePrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: smoothieColor[800],

                        ),
                      )
                    ),
                  ],
              ),
              //Imagen del donut
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24),
                  child: Image.asset(smoothieImagePath),
                ),
                //Nombre del donut
                Text(
                  smoothieFlavor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                //Espacio entre textos
                const SizedBox(height: 4),
                //Nombre del proveedor
                Text(smoothieProvider, style: 
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
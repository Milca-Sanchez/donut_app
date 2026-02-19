import 'package:flutter/material.dart';

class BurgerTile extends StatelessWidget {

  final String burgerFlavor;
  final String burgerPrice;
  final dynamic burgerColor;
  final String burgerImagePath;
  final String burgerProvider;

  const BurgerTile ({super.key,
  required this.burgerFlavor,
  required this.burgerPrice,
  required this.burgerColor,
  required this.burgerImagePath,
  required this.burgerProvider });

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container (
        decoration: BoxDecoration(
          color:burgerColor[100],
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
                      color: burgerColor[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      )),
                      child: Text('\$$burgerPrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: burgerColor[800],

                        ),
                      )
                    ),
                  ],
              ),
              //Imagen del donut
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24),
                  child: Image.asset(burgerImagePath),
                ),
                //Nombre del donut
                Text(
                  burgerFlavor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                //Espacio entre textos
                const SizedBox(height: 4),
                //Nombre del proveedor
                Text(burgerProvider, style: 
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
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Icono de la izquierda
        leading: Icon(Icons.menu, color: Colors.grey[800]),
        // Iconos de la derecha
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(Icons.person, color: Colors.grey[800]),
          ),
        ],
      ),
      body: Column(
        //1. Texo principal

        //2. Pestañas (TabBar)

        //3. Contenido (TabBarView)

        // 4. Carrito (Cart)
        
      ),
    );
  }
}

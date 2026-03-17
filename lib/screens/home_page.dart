import 'package:donut_app/models/cart.dart';
import 'package:donut_app/models/cart_item.dart';
import 'package:donut_app/models/product.dart';
import 'package:donut_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategory = 0;

  final List<String> categories = [
    'Todos',
    'Laptops',
    'Monitores',
    'T. Video',
    'Teclados',
    'Almacenamiento',
  ];

  final List<Product> allProducts = [
    Product(name: 'MacBook Air M2', price: '24999', category: 'Laptops',
        description: 'Chip M2, 8GB RAM, 256GB SSD', color: Colors.blue),
    Product(name: 'Dell XPS 15', price: '32999', category: 'Laptops',
        description: 'Intel i7, 16GB RAM, 512GB SSD', color: Colors.indigo),
    Product(name: 'ASUS ROG Zephyrus', price: '41999', category: 'Laptops',
        description: 'Ryzen 9, RTX 4070, 32GB RAM', color: Colors.purple),
    Product(name: 'Lenovo ThinkPad X1', price: '28500', category: 'Laptops',
        description: 'Intel i7 13va gen, 16GB, 512GB', color: Colors.blueGrey),
    Product(name: 'LG UltraWide 34"', price: '12999', category: 'Monitores',
        description: 'IPS 3440x1440, 144Hz, HDR400', color: Colors.teal),
    Product(name: 'Samsung Odyssey G7', price: '15499', category: 'Monitores',
        description: 'VA Curvo 27", 1440p, 240Hz', color: Colors.cyan),
    Product(name: 'Dell UltraSharp 27"', price: '9999', category: 'Monitores',
        description: '4K IPS, 60Hz, USB-C 90W', color: Colors.lightBlue),
    Product(name: 'ASUS ProArt 32"', price: '18999', category: 'Monitores',
        description: '4K OLED, 120Hz, 99% DCI-P3', color: Colors.green),
    Product(name: 'RTX 4080 Super', price: '19999', category: 'T. Video',
        description: '16GB GDDR6X, DLSS 3.5', color: Colors.green),
    Product(name: 'RX 7900 XTX', price: '17499', category: 'T. Video',
        description: '24GB GDDR6, FSR 3.0', color: Colors.red),
    Product(name: 'RTX 4060 Ti', price: '9499', category: 'T. Video',
        description: '16GB GDDR6, ideal 1080p/1440p', color: Colors.orange),
    Product(name: 'Arc A770', price: '6999', category: 'T. Video',
        description: '16GB GDDR6, XeSS upscaling', color: Colors.blue),
    Product(name: 'Keychron Q1 Pro', price: '3499', category: 'Teclados',
        description: 'Gasket mount, hot-swap, QMK', color: Colors.amber),
    Product(name: 'Logitech MX Keys S', price: '2299', category: 'Teclados',
        description: 'Inalámbrico, multi-device', color: Colors.grey),
    Product(name: 'Ducky One 3', price: '2799', category: 'Teclados',
        description: 'TKL, Cherry MX Red, RGB', color: Colors.pink),
    Product(name: 'Razer BlackWidow V4', price: '2999', category: 'Teclados',
        description: 'Razer Yellow, Chroma RGB', color: Colors.deepOrange),
    Product(name: 'Samsung 990 Pro 2TB', price: '2799', category: 'Almacenamiento',
        description: 'NVMe PCIe 4.0, 7450MB/s', color: Colors.purple),
    Product(name: 'WD Black SN850X 1TB', price: '1899', category: 'Almacenamiento',
        description: 'NVMe PCIe 4.0, 7300MB/s', color: Colors.deepPurple),
    Product(name: 'Seagate IronWolf 4TB', price: '1799', category: 'Almacenamiento',
        description: 'HDD NAS 3.5", 5400RPM', color: Colors.brown),
    Product(name: 'Crucial T700 2TB', price: '3199', category: 'Almacenamiento',
        description: 'NVMe PCIe 5.0, 12400MB/s', color: Colors.teal),
  ];

  List<Product> get filteredProducts {
    if (_selectedCategory == 0) return allProducts;
    return allProducts
        .where((p) => p.category == categories[_selectedCategory])
        .toList();
  }

  void updateCart() => setState(() {});

  IconData _iconForCategory(String cat) {
    switch (cat) {
      case 'Laptops': return Icons.laptop_mac;
      case 'Monitores': return Icons.monitor;
      case 'T. Video': return Icons.memory;
      case 'Teclados': return Icons.keyboard;
      case 'Almacenamiento': return Icons.storage;
      default: return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Se eliminó la sección 'actions' que contenía el icono de persona
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Título centrado
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¡Tecno ', style: TextStyle(fontSize: 24)),
              const Text('Mundo!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
          const SizedBox(height: 12),

          // Tabs centradas (scroll horizontal)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(categories.length, (i) {
                final selected = _selectedCategory == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = i),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? Colors.grey[400] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_iconForCategory(categories[i]),
                            color: Colors.grey[700], size: 22),
                        const SizedBox(height: 4),
                        Text(categories[i],
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 4),

          // Grid de productos
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.18,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _ProductTile(
                    product: product, onCartUpdated: updateCart);
              },
            ),
          ),

          // Barra inferior del carrito
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Cart.getCount()} Items | \$${Cart.getTotal().toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text('Envío incluido',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                CartScreen(onCartUpdated: updateCart)));
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400]),
                  child: const Text('Ver Carrito',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onCartUpdated;

  const _ProductTile({required this.product, required this.onCartUpdated});

  IconData _iconForCategory(String cat) {
    switch (cat) {
      case 'Laptops': return Icons.laptop_mac;
      case 'Monitores': return Icons.monitor;
      case 'T. Video': return Icons.memory;
      case 'Teclados': return Icons.keyboard;
      case 'Almacenamiento': return Icons.storage;
      default: return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: product.color[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Precio
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6, horizontal: 14),
                  decoration: BoxDecoration(
                    color: product.color[300],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    '\$${product.price}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: product.color[900]),
                  ),
                ),
              ],
            ),

            // Ícono
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Icon(
                _iconForCategory(product.category),
                size: 52,
                color: product.color[500],
              ),
            ),

            // Nombre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(height: 2),

            // Descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
              ),
            ),
            const SizedBox(height: 8),

            // Botón añadir al carrito
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: GestureDetector(
                onTap: () {
                  Cart.addItem(CartItem(
                    name: product.name,
                    price: product.price,
                    category: product.category,
                  ));
                  onCartUpdated();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} agregado'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: Colors.pink[400],
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    color: product.color[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_cart_outlined,
                          color: Colors.white, size: 15),
                      const SizedBox(width: 5),
                      const Text(
                        'Añadir',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
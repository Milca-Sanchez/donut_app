import 'package:donut_app/models/cart.dart';
import 'package:donut_app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onCartUpdated;
  const CartScreen({super.key, required this.onCartUpdated});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _increase(int index) {
    setState(() => Cart.increaseQuantity(index));
    widget.onCartUpdated();
  }

  void _decrease(int index) {
    setState(() => Cart.decreaseQuantity(index));
    widget.onCartUpdated();
  }

  void _remove(int index) {
    setState(() => Cart.removeItem(index));
    widget.onCartUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Mi Carrito',
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
      ),
      body: Cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('Tu carrito está vacío',
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey[500])),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: Cart.items.length,
                    itemBuilder: (context, index) {
                      final item = Cart.items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // Ícono
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.devices,
                                  color: Colors.grey[500], size: 28),
                            ),
                            const SizedBox(width: 12),
                            // Nombre y precio
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  const SizedBox(height: 2),
                                  Text(item.category,
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                      '\$${item.totalPrice.toStringAsFixed(0)}',
                                      style: TextStyle(
                                          color: Colors.pink[400],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ],
                              ),
                            ),
                            // Controles cantidad
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () => _increase(index),
                                  child: Icon(Icons.add,
                                      color: Colors.pink[400], size: 20),
                                ),
                                const SizedBox(height: 4),
                                Text('${item.quantity}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () => _decrease(index),
                                  child: Icon(Icons.remove,
                                      color: Colors.pink[400], size: 20),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            // Eliminar
                            GestureDetector(
                              onTap: () => _remove(index),
                              child: Icon(Icons.delete_outline,
                                  color: Colors.grey[400], size: 22),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Resumen de costos
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      _Row('Subtotal',
                          '\$${Cart.getSubtotal().toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _Row('IVA (16%)',
                          '\$${Cart.getIVA().toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _Row('Envío', '\$${Cart.shippingCost.toStringAsFixed(2)}'),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              '\$${Cart.getTotal().toStringAsFixed(2)} MXN',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink[400])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CheckoutScreen(
                                      onCartUpdated: widget.onCartUpdated)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[400],
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text(
                            'Proceder al Pago',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        Text(value,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

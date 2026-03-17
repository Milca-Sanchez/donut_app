import 'package:donut_app/models/cart.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String orderNumber;
  final double total;
  final int itemCount;
  final VoidCallback onCartUpdated;

  const SuccessScreen({
    super.key,
    required this.orderNumber,
    required this.total,
    required this.itemCount,
    required this.onCartUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Ícono de éxito
              Icon(Icons.check_circle_rounded,
                  size: 90, color: Colors.green[400]),
              const SizedBox(height: 20),
              const Text('¡Pago Exitoso!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 26)),
              const SizedBox(height: 8),
              Text('Tu pedido ha sido confirmado',
                  style: TextStyle(color: Colors.grey[500], fontSize: 15)),

              const SizedBox(height: 32),

              // Resumen
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Número de Orden',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13)),
                        Text(orderNumber,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                    const Divider(height: 24),
                    _InfoRow(Icons.inventory_2_outlined,
                        'Artículos', '$itemCount producto(s)'),
                    const SizedBox(height: 12),
                    _InfoRow(Icons.payments_outlined, 'Total pagado',
                        '\$${total.toStringAsFixed(2)} MXN'),
                    const SizedBox(height: 12),
                    _InfoRow(Icons.local_shipping_outlined, 'Envío',
                        'Incluido (\$150 MXN)'),
                    const SizedBox(height: 12),
                    _InfoRow(Icons.access_time_outlined,
                        'Entrega estimada', '3-5 días hábiles'),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Cart.clear();
                    onCartUpdated();
                    Navigator.of(context)
                        .popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Volver a la Tienda',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[400]),
        const SizedBox(width: 10),
        Text(label,
            style: TextStyle(color: Colors.grey[500], fontSize: 13)),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}

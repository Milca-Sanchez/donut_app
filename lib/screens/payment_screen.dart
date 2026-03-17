import 'package:donut_app/models/cart.dart';
import 'package:donut_app/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  final String shippingName;
  final String shippingAddress;
  final VoidCallback onCartUpdated;

  const PaymentScreen({
    super.key,
    required this.shippingName,
    required this.shippingAddress,
    required this.onCartUpdated,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _isProcessing = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Sincronización corregida para que el estado se actualice al escribir
  void _onCreditCardModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName; // Actualiza el nombre del titular
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }

  Future<void> _processPago() async {
    if (formKey.currentState!.validate()) {
      // Validaciones manuales
      if (cardNumber.replaceAll(' ', '').length < 16) {
        _showError('Ingresa un número de tarjeta válido (16 dígitos)');
        return;
      }
      if (expiryDate.length < 5) {
        _showError('Ingresa una fecha de expiración válida');
        return;
      }
      if (cvvCode.length < 3) {
        _showError('Ingresa un CVV válido (mínimo 3 dígitos)');
        return;
      }
      if (cardHolderName.trim().isEmpty) {
        _showError('Ingresa el nombre del titular');
        return;
      }

      setState(() => _isProcessing = true);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const _LoadingDialog(),
      );

      // Simulación de carga
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) Navigator.of(context).pop();

      final orderNumber =
          'TS-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      final total = Cart.getTotal();
      final itemCount = Cart.getCount();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SuccessScreen(
              orderNumber: orderNumber,
              total: total,
              itemCount: itemCount,
              onCartUpdated: widget.onCartUpdated,
            ),
          ),
        );
      }
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Método de Pago',
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Tarjeta visual (Corregida con visibilidad de nombre)
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (_) {},
              cardBgColor: const Color(0xFF1A237E),
              isSwipeGestureEnabled: true,
              isHolderNameVisible: true, // Habilita el nombre en el diseño
            ),

            // Resumen del total
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E).withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total a pagar',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600)),
                  Text(
                      '\$${Cart.getTotal().toStringAsFixed(2)} MXN',
                      style: const TextStyle(
                          color: Color(0xFF1A237E),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Formulario (Corregido con visibilidad de nombre)
            CreditCardForm(
              formKey: formKey,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: _onCreditCardModelChange,
              themeColor: const Color(0xFF1A237E),
              isHolderNameVisible: true, // Habilita el campo para escribir el nombre
              cardNumberDecoration: _inputDecoration('Número de Tarjeta',
                  'XXXX XXXX XXXX XXXX'),
              expiryDateDecoration:
                  _inputDecoration('Fecha de Expiración', 'MM/AA'),
              cvvCodeDecoration: _inputDecoration('CVV', '•••'),
              cardHolderDecoration:
                  _inputDecoration('Nombre del Titular', 'Ej: Milca Sánchez'),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.credit_card,
                      color: Colors.grey[400], size: 20),
                  const SizedBox(width: 8),
                  Text('Aceptamos Visa, Mastercard y American Express',
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _processPago,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                          'Pagar \$${Cart.getTotal().toStringAsFixed(2)} MXN',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFF1A237E), width: 1.5)),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF1A237E),
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            const Text('Procesando tu pago',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Conectando con el servidor bancario...',
                style: TextStyle(
                    color: Colors.grey[500], fontSize: 13),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
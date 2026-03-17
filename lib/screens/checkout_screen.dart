import 'package:donut_app/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckoutScreen extends StatefulWidget {
  final VoidCallback onCartUpdated;
  const CheckoutScreen({super.key, required this.onCartUpdated});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cpCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _cpCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
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
        title: Text('Datos de Envío',
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _field(
                ctrl: _nameCtrl,
                label: 'Nombre completo',
                hint: 'Ej. Juan Pérez López',
                icon: Icons.person_outline,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'El nombre es requerido'
                    : null,
              ),
              const SizedBox(height: 16),
              _field(
                ctrl: _addressCtrl,
                label: 'Dirección',
                hint: 'Calle, número, colonia',
                icon: Icons.location_on_outlined,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'La dirección es requerida'
                    : null,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      ctrl: _cpCtrl,
                      label: 'Código Postal',
                      hint: '97000',
                      icon: Icons.markunread_mailbox_outlined,
                      keyboardType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                      ],
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Requerido';
                        if (v.length < 5) return '5 dígitos';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _field(
                      ctrl: _phoneCtrl,
                      label: 'Teléfono',
                      hint: '9991234567',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Requerido';
                        if (v.length < 10) return '10 dígitos';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentScreen(
                            shippingName: _nameCtrl.text,
                            shippingAddress: _addressCtrl.text,
                            onCartUpdated: widget.onCartUpdated,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Continuar al Pago',
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

  Widget _field({
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? formatters,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: formatters,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: Colors.pink.shade400, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}

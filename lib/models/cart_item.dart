class CartItem {
  final String name;
  final String price;
  final String imagePath;
  int quantity; // cantidad en el carrito

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1, 
  });
}

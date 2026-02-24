import 'cart_item.dart';

class Cart {
  static List<CartItem> items = [];

  static void addItem(CartItem item) {
    int index = items.indexWhere(
      (i) => i.name == item.name && i.imagePath == item.imagePath,
    );
    if (index != -1) {
      items[index].quantity++; // ya existe, aumentar cantidad
    } else {
      items.add(item); // no existe, agregar nuevo
    }
  }

  // Aumentar cantidad 
  static void increaseQuantity(int index) {
    items[index].quantity++;
  }

  // Disminuir cantidad. 
  static void decreaseQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index); // se elimina
    }
  }

  // Eliminar 
  static void removeItem(int index) {
    items.removeAt(index);
  }

  // Total 
  static double getTotal() {
    double total = 0;
    for (var item in items) {
      total += double.parse(item.price) * item.quantity;
    }
    return total;
  }

  // Cantidad total 
  static int getCount() {
    int count = 0;
    for (var item in items) {
      count += item.quantity;
    }
    return count;
  }
}
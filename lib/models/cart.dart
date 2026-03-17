import 'cart_item.dart';

class Cart {
  static List<CartItem> items = [];

  static const double shippingCost = 150.0;
  static const double ivaRate = 0.16;

  static void addItem(CartItem newItem) {
    final index = items.indexWhere((i) => i.name == newItem.name);
    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(newItem);
    }
  }

  static void increaseQuantity(int index) {
    items[index].quantity++;
  }

  static void decreaseQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index);
    }
  }

  static void removeItem(int index) {
    items.removeAt(index);
  }

  static void clear() {
    items.clear();
  }

  static double getSubtotal() {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  static double getIVA() {
    return getSubtotal() * ivaRate;
  }

  static double getTotal() {
    return items.isEmpty ? 0 : getSubtotal() + getIVA() + shippingCost;
  }

  static int getCount() {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}

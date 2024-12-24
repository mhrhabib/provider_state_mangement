class Shoes {
  final String name;
  final double price;
  final String image;

  Shoes({
    required this.name,
    required this.price,
    required this.image,
  });
}

class Order {
  final Shoes shoes;
  int quantity;
  double totalPrice;

  Order({required this.shoes, this.quantity = 1}) : totalPrice = shoes.price * quantity;
}

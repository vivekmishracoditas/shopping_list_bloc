class ShoppingListData {
  int id;
  String title;
  double price;
  String description;
  String image;
  int itemCount;
  int cartCount;

  ShoppingListData({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.itemCount,
    required this.cartCount,
  });

  factory ShoppingListData.fromJson(Map<String, dynamic> json) =>
      ShoppingListData(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        image: json["image"],
        itemCount: 0,
        cartCount: 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "image": image,
      };
}

class UpdateItem {
  String name;
  String price;
  String description;

  UpdateItem({
    required this.name,
    required this.price,
    required this.description,
  });

  factory UpdateItem.fromJson(Map<String, dynamic> json) {
    return UpdateItem(
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
      };

  @override
  String toString() {
    return '{name:$name, price:$price, description:$description}';
  }
}

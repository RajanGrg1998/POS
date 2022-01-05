class CreateItem {
  String name;
  String price;
  String description;

  CreateItem({
    required this.name,
    required this.price,
    required this.description,
  });

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

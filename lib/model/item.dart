class Item {
  Item({
    this.isVeg = false,
    this.usesOfferPrice,
    this.addons,
    this.categories = const [],
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.usesStocks = false,
    this.description,
    this.offerPrice,
    this.costPrice,
    this.inStock,
    this.lowStock,
    this.sku,
  });

  bool? isVeg;
  bool? usesOfferPrice;
  List<String>? addons;
  List<String>? categories;
  String id;
  String name;
  String? description;
  dynamic price;
  String? image;
  bool? usesStocks;
  int? offerPrice;
  String? sku;
  int? lowStock;
  int? costPrice;
  int? inStock;

  //****** */ not added *******
  // barcode ?
  //orderedCount

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        isVeg: json["isVeg"],
        usesOfferPrice: json["usesOfferPrice"],
        addons: List<String>.from(json["addons"].map((x) => x)),
        categories: List<String>.from(json["categories"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        image: json["image"] == null
            ? 'https://www.wddonline.com/content/uploads/2020/08/placeholder-image.png'
            : json["image"],
        description: json["description"] == null ? null : json["description"],
        inStock: json["inStock"] == null ? null : json["inStock"],
        lowStock: json["lowStock"] == null ? null : json["lowStock"],
        usesStocks: json["usesStocks"],
        sku: json["sku"] == null ? null : json["sku"],
        costPrice: json["costPrice"] == null ? null : json["costPrice"],
        // orderedCount: json["orderedCount"],
      );

  Map<String, dynamic> toJson() {
    var toReturn = {
      "isVeg": isVeg,
      // "addons": List<String>.from(addons!.map((x) => x)),
      "categories": List<dynamic>.from(categories!.map((x) => x)),
      "_id": id,
      "name": name,
      "price": price,
      // "image": image == null ? null : image,
      "description": description == null ? '' : description,
      "usesStocks": usesStocks == null ? false : usesStocks,
      // "orderedCount": orderedCount,
    };
    if (addons != null) {
      toReturn["addons"] = List<String>.from(addons!.map((x) => x));
    }
    if (inStock != null) {
      toReturn["inStock"] = inStock;
    }
    if (lowStock != null) {
      toReturn["lowStock"] = lowStock;
    }
    if (costPrice != null) {
      toReturn["costPrice"] = costPrice;
    }
    if (offerPrice != null) {
      toReturn["offerPrice"] = offerPrice;
    }
    if (sku != null) {
      toReturn["sku"] = sku;
    }
    if (usesOfferPrice == true) {
      toReturn["usesOfferPrice"] = usesOfferPrice;
    }

    return toReturn;
  }

  @override
  String toString() {
    return '{isVeg:$isVeg, categories:$categories, _id:$id, name:$name, price:$price, description:$description, usesStocks:$usesStocks}';
  }
}

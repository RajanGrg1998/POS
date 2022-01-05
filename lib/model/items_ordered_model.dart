class ItemsOrdered {
  final String? itemName;
  final dynamic itemQuantity;
  final dynamic itemRate;
  bool? isRefund;

  ItemsOrdered({
    this.itemName,
    required this.itemQuantity,
    required this.itemRate,
    this.isRefund = false,
  });
}

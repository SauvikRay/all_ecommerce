class ColorModel {
  int? colorId;
  String? color;
  bool isColorSelected = false;
  int? quantity;
  List<VarientModel>? variant;

  ColorModel(
      {this.colorId,
      this.color,
      required this.isColorSelected,
      this.quantity,
      this.variant});
}

class VarientModel {
  int? varientId;
  int? size;
  String? varientColor;
  int? price;
  int? stock;
  int varientAmount;
  bool isVarientSelected = false;
  VarientModel(
      {this.varientId,
      this.size,
      this.varientColor,
      this.price,
      this.stock,
      this.varientAmount = 0,
      required this.isVarientSelected});
}

class CartedItem {
  int id;
  int itemAmount;
  CartedItem(this.id, this.itemAmount);
}

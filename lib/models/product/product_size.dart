class ProductSize {
  int id;
  String configuredItemsId;
  String size;
  String color;
  int availableQty;
  int currentQty=0;
  dynamic price;
  String vid;
  bool selected;


  ProductSize(
      this.id,
      this.configuredItemsId,
      this.size,
      this.color,
      this.availableQty,
      this.currentQty,
      this.price,
      this.vid,
      this.selected,
);
}

class ProductSize {
  int id;
  String configuredItemsId;
  String size;
  String color;
  int availableQty;
  int currentQty=0;
  String vid;
  bool selected;


  ProductSize(
      this.id,
      this.configuredItemsId,
      this.size,
      this.color,
      this.availableQty,
      this.currentQty,
      this.vid,
      this.selected,
);
}

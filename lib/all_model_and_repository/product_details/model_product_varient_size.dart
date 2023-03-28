class ColorImageNew{
  String vid;
  List<ProductSizedVarient> varient;

  ColorImageNew(this.vid,this.varient);
}

class ProductSizedVarient{
  int id;
  String configuredItemsId;
  String size;
  String color;
  int availableQty;
  int currentQty=0;
  String vid;
  bool selected;
  ProductSizedVarient(this.id,this.configuredItemsId,this.size,this.color,this.availableQty,this.currentQty,this.vid,this.selected);
  
}
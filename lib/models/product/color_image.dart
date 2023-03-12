class ColorImage{
  int id;
  int currentQuantity;
  String colorName;
  String colorImage;
  String vid;
  bool selected;

  ColorImage(this.id,this.currentQuantity,this.colorName,this.colorImage,this.vid,this.selected);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['currentQuantity'] = this.currentQuantity;
    data['colorName'] = this.colorName;
    data['colorImage'] = this.colorImage;
    data['vid'] = this.vid;
    data['selected'] = this.selected;
    return data;
  }

}
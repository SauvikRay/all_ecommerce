class FeaturedValueModel {
  String? name;
  String? value;

  FeaturedValueModel({this.name, this.value});

  FeaturedValueModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Name'] = this.name;
    data['Value'] = this.value;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

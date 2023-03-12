class ConversionRate {
  double? rate;

  ConversionRate({this.rate});

  ConversionRate.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rate'] = this.rate;
    return data;
  }
}
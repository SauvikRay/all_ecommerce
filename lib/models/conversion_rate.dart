class ConversionRate {
  // double? rate;
  dynamic rate;

  ConversionRate({this.rate});

  ConversionRate.fromJson(Map<String, dynamic> json) {
    rate = json['rate'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rate'] = this.rate;
    return data;
  }
}

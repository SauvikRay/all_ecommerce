class ShippingText {
  String? chinaToBdBottomMessage;
  String? chinaToBdBottomMessage2nd;
  String? approxWeightMessage;
  String? alertshow0;

  ShippingText({
        this.chinaToBdBottomMessage,
        this.chinaToBdBottomMessage2nd,
        this.approxWeightMessage,
        this.alertshow0});

  ShippingText.fromJson(Map<String, dynamic> json) {
    chinaToBdBottomMessage = json['china_to_bd_bottom_message'];
    chinaToBdBottomMessage2nd = json['china_to_bd_bottom_message_2nd'];
    approxWeightMessage = json['approx_weight_message'];
    alertshow0 = json['alertshow0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['china_to_bd_bottom_message'] = this.chinaToBdBottomMessage;
    data['china_to_bd_bottom_message_2nd'] = this.chinaToBdBottomMessage2nd;
    data['approx_weight_message'] = this.approxWeightMessage;
    data['alertshow0'] = this.alertshow0;
    return data;
  }
}
class RegistrationErrorResponse {
  String? status;
  String? message;
  List<String>? data;

  RegistrationErrorResponse({ required status, required message, required data}) {
    status = status;
    message = message;
    data = data;
  }

  RegistrationErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}


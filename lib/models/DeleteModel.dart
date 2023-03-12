class DeleteModel{
  List<String>? id;

  DeleteModel({this.id});

  DeleteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
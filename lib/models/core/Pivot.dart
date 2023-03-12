class Pivot {
  int? modelId;
  int? roleId;
  String? modelType;

  Pivot({
    required modelId,
    required roleId,
    required modelType
  }){
    this.modelId = modelId;
    this.roleId = roleId;
    this.modelType = modelType;
  }

  factory Pivot.fromJson(Map<String,dynamic> json){
    return Pivot(
        modelId : json['model_id'],
        roleId: json['role_id'],
        modelType: json['model_type']
    );
  }

  Pivot.fromJsonOld(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    data['model_type'] = this.modelType;

    return data;
  }
}
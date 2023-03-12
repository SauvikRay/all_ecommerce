class PictureModel {
  String? url;
  PictureSize? small;
  PictureSize? medium;
  PictureSize? large;
  bool? isMain;

  PictureModel({this.url, this.small, this.medium, this.large, this.isMain});

  PictureModel.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    small = json['Small'] != null ? PictureSize.fromJson(json['Small']) : null;
    medium = json['Medium'] != null ? PictureSize.fromJson(json['Medium']) : null;
    large = json['Large'] != null ? PictureSize.fromJson(json['Large']) : null;
    isMain = json['IsMain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Url'] = this.url;
    if (this.small != null) {
      data['Small'] = this.small!.toJson();
    }
    if (this.medium != null) {
      data['Medium'] = this.medium!.toJson();
    }
    if (this.large != null) {
      data['Large'] = this.large!.toJson();
    }
    data['IsMain'] = this.isMain;
    return data;
  }
}

class PictureSize {
  String? url;
  int? width;
  int? height;

  PictureSize({this.url, this.width, this.height});

  PictureSize.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    width = json['Width'];
    height = json['Height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Url'] = this.url;
    data['Width'] = this.width;
    data['Height'] = this.height;
    return data;
  }
}

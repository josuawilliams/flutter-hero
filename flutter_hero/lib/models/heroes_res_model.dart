class HeroesResModel {
  String? sId;
  String? name;
  String? type;
  String? imageUrl;
  int? iV;

  HeroesResModel({this.sId, this.name, this.type, this.imageUrl, this.iV});

  HeroesResModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    imageUrl = json['imageUrl'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['imageUrl'] = this.imageUrl;
    data['__v'] = this.iV;
    return data;
  }
}
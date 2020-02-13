class User {
  Viewer viewer;

  User({this.viewer});

  User.fromJson(Map<String, dynamic> json) {
    viewer =
        json['viewer'] != null ? new Viewer.fromJson(json['viewer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.viewer != null) {
      data['viewer'] = this.viewer.toJson();
    }
    return data;
  }
}

class Viewer {
  String name;
  String email;
  String avatarUrl;
  String createdAt;

  Viewer({this.name, this.email, this.avatarUrl, this.createdAt});

  Viewer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatarUrl'] = this.avatarUrl;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

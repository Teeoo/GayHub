class Authorizations {
  int id;
  String url;
  App app;
  String token;
  String hashedToken;
  String tokenLastEight;
  String note;
  Null noteUrl;
  String createdAt;
  String updatedAt;
  List<String> scopes;
  Null fingerprint;

  Authorizations(
      {this.id,
      this.url,
      this.app,
      this.token,
      this.hashedToken,
      this.tokenLastEight,
      this.note,
      this.noteUrl,
      this.createdAt,
      this.updatedAt,
      this.scopes,
      this.fingerprint});

  Authorizations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    app = json['app'] != null ? new App.fromJson(json['app']) : null;
    token = json['token'];
    hashedToken = json['hashed_token'];
    tokenLastEight = json['token_last_eight'];
    note = json['note'];
    noteUrl = json['note_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    scopes = json['scopes'].cast<String>();
    fingerprint = json['fingerprint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    if (this.app != null) {
      data['app'] = this.app.toJson();
    }
    data['token'] = this.token;
    data['hashed_token'] = this.hashedToken;
    data['token_last_eight'] = this.tokenLastEight;
    data['note'] = this.note;
    data['note_url'] = this.noteUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['scopes'] = this.scopes;
    data['fingerprint'] = this.fingerprint;
    return data;
  }
}

class App {
  String name;
  String url;
  String clientId;

  App({this.name, this.url, this.clientId});

  App.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['client_id'] = this.clientId;
    return data;
  }
}

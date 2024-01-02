class NoteModel {
  int? id;
  String? title;
  String? content;
  String? date;
  int? userID;

  NoteModel({this.id, this.title, this.content, this.date, this.userID});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['date'] = date;
    data['userID'] = userID;
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? date;
  String? image;

  Category({this.id, this.title, this.date, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['image'] = this.image;
    return data;
  }
}

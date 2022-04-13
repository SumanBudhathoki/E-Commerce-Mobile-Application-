class Product {
  int? id;
  String? title;
  String? date;
  String? image;
  int? sellingPrice;
  String? description;
  int? category;
  bool? favourite;

  Product(
      {this.id,
      this.title,
      this.date,
      this.image,
      this.sellingPrice,
      this.description,
      this.category,
      this.favourite});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    image = json['image'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    category = json['category'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['image'] = this.image;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    data['category'] = this.category;
    data['favourite'] = this.favourite;
    return data;
  }
}

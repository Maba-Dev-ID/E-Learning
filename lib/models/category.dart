class Category {
  String id;
  String category;

  Category({required this.id, required this.category});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["mapel_id"],
      category: json["nama"],
    );
  }
}

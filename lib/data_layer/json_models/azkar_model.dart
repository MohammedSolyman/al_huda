class AzkarModel {
  List<Azkar>? azkar;
  List<Category>? categories;

  AzkarModel({
    this.azkar,
    this.categories,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) => AzkarModel(
        azkar: json["azkar"] == null
            ? []
            : List<Azkar>.from(json["azkar"]!.map((x) => Azkar.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "azkar": azkar == null
            ? []
            : List<dynamic>.from(azkar!.map((x) => x.toJson())),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Azkar {
  int? zekarId;
  String? zekarText;
  int? repeatNumber;
  String? tabweeb;

  Azkar({
    this.zekarId,
    this.zekarText,
    this.repeatNumber,
    this.tabweeb,
  });

  factory Azkar.fromJson(Map<String, dynamic> json) => Azkar(
        zekarId: json["ZekarID"],
        zekarText: json["ZekarText"],
        repeatNumber: json["RepeatNumber"],
        tabweeb: json["Tabweeb"],
      );

  Map<String, dynamic> toJson() => {
        "ZekarID": zekarId,
        "ZekarText": zekarText,
        "RepeatNumber": repeatNumber,
        "Tabweeb": tabweeb,
      };
}

class Category {
  int? categoryId;
  String? category;

  Category({
    this.categoryId,
    this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["CategoryID"],
        category: json["Category"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryID": categoryId,
        "Category": category,
      };
}

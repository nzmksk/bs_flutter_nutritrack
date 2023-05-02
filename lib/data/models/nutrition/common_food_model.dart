class CommonFoodModel {
  String? foodName;
  String? imageUrl;

  CommonFoodModel({
    this.foodName,
    this.imageUrl,
  });

  CommonFoodModel.fromJson(Map<String, String> json) {
    foodName = json['food_name'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['food_name'] = foodName;
    data['image'] = imageUrl;

    return data;
  }
}

class CommonFoodModel {
  String? foodName;
  String? imageUrl;
  String? error;

  CommonFoodModel({
    this.foodName,
    this.imageUrl,
  });

  CommonFoodModel.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['food_name'] = foodName;
    data['image'] = imageUrl;

    return data;
  }

  CommonFoodModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

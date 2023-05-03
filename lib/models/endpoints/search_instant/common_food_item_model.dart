class CommonFoodItemModel {
  String? foodName;
  String? imageUrl;
  String? error;

  CommonFoodItemModel({
    this.foodName,
    this.imageUrl,
  });

  CommonFoodItemModel.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['food_name'] = foodName;
    data['image'] = imageUrl;

    return data;
  }

  CommonFoodItemModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

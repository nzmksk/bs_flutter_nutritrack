import '../../models.dart';

class FoodListModel {
  List<BrandedFoodItemModel>? brandedFood;
  List<CommonFoodItemModel>? commonFood;
  String? error;

  FoodListModel({this.brandedFood, this.commonFood});

  FoodListModel.fromJson(Map<String, dynamic> json) {
    if (json['branded'] != null) {
      brandedFood = [];
      json['branded'].forEach(
        (foodItem) {
          brandedFood!.add(BrandedFoodItemModel.fromJson(foodItem));
        },
      );
    }

    if (json['common'] != null) {
      commonFood = [];
      json['common'].forEach(
        (foodItem) {
          commonFood!.add(CommonFoodItemModel.fromJson(foodItem));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brandedFood != null) {
      data['branded'] =
          brandedFood!.map((foodItem) => foodItem.toJson()).toList();
    }

    if (commonFood != null) {
      data['common'] =
          commonFood!.map((foodItem) => foodItem.toJson()).toList();
    }

    return data;
  }

  FoodListModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

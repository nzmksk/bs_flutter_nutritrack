import '../../models.dart';

class NutritionModel {
  List<BrandedFoodModel>? brandedFood;
  List<CommonFoodModel>? commonFood;
  String? error;

  NutritionModel({this.brandedFood, this.commonFood});

  NutritionModel.fromJson(Map<String, dynamic> json) {
    if (json['branded'] != null) {
      brandedFood = [];
      json['branded'].forEach(
        (foodItem) {
          brandedFood!.add(BrandedFoodModel.fromJson(foodItem));
        },
      );
    }

    if (json['common'] != null) {
      commonFood = [];
      json['common'].forEach(
        (foodItem) {
          commonFood!.add(CommonFoodModel.fromJson(foodItem));
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

  NutritionModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

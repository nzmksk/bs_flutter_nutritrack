class BrandedFoodNutritionModel {
  String? foodName;
  num? servingAmount;
  String? meal;
  num? servingQuantity;
  String? servingUnit;
  num? servingWeight;
  num? totalCalories;
  num? totalFat;
  num? saturatedFat;
  num? cholesterol;
  num? sodium;
  num? totalCarbohydrates;
  num? dietaryFiber;
  num? sugars;
  num? protein;
  num? potassium;
  String? brandName;
  String? brandId;
  String? brandItemName;
  String? itemId;
  String? imageUrl;

  BrandedFoodNutritionModel({
    this.foodName,
    this.servingAmount,
    this.meal,
    this.servingQuantity,
    this.servingUnit,
    this.servingWeight,
    this.totalCalories,
    this.totalFat,
    this.saturatedFat,
    this.cholesterol,
    this.sodium,
    this.totalCarbohydrates,
    this.dietaryFiber,
    this.sugars,
    this.protein,
    this.potassium,
    this.brandName,
    this.brandId,
    this.brandItemName,
    this.itemId,
    this.imageUrl,
  });

  BrandedFoodNutritionModel.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    servingAmount = json['serving_amount'] ?? 1;
    meal = json['meal'];
    servingQuantity = json['serving_qty'];
    servingUnit = json['serving_unit'];
    servingWeight = json['serving_weight_grams'];
    totalCalories = json['nf_calories'];
    totalFat = json['nf_total_fat'] ?? 0;
    saturatedFat = json['nf_saturated_fat'] ?? 0;
    cholesterol = json['nf_cholesterol'] ?? 0;
    sodium = json['nf_sodium'] ?? 0;
    totalCarbohydrates = json['nf_total_carbohydrate'] ?? 0;
    dietaryFiber = json['nf_dietary_fiber'] ?? 0;
    sugars = json['nf_sugars'] ?? 0;
    protein = json['nf_protein'] ?? 0;
    potassium = json['nf_potassium'] ?? 0;
    brandName = json['nix_brand_name'];
    brandId = json['nix_brand_id'];
    brandItemName = json['nix_item_name'];
    itemId = json['nix_item_id'];
    imageUrl = json['photo']['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'food_name': foodName,
      'serving_amount': servingAmount,
      'meal': meal,
      'serving_qty': servingQuantity,
      'serving_unit': servingUnit,
      'serving_weight_grams': servingWeight,
      'nf_calories': totalCalories,
      'nf_total_fat': totalFat,
      'nf_saturated_fat': saturatedFat,
      'nf_cholesterol': cholesterol,
      'nf_sodium': sodium,
      'nf_total_carbohydrate': totalCarbohydrates,
      'nf_dietary_fiber': dietaryFiber,
      'nf_sugars': sugars,
      'nf_protein': protein,
      'nf_potassium': potassium,
      'nix_brand_name': brandName,
      'nix_brand_id': brandId,
      'nix_item_name': brandItemName,
      'nix_item_id': itemId,
      'photo': {
        'thumb': imageUrl,
      },
    };
    return data;
  }
}

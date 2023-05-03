class BrandedFoodNutritionModel {
  String? foodName;
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
    servingQuantity = json['serving_qty'];
    servingUnit = json['serving_unit'];
    servingWeight = json['serving_weight_grams'];
    totalCalories = json['nf_calories'];
    totalFat = json['nf_total_fat'];
    saturatedFat = json['nf_saturated_fat'];
    cholesterol = json['nf_cholesterol'];
    sodium = json['nf_sodium'];
    totalCarbohydrates = json['nf_total_carbohydrate'];
    dietaryFiber = json['nf_dietary_fiber'];
    sugars = json['nf_sugars'];
    protein = json['nf_protein'];
    potassium = json['nf_potassium'];
    brandName = json['nix_brand_name'];
    brandId = json['nix_brand_id'];
    brandItemName = json['nix_item_name'];
    itemId = json['nix_item_id'];
    imageUrl = json['photo']['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food_name'] = foodName;
    data['serving_qty'] = servingQuantity;
    data['serving_unit'] = servingUnit;
    data['serving_weight_grams'] = servingWeight;
    data['nf_calories'] = totalCalories;
    data['nf_total_fat'] = totalFat;
    data['nf_saturated_fat'] = saturatedFat;
    data['nf_cholesterol'] = cholesterol;
    data['nf_sodium'] = sodium;
    data['nf_total_carbohydrate'] = totalCarbohydrates;
    data['nf_dietary_fiber'] = dietaryFiber;
    data['nf_sugars'] = sugars;
    data['nf_protein'] = protein;
    data['nf_potassium'] = potassium;
    data['nix_brand_name'] = brandName;
    data['nix_brand_id'] = brandId;
    data['nix_item_name'] = brandItemName;
    data['nix_item_id'] = itemId;
    data['photo']['thumb'] = imageUrl;

    return data;
  }
}

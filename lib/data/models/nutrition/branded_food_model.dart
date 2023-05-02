class BrandedFoodModel {
  String? foodName;
  String? imageUrl;
  String? servingUnit;
  String? brandId;
  String? brandItemName;
  num? servingQuantity;
  num? totalCalories;
  String? brandName;
  String? itemId;

  BrandedFoodModel({
    this.foodName,
    this.imageUrl,
    this.servingUnit,
    this.brandId,
    this.brandItemName,
    this.servingQuantity,
    this.totalCalories,
    this.brandName,
    this.itemId,
  });

  BrandedFoodModel.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    imageUrl = json['image'];
    servingUnit = json['serving_unit'];
    brandId = json['nix_brand_id'];
    brandItemName = json['brand_name_item_name'];
    servingQuantity = json['serving_qty'];
    totalCalories = json['nf_calories'];
    brandName = json['brand_name'];
    itemId = json['nix_item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['food_name'] = foodName;
    data['image'] = imageUrl;
    data['serving_unit'] = servingUnit;
    data['nix_brand_id'] = brandId;
    data['brand_name_item_name'] = brandItemName;
    data['serving_qty'] = servingQuantity;
    data['nf_calories'] = totalCalories;
    data['brand_name'] = brandName;
    data['nix_item_id'] = itemId;

    return data;
  }
}

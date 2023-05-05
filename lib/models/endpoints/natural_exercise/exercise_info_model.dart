class ExerciseInfoModel {
  num? tagId;
  String? userInput;
  num? durationMin;
  num? metabolicEquivalentTask;
  num? caloriesBurnt;
  String? imageUrl;
  String? exerciseName;

  ExerciseInfoModel({
    this.tagId,
    this.userInput,
    this.durationMin,
    this.metabolicEquivalentTask,
    this.caloriesBurnt,
    this.imageUrl,
    this.exerciseName,
  });

  ExerciseInfoModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    userInput = json['user_input'];
    durationMin = json['duration_min'];
    metabolicEquivalentTask = json['met'];
    caloriesBurnt = json['nf_calories'];
    imageUrl = json['photo']['thumb'];
    exerciseName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'tag_id': tagId,
      'user_input': userInput,
      'duration_min': durationMin,
      'met': metabolicEquivalentTask,
      'nf_calories': caloriesBurnt,
      'photo': {'thumb': imageUrl},
      'name': exerciseName,
    };

    return data;
  }
}

class Meal {
  String id = "",
      type = "",
      content = "",
      dailyDataId = "",
      createdAt = "",
      updatedAt = "";
  int hour = 0, glycemiaBefore = 0, glycemiaAfter = 0;

  Meal();

  Meal.fromJson(Map<String, dynamic> meal) {
    id = meal["id"];
    type = meal["type"];
    content = meal["content"];
    dailyDataId = meal["daily_data_id"];
    hour = meal["hour"];
    glycemiaBefore = meal["glycemia_before"];
    glycemiaAfter = meal["glycemia_after"];
    createdAt = meal["created_at"];
    updatedAt = meal["updated_at"];
  }

  @override
  String toString() {
    return "{id : $id, type : $type, content : $content, "
        "dailyDataId : $dailyDataId, createdAt : $createdAt, updatedAt : $updatedAt, hour : $hour, glycemiaBefore : $glycemiaBefore, glycemiaAfter : $glycemiaAfter}";
  }
}

class DailyData {
  String id = "", createdAt = "", updatedAt = "";
  int nbHypoglycemia = 0, nbHyperglycemia = 0, isSick = 0;

  DailyData();

  DailyData.fromStorage(this.id, this.nbHyperglycemia, this.nbHypoglycemia,
      this.isSick, this.createdAt, this.updatedAt);

  // DailyData(this.id, this.nbHyperglycemia, this.nbHypoglycemia, this.isSick,
  //     this.createdAt, this.updatedAt);

  DailyData.fromJson(Map<String, dynamic> dailyData) {
    id = dailyData["id"];
    nbHyperglycemia = dailyData["nb_hyperglycemia"];
    nbHypoglycemia = dailyData["nb_hypoglycemia"];
    isSick = dailyData["is_sick"] as int;
    createdAt = dailyData["created_at"];
    updatedAt = dailyData["updated_at"];
  }

  bool isForCurrentDay() {
    final String currentDate = DateTime.now().toString().split(" ")[0];
    final bool isForcurrentDay =
        createdAt != "" && createdAt.split('T')[0] == currentDate;
    // print("isForcurrent day method de classe : $isForcurrentDay");
    return isForcurrentDay;
  }

  @override
  String toString() {
    return "{id : $id, nbHypoglycemia : $nbHypoglycemia, nbHyperglycemia : $nbHyperglycemia, "
        "isSick : $isSick, createdAt : $createdAt, updatedAt : $updatedAt}";
  }
}

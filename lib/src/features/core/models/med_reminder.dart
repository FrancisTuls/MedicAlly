class MedReminder {
  String? id;
  String? medName;
  int? stock;
  int? dosage;
  int? isCompleted;
  String? startDate;
  String? remTime;
  int? container;

  MedReminder(
      {this.id,
      this.medName,
      this.stock,
      this.dosage,
      this.isCompleted,
      this.startDate,
      this.remTime,
      this.container});

  MedReminder.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    medName = json["medName"];
    stock = json["stock"];
    dosage = json["dosage"];
    isCompleted = json["isCompleted"];
    startDate = json["startDate"];
    remTime = json["remTime"];
    container = json["container"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medName'] = medName;
    data['dosage'] = dosage;
    data['isCompleted'] = isCompleted;
    data['startDate'] = startDate;
    data['remTime'] = remTime;
    data['container'] = container;
    return data;
  }
}

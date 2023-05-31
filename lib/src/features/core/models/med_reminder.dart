class MedReminder {
  int? id;
  String? medName;
  int? stock;
  int? dosage;
  int? isCompleted;
  String? startDate;
  String? endDate;
  String? remTime;
  Map<String, int>? medicationStatus;
  //int? container;

  MedReminder({
    this.id,
    this.medName,
    this.stock,
    this.dosage,
    this.isCompleted,
    this.startDate,
    this.endDate,
    this.remTime,
    this.medicationStatus,
    /*this.container*/
  });

  MedReminder.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    medName = json["medName"];
    stock = json["stock"];
    dosage = json["dosage"];
    isCompleted = json["isCompleted"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    remTime = json["remTime"];
    medicationStatus = json["medicationStatus"] != null
        ? Map<String, int>.from(json["medicationStatus"])
        : null;

    //container = json["container"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medName'] = medName;
    data['dosage'] = dosage;
    data['isCompleted'] = isCompleted;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['remTime'] = remTime;
    data['medicationStatus'] = medicationStatus;
    //data['container'] = container;
    data['stock'] = stock;
    return data;
  }
}

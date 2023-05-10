class MedDetails {
  String? id;
  String? medName;
  int? stock;
  int? container;

  MedDetails({this.id, this.medName, this.stock, this.container});

  MedDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    medName = json["medName"];
    stock = json["stock"];
    container = json["container"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medName'] = medName;
    data['container'] = container;
    data['stock'] = stock;
    return data;
  }
}

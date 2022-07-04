class Medicine {
  String medicineID;
  String medicineName;
  String imageURL;
  String data;
  List<dynamic> useOptionID;

  Medicine({
    this.medicineID,
    this.medicineName,
    this.imageURL,
    this.data,
    this.useOptionID,
  });

  factory Medicine.fromMap(map) {
    return Medicine(
      medicineID: map['medicineID'],
      medicineName: map['medicineName'],
      imageURL: map['imageURL'],
      data: map['data'],
      useOptionID: map['useOptionID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicineID': medicineID,
      'medicineName': medicineName,
      'imageURL': imageURL,
      'data': data,
      'useOptionID': useOptionID,
    };
  }

  static Medicine fromJson(Map<String, dynamic> json) => Medicine(
        medicineID: json['medicineID'],
        medicineName: json['medicineName'],
        imageURL: json['imageURL'],
        data: json['data'],
        useOptionID: json['useOptionID'],
      );
}

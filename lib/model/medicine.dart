class Medicine {
  String medicineID;
  String medicineName;
  String imageURL;
  String data;
  String useOptionID_1;
  String useOptionID_2;

  Medicine({
    this.medicineID,
    this.medicineName,
    this.imageURL,
    this.data,
    this.useOptionID_1,
    this.useOptionID_2,
  });

  factory Medicine.fromMap(map) {
    return Medicine(
      medicineID: map['medicineID'],
      medicineName: map['medicineName'],
      imageURL: map['imageURL'],
      data: map['data'],
      useOptionID_1: map['useOptionID_1'],
      useOptionID_2: map['useOptionID_2'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicineID': medicineID,
      'medicineName': medicineName,
      'imageURL': imageURL,
      'data': data,
      'useOptionID_1': useOptionID_1,
      'useOptionID_2': useOptionID_2,
    };
  }
}

class VendorsUserModel {
  final bool? approved;
  final String? businessName;
  final String? email;
  final String? phoneNumber;
  final String? countryValue;
  final String? stateValue;
  final String? cityValue;
  final String? storeImage;
  final String? taxNumber;
  final String? taxRegistered;

  VendorsUserModel({
    required this.approved,
    required this.businessName,
    required this.email,
    required this.phoneNumber,
    required this.countryValue,
    required this.stateValue,
    required this.cityValue,
    required this.storeImage,
    required this.taxNumber,
    required this.taxRegistered,
  });

  VendorsUserModel.fromJson(Map<String, Object?> json)
      : this(
    approved: json['approved'] as bool?,
    businessName: json['businessName'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    countryValue: json['countryValue'] as String?,
    stateValue: json['stateValue'] as String?,
    cityValue: json['cityValue'] as String?,
    storeImage: json['storeImage'] as String?,
    taxNumber: json['taxNumber'] as String?,
    taxRegistered: json['taxRegistered'] as String?,
  );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'businessName': businessName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryValue': countryValue,
      'stateValue': stateValue,
      'cityValue': cityValue,
      'storeImage': storeImage,
      'taxNumber': taxNumber,
      'taxRegistered': taxRegistered,
    };
  }
}

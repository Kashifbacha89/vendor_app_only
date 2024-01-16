class VendorsUserModel{
  final bool approved;
  final String businessName;
  final String email;
  final String phoneNo;
  final String country;
  final String state;
  final String city;
  final String storeImage;
  final String taxNumber;
  final String taxRegistered;

  VendorsUserModel(this.approved, this.businessName, this.email, this.phoneNo,
      this.country, this.state, this.city, this.storeImage, this.taxNumber,this.taxRegistered);
}
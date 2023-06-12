class VenderModel {
  bool? approved;
  String? vendorId;
  String? bussinessName;
  String? city;
  String? country;
  String? email;
  String? image;
  String? phone;
  String? state;
  String? taxStatus;
  String? taxNo;
  VenderModel({
    this.approved,
    this.vendorId,
    this.bussinessName,
    this.city,
    this.country,
    this.email,
    this.image,
    this.phone,
    this.state,
    this.taxStatus,
    this.taxNo,
  });

  VenderModel.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    vendorId = json['vendorId'];
    bussinessName = json['bussinessName'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    state = json['state'];
    taxStatus = json['taxStatus'];
    taxNo = json['taxNo'];
  }
}

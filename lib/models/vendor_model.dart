class VendorModel {
 final bool? approved;
 final String vendorId;
 final String bussinessName;
 final String city;
 final String country;
 final String email;
 final String image;
 final String coverImage;
 final String phone;
 final String state;
 final String taxStatus;
 final String taxNo;
  VendorModel({
   required this.approved,
   required this.vendorId,
   required this.bussinessName,
   required this.city,
   required this.country,
   required this.email,
   required this.image,
   required this.coverImage,
   required this.phone,
   required this.state,
   required this.taxStatus,
   required this.taxNo,
  });

  VendorModel.fromJson(Map<String, Object?> json)
   : this(
    approved : json['approved']! as bool,
    vendorId : json['vendorId']! as String,
    bussinessName : json['bussinessName']! as String,
    city : json['city']! as String,
    country : json['country']! as String,
    email : json['email']! as String,
    image : json['image']! as String,
    coverImage : json['coverImage']! as String,
    phone : json['phone']! as String,
    state : json['state']! as String,
    taxStatus : json['taxStatus']! as String,
    taxNo : json['taxNo']! as String,
  );

  Map<String, Object?> toJson(){
    return {
      'approved' : approved,
      'vendorId' : vendorId,
      'bussinessName' : bussinessName,
      'city' : city,
      'country' : country,
      'email' : email,
      'image' : image,
      'coverImage' : coverImage,
      'phone' : phone,
      'state' : state,
      'taxStatus' : taxStatus,
      'taxNo' : taxNo,
    };
  }
}
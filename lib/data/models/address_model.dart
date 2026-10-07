class AddressModel {
  final String fullName;
  final String phone;
  final String flatOrBuilding;
  final String areaOrStreet;
  final String city;
  final String pincode;
  final String tag;

  const AddressModel({
    required this.fullName,
    required this.phone,
    required this.flatOrBuilding,
    required this.areaOrStreet,
    required this.city,
    required this.pincode,
    this.tag = 'Home',
  });

  String get formattedAddress => '$flatOrBuilding, $areaOrStreet, $city - $pincode';

  AddressModel copyWith({
    String? fullName,
    String? phone,
    String? flatOrBuilding,
    String? areaOrStreet,
    String? city,
    String? pincode,
    String? tag,
  }) {
    return AddressModel(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      flatOrBuilding: flatOrBuilding ?? this.flatOrBuilding,
      areaOrStreet: areaOrStreet ?? this.areaOrStreet,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      tag: tag ?? this.tag,
    );
  }
}

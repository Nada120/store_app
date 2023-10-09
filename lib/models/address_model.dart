class AddressModel {
  final String lat;
  final String long;
  final String city;
  final String? streat;
  final int number;
  final String? zipcode;

  AddressModel({
    required this.lat,
    required this.long,
    required this.city,
    required this.streat,
    required this.number,
    required this.zipcode,
  });

  factory AddressModel.fromJSON(Map<String, dynamic> json) => AddressModel(
        lat: json['geolocation']['lat'],
        long: json['geolocation']['long'],
        city: json['city'],
        streat: json['streat'],
        number: json['number'],
        zipcode: json['zipcode)'],
      );
}

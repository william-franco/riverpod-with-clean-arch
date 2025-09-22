import 'package:riverpod_with_clean_arch/src/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final Address? address;
  @override
  final String? phone;
  @override
  final String? website;
  @override
  final Company? company;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    address: json['address'] == null ? null : Address.fromJson(json['address']),
    phone: json['phone'],
    website: json['website'],
    company: json['company'] == null ? null : Company.fromJson(json['company']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'address': address?.toJson(),
    'phone': phone,
    'website': website,
    'company': company?.toJson(),
  };
}

class Address extends AddressEntity {
  @override
  final String? street;
  @override
  final String? suite;
  @override
  final String? city;
  @override
  final String? zipcode;
  @override
  final Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: json['geo'] == null ? null : Geo.fromJson(json['geo']),
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'suite': suite,
    'city': city,
    'zipcode': zipcode,
    'geo': geo?.toJson(),
  };
}

class Geo extends GeoEntity {
  @override
  final String? lat;
  @override
  final String? lng;

  Geo({this.lat, this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json['lat'], lng: json['lng']);

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class Company extends CompanyEntity {
  @override
  final String? name;
  @override
  final String? catchPhrase;
  @override
  final String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'],
    catchPhrase: json['catchPhrase'],
    bs: json['bs'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'catchPhrase': catchPhrase,
    'bs': bs,
  };
}

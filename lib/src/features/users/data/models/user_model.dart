import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.name,
    super.username,
    super.email,
    super.address,
    super.phone,
    super.website,
    super.company,
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
    'address': (address as Address?)?.toJson(),
    'phone': phone,
    'website': website,
    'company': (company as Company?)?.toJson(),
  };
}

class Address extends AddressEntity {
  Address({super.street, super.suite, super.city, super.zipcode, super.geo});

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
    'geo': (geo as Geo?)?.toJson(),
  };
}

class Geo extends GeoEntity {
  Geo({super.lat, super.lng});

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json['lat'], lng: json['lng']);

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class Company extends CompanyEntity {
  Company({super.name, super.catchPhrase, super.bs});

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

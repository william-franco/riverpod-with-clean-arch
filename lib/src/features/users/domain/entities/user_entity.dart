class UserEntity {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressEntity? address;
  final String? phone;
  final String? website;
  final CompanyEntity? company;

  UserEntity({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  UserEntity copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    AddressEntity? address,
    String? phone,
    String? website,
    CompanyEntity? company,
  }) => UserEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    username: username ?? this.username,
    email: email ?? this.email,
    address: address ?? this.address,
    phone: phone ?? this.phone,
    website: website ?? this.website,
    company: company ?? this.company,
  );
}

class AddressEntity {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoEntity? geo;

  AddressEntity({this.street, this.suite, this.city, this.zipcode, this.geo});

  AddressEntity copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    GeoEntity? geo,
  }) => AddressEntity(
    street: street ?? this.street,
    suite: suite ?? this.suite,
    city: city ?? this.city,
    zipcode: zipcode ?? this.zipcode,
    geo: geo ?? this.geo,
  );
}

class GeoEntity {
  final String? lat;
  final String? lng;

  GeoEntity({this.lat, this.lng});

  GeoEntity copyWith({String? lat, String? lng}) =>
      GeoEntity(lat: lat ?? this.lat, lng: lng ?? this.lng);
}

class CompanyEntity {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  CompanyEntity({this.name, this.catchPhrase, this.bs});

  CompanyEntity copyWith({String? name, String? catchPhrase, String? bs}) =>
      CompanyEntity(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        bs: bs ?? this.bs,
      );
}

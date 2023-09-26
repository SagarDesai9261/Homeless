class UserApp {
  final String? uid;
  final String? organizationName;
  final String? email;
  final String? contactPerson;
  final String? phone;
  final String? password;
  final String? fullName;
  final String? address;
  final String? apartmentName;
  final String? city;
  final String? state;
  final String? country;

  UserApp({
    this.uid,
    this.organizationName,
    this.email,
    this.contactPerson,
    this.phone,
    this.password,
    this.fullName,
    this.address,
    this.apartmentName,
    this.city,
    this.state,
    this.country,
  });

  UserApp copyWith({
    String? uid,
    String? organizationName,
    String? email,
    String? contactPerson,
    String? phone,
    String? password,
    String? fullName,
    String? address,
    String? apartmentName,
    String? city,
    String? state,
    String? country,
  }) {
    return UserApp(
      uid: uid ?? this.uid,
      organizationName: organizationName ?? this.organizationName,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      apartmentName: apartmentName ?? this.apartmentName,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }
}

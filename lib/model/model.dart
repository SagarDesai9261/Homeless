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

class Merchant {
  final String? Name;
  final String? Email;
  final String? Phone;
  final String? ChoosePassword;
  final String? ConfirmPassword;
  //business detail
  final String? BusinessName;
  final String? BusinessCategory;
  final String? StreetAddress;
  final String? AreaSector;
  final int? Pincode;
  final String? State;
  final String? Country;
  //bank detail
  final String? AccountNumber;
  final String? BankName;
  final String? CityBank;
  final String? StateBank;
  final String? BranchLocation;

  Merchant({
    //
    this.Name,
    this.Email,
    this.Phone,
    this.ChoosePassword,
    this.ConfirmPassword,
    //business
    this.BusinessName,
    this.BusinessCategory,
    this.StreetAddress,
    this.AreaSector,
    this.Pincode,
    this.State,
    this.Country,
    //bank
    this.AccountNumber,
    this.BankName,
    this.CityBank,
    this.StateBank,
    this.BranchLocation,
  });
}

class ChatPerson {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? lastMessage;
  final String? lastMessageTimestamp;

  ChatPerson({
    this.id,
    this.name,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageTimestamp,
  });
}

class Message {
  final String id;
  final String text;
  final String senderId;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });
}

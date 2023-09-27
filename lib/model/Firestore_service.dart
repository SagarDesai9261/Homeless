import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserRecord(UserApp user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'organizationName': user.organizationName,
        'email': user.email,
        'contactPerson': user.contactPerson,
        'phone': user.phone,
        'password': user.password,
        'fullName': user.fullName,
        'address': user.address,
        'apartmentName': user.apartmentName,
        'city': user.city,
        'state': user.state,
        'country': user.country,
      });
    } catch (e) {
      print('Error creating user record: $e');
    }
  }

  Future<UserApp?> getUserData(String uid) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return UserApp(
          uid: uid,
          organizationName: data['organizationName'],
          email: data['email'],
          contactPerson: data['contactPerson'],
          phone: data['phone'],
          password: data['password'],
          fullName: data['fullName'],
          address: data['address'],
          apartmentName: data['apartmentName'],
          city: data['city'],
          state: data['state'],
          country: data['country'],
        );
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> addMerchantData(Merchant merchant) async {
    try {
      await _firestore.collection('merchants').add({
        'Name': merchant.Name,
        'Email': merchant.Email,
        'Phone': merchant.Phone,
        'ChoosePassword': merchant.ChoosePassword,
        'ConfirmPassword': merchant.ConfirmPassword,
        'BusinessName': merchant.BusinessName,
        'BusinessCategory': merchant.BusinessCategory,
        'StreetAddress': merchant.StreetAddress,
        'AreaSector': merchant.AreaSector,
        'Pincode': merchant.Pincode,
        'State': merchant.State,
        'Country': merchant.Country,
        'AccountNumber': merchant.AccountNumber,
        'BankName': merchant.BankName,
        'CityBank': merchant.CityBank,
        'StateBank': merchant.StateBank,
        'BranchLocation': merchant.BranchLocation,
      });
    } catch (e) {
      print('Error adding merchant data: $e');
    }
  }
}

class Users {
  final String uid;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String password;
  final String? email;
  final String? dob;

  Users({
    required this.uid,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.dob
  });

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      uid: data['uid'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      firstName: data['firtName'] ?? '',
      lastName: data['lastName'] ?? '',
      password: data['password'] ?? '',
      email: data['email'],
      dob: data['dob'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'uid': uid,
      'phoneNumber':phoneNumber,
      'firstName':firstName,
      'lastName': lastName,
      'password': password,
      'email':email,
      'dob':dob
    };
  }

   Users copyWith({
    String? uid,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? password,
    String? email,
    String? dob,
  }) {
    return Users(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      email: email ?? this.email,
      dob: dob ?? this.dob,
    );
  }
}

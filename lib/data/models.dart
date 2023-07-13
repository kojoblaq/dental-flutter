import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String middleName;
  DateTime dateOfBirth;
  String address;
  String phoneNumber;
  String email;
  String gender;

  User({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateOfBirth,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.gender,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      address: json['address'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      gender: json['gender'],
    );
  }
}

class Patient {
  User user;
  String occupation;
  String medicalHistory;
  String insuranceNumber;
  String insuranceProvider;
  String emergencyContactName;
  String emergencyContactNumber;

  Patient({
    required this.user,
    required this.occupation,
    required this.medicalHistory,
    required this.insuranceNumber,
    required this.insuranceProvider,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'occupation': occupation,
      'medicalHistory': medicalHistory,
      'insuranceNumber': insuranceNumber,
      'insuranceProvider': insuranceProvider,
      'emergencyContactName': emergencyContactName,
      'emergencyContactNumber': emergencyContactNumber
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      user: User.fromJson(map['user']),
      occupation: map['occupation'],
      medicalHistory: map['medicalHistory'],
      insuranceNumber: map['insuranceNumber'],
      insuranceProvider: map['insuranceProvider'],
      emergencyContactName: map['emergencyContactName'],
      emergencyContactNumber: map['emergencyContactNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(Map<String, dynamic> source) =>
      Patient.fromMap(source);

  @override
  String toString() {
    return 'Patient(user:$user, occupation:$occupation, medicalHistory:$medicalHistory, insuranceNumber:$insuranceNumber, insuranceProvider:$insuranceProvider, emergencyContactName:$emergencyContactName, emergencyContactNumber:$emergencyContactNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.user == user &&
        other.occupation == occupation &&
        other.medicalHistory == medicalHistory &&
        other.insuranceNumber == insuranceNumber &&
        other.insuranceProvider == insuranceProvider &&
        other.emergencyContactName == emergencyContactName &&
        other.emergencyContactNumber == emergencyContactNumber;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        occupation.hashCode ^
        medicalHistory.hashCode ^
        insuranceNumber.hashCode ^
        insuranceProvider.hashCode ^
        emergencyContactName.hashCode ^
        emergencyContactNumber.hashCode;
  }
}

class Doctor {
  User user;
  String qualification;
  String specialization;
  int experienceYears;
  String bio;
  String profilePicture;

  Doctor({
    required this.user,
    required this.qualification,
    required this.specialization,
    required this.experienceYears,
    required this.bio,
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'qualification': qualification,
      'specialization': specialization,
      'experienceYears': experienceYears,
      'bio': bio,
      'profilePicture': profilePicture,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      user: User.fromJson(map['user']),
      qualification: map['qualification'],
      specialization: map['specialization'],
      experienceYears: map['experience_years'],
      bio: map['bio'],
      profilePicture: map['profile_picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(Map<String, dynamic> source) =>
      Doctor.fromMap(source);

  @override
  String toString() {
    return 'Doctor { user:$user, $qualification, specialization: $specialization, experienceYears: $experienceYears, bio: $bio, profilePicture: $profilePicture }';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Doctor &&
        other.user == user &&
        other.qualification == qualification &&
        other.specialization == specialization &&
        other.experienceYears == experienceYears &&
        other.bio == bio &&
        other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return user.hashCode ^ qualification.hashCode ^ specialization.hashCode ^ experienceYears.hashCode ^ bio.hashCode ^ profilePicture.hashCode;
  }
}

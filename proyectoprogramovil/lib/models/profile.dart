import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String? id;
  String? userId;
  String? role;
  String? workshopId;
  bool isActive;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Profile({
    this.id,
    this.userId,
    this.role,
    this.workshopId,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Profile(
      id: snapshot.id,
      userId: data!['userId'],
      role: data['role'],
      workshopId: data['workshopId'],
      isActive: data['isActive'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (role != null) "role": role,
      if (workshopId != null) "workshopId": workshopId,
      "isActive": isActive,
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
    };
  }
}

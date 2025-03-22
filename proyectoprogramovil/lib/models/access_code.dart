import 'package:cloud_firestore/cloud_firestore.dart';

class AccessCode {
  String? id;
  int? code;
  String? role;
  String? workshopId;
  Timestamp? createdAt;

  AccessCode({this.id, this.role, this.code, this.workshopId, this.createdAt});

  factory AccessCode.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return AccessCode(
      id: snapshot.id,
      code: data!['code'],
      role: data['role'],
      workshopId: data['workshopId'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (code != null) "code": code,
      if (role != null) "role": role,
      if (workshopId != null) "workshopId": workshopId,
      if (createdAt != null) "createdAt": createdAt,
    };
  }
}

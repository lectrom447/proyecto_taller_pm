import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class ProfileRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('profiles')
      .withConverter(
        fromFirestore: Profile.fromFirestore,
        toFirestore: (Profile profile, options) => profile.toFirestore(),
      );

  Future<List<Profile>> findAll(String userId) async {
    final result =
        await collectionRef
            .where('userId', isEqualTo: userId)
            .where('isActive', isEqualTo: true)
            .get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Future create(Profile newProfile) async {
    final documentRef = collectionRef.doc();
    newProfile.createdAt = Timestamp.now();
    await documentRef.set(newProfile);
  }

  Future update(Profile profile) async {
    final documentRef = collectionRef.doc(profile.id);
    profile.updatedAt = Timestamp.now();
    await documentRef.update(profile.toFirestore());
  }

  Future delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.update({'isActive': false});
  }
}

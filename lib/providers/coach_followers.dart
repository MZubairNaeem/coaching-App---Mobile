import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCoachFollowersProvider =
    FutureProvider.family<int, String?>((ref, id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Subscriptions')
      .where('subscribed', isEqualTo: id)
      .get();
  return snapshot.docs.length;
});

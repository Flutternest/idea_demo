import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/category.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return FirebaseFirestore.instance
      .collection("categories")
      .get()
      .then((value) {
    final categories =
        value.docs.map((e) => Category.fromJson(e.data())).toList();
    return categories;
  });
});

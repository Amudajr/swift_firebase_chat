// import 'dart:async';
// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class Utils {
//   static StreamTransformer transformer<T>(
//           T Function(Map<String, dynamic> json) fromJson) =>
//       StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
//         handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
//           final snaps = data.documents.map((e) => e.data).toList();
//           final user = snaps.map((json) => fromJson(json)).toList();

//           sink.add(user);
//         },
//       );

//   static DateTime? toDateTime(Timestamp value) {
//     if (value == null) return null;

//     return value.toDate();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Alamat {
  final String provinsi;
  final String kota;
  final String kecamatan;
  final String kodePos;
  final String detailAlamat;
  final String userId;
  final Timestamp createdAt;

  Alamat(
      {required this.provinsi,
      required this.kota,
      required this.kecamatan,
      required this.kodePos,
      required this.detailAlamat,
      required this.userId,
      required this.createdAt});
  factory Alamat.fromJson(Map<String, dynamic> json) => Alamat(
        provinsi: json['provinsi'] as String,
        kota: json['kota'] as String,
        kecamatan: json['kecamatan'] as String,
        kodePos: json['kodePos'] as String,
        detailAlamat: json['detailAlamat'] as String,
        userId: json['userId'] as String,
        createdAt: json['createdAt'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'provinsi': provinsi,
        'kota': kota,
        'kecamatan': kecamatan,
        'kodePos': kodePos,
        'detailAlamat': detailAlamat,
        'userId': userId,
        'createdAt': createdAt
      };
}

import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  const StatusModel({
    required super.type,
    required super.titleAr,
    required super.titleEn,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      type: json["status"]["type"],
      titleAr: json["status"]["title"]["ar"],
      titleEn: json["status"]["title"]["en"],
    );
  }
}

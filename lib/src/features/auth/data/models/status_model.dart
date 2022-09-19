import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required final String type,
    required final String titleAr,
    required final String titleEn,
  }) : super(type: type, titleAr: titleAr, titleEn: titleEn);

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      type: json["status"]["type"],
      titleAr: json["status"]["type"]["ar"],
      titleEn: json["status"]["type"]["en"],
    );
  }
}

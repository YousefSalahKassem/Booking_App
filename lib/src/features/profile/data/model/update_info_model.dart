import 'package:bookingapp/src/features/profile/domain/entity/update_info_entity.dart';

class UpdateInfoModel extends UpdateInfoEntity{
  UpdateInfoModel({
    required super.name,
    required super.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
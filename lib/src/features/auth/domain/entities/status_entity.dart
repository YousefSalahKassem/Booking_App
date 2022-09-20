import 'package:equatable/equatable.dart';

class StatusEntity extends Equatable {
  final String type;
  final String titleAr;
  final String titleEn;

  const StatusEntity({
    required this.type,
    required this.titleAr,
    required this.titleEn,
  });

  @override
  List<Object?> get props => [type, titleAr, titleEn];
}

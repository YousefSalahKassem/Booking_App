import 'dart:io';

class UpdateInfoEntity {
  final String name;
  final String email;
  final File? image;

  UpdateInfoEntity({
    required this.name,
    required this.email,
    this.image,
  });
}

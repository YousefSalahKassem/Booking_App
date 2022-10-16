import 'dart:async';
import 'dart:io';

import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_cubit.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserScreen extends StatefulWidget {
  final BookingUser updateInfoEntity;

  const EditUserScreen({Key? key, required this.updateInfoEntity}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  SharedPreferences prefs = di.sl<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          BlocBuilder<UpdateUserCubit, UpdateUserState>(
                            builder: (context, state) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: prefs.getString(AppStrings.cachedProfileImage) == null
                                    ? _image == null
                                        ? CachedNetworkImage(
                                            width: context.height30 * 4,
                                            imageUrl: state is UpdateUserSuccess
                                                ? state.user.image!
                                                : "https://www.baytekent.com/wp-content/uploads/2016/12/facebook-default-no-profile-pic1.jpg",
                                            placeholder: (context, url) =>
                                                Image.asset(ImageAssets.noPic),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(ImageAssets.noPic),
                                          )
                                        : Image.file(
                                            File(_image!.path),
                                            width: context.height30 * 4,
                                          )
                                    : Image.file(
                                        File(prefs.getString(AppStrings.cachedProfileImage)!),
                                        width: context.height30 * 4,
                                      ),
                              );
                            },
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  debugPrint('============================select image tapped');
                                  return getImageFromGallery();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  radius: 20,
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                buildTextField("Full Name", "John Wick", nameController),
                buildTextField("Full Email", "********", emailController),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
            )));
  }

  Widget buildTextField(String labelText, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          labelText: labelText,
          hintText: placeholder,
        ),
      ),
    );
  }

  Future<void> getImageFromGallery() async {
    debugPrint('============================get image from gallery called');
    try {
      _image = (await _picker.pickImage(source: ImageSource.gallery));
      if (_image == null) return;
      final imageTemporary = XFile(_image!.path);
      prefs.setString(AppStrings.cachedProfileImage, _image!.path);
      setState(() {
        _image = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}

import 'dart:io';

import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_cubit.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_state.dart';
import 'package:bookingapp/src/features/profile/presentation/pages/edit_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookingapp/injection_container.dart' as di;
import 'edit-password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences prefs = di.sl<SharedPreferences>();

  _logOut() {
    prefs.remove(AppStrings.cachedUserData);
    prefs.remove(AppStrings.cachedApiToken);
    prefs.remove(AppStrings.cachedLoginStatus);
    Navigator.pushReplacementNamed(context, Routes.getStartedRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            BlocBuilder<UpdateUserCubit, UpdateUserState>(builder: (context, state) {
              if (state is UpdateUserSuccess) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditUserScreen(updateInfoEntity: state.updateInfoEntity)));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.updateInfoEntity.name!,
                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              "View and Edit profile",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: prefs.getString(AppStrings.cachedProfileImage) == null
                                  ? CachedNetworkImage(
                                      width: context.height30 * 3,
                                      imageUrl: state.updateInfoEntity.image!,
                                      placeholder: (context, url) => Image.asset(ImageAssets.noPic),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(ImageAssets.noPic),
                                    )
                                  : Image.file(
                                      File(prefs.getString(AppStrings.cachedProfileImage)!),
                                      width: context.height30 * 3,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            const SizedBox(
              height: 20,
            ),
            _buildAccountOptionRow(
              title: "Change password",
              icon: Icons.lock,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const EditPasswordPage(),
                  ),
                );
              },
            ),
            const Divider(height: 15, thickness: 0.7),
            _buildAccountOptionRow(title: "Invite Friend", icon: Icons.person_add_alt),
            const Divider(height: 15, thickness: 0.7),
            _buildAccountOptionRow(title: "Credit & Coupons", icon: Icons.card_giftcard),
            const Divider(height: 15, thickness: 0.7),
            _buildAccountOptionRow(title: "help Center", icon: Icons.info),
            const Divider(height: 15, thickness: 0.7),
            _buildAccountOptionRow(title: "Payment", icon: Icons.payment),
            const Divider(height: 15, thickness: 0.7),
            _buildAccountOptionRow(title: "Setting", icon: Icons.settings),
            const Divider(height: 15, thickness: 0.7),
            _buildAccountOptionRow(title: "Logout", icon: Icons.logout, onTap: () => _logOut()),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector _buildAccountOptionRow(
      {required String title, required IconData icon, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              icon,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bookingapp/src/core/utils/media_query_values.dart';

import 'edit-password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Amanda",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      Text(
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
                        child: Image.network("https://toppng.com/uploads/preview/cool-avatar-transparent-image-cool-boy-avatar-11562893383qsirclznyw.png",width: context.height30*3,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            buildAccountOptionRow(
              context,
              "Change password",
              Icons.lock,
              const EditPasswordPage(),
            ),
            const Divider(
              height: 15,
              thickness: .7,
            ),
            buildAccountOptionRow(
              context,
              "Invite Friend",
              Icons.person_add_alt,
              const EditPasswordPage(),
            ),
            const Divider(
              height: 15,
              thickness: .7,
            ),
            buildAccountOptionRow(
              context,
              "Credit & Coupons",
              Icons.card_giftcard,
              const EditPasswordPage(),
            ),
            const Divider(
              height: 15,
              thickness: .7,
            ),
            buildAccountOptionRow(
              context,
              "help Center",
              Icons.info,
              const EditPasswordPage(),
            ),
            const Divider(
              height: 15,
              thickness: .7,
            ),
            buildAccountOptionRow(
              context,
              "Payment",
              Icons.payment,
              const EditPasswordPage(),
            ),
            const Divider(
              height: 15,
              thickness: .7,
            ),
            buildAccountOptionRow(
              context,
              "Setting",
              Icons.settings,
              const EditPasswordPage(),
            ),
            const Divider(
              height: 15,
              thickness: .7,
            ),
            buildAccountOptionRow(
              context,
              "Logout",
              Icons.logout,
              const EditPasswordPage(),
            ),
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
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
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

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, IconData icon, Widget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => widget,
          ),
        );
      },
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
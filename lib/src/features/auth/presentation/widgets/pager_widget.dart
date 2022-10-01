import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/hint_text.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/title_text.dart';
import 'package:flutter/material.dart';

class PagePopup extends StatelessWidget {
  final PageData data;

  const PagePopup({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: context.width - 100,
            child: AspectRatio(aspectRatio: 1, child: Image.asset(data.image, fit: BoxFit.cover)),
          ),
        ),
        TitleText(text: data.title),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: HintText(text: data.subtitle),
        ),
      ],
    );
  }
}

class PageData {
  final String title;
  final String subtitle;
  final String image;

  PageData({required this.title, required this.subtitle, required this.image});
}

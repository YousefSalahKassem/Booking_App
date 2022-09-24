import 'package:flutter/material.dart';

import '../../config/themes/app_themes.dart';
import '../utils/text_styles.dart';

class CommonSearchBar extends StatelessWidget {
  final String? text;
  final TextEditingController? textEditingController;
  final bool enabled, ishsow;
  final double height;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  const CommonSearchBar(
      {Key? key,
      this.text,
      this.enabled = false,
      this.height = 48,
      this.iconData,
      this.ishsow = true,
      this.onChanged,
      this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        height: height,
        child: Center(
          child: Row(
            children: <Widget>[
              ishsow == true
                  ? Icon(
                      iconData,
                      // FontAwesomeIcons.search,
                      size: 18,
                    )
                  : const SizedBox(),
              ishsow == true
                  ? const SizedBox(
                      width: 8,
                    )
                  : const SizedBox(),
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  maxLines: 1,
                  enabled: enabled,
                  onChanged: onChanged,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration:  InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      errorText: null,
                      border: InputBorder.none,
                      hintText: text,
                      hintStyle: TextStyles(context)
                          .getDescriptionStyle()
                          .copyWith(
                              color: AppTheme.secondaryTextColor(ThemeMode.system==ThemeMode.light),
                              fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

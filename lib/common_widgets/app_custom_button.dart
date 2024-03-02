import 'package:flutter/material.dart';
import 'package:paypie/constants/degine_constants.dart';

class AppCustomButton extends StatefulWidget {
  AppCustomButton(
      {required this.loading,
      required this.onTap,
      required this.text,
      super.key});
  final String text;
  final VoidCallback onTap;
  bool loading;
  @override
  State<AppCustomButton> createState() => _AppCustomButtonState();
}

class _AppCustomButtonState extends State<AppCustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BORDER_RADIUS_SMALL,
      child: Container(
        padding: EdgeInsets.all(widget.loading ? LARGE_SPACE : MEDIUM_SPACE),
        decoration: BoxDecoration(
          borderRadius: BORDER_RADIUS_SMALL,
          color: Theme.of(context).primaryColor,
        ),
        child: Align(
          child: widget.loading
              ? SizedBox(
                  height: VERY_LARGE_FONT_SIZE,
                  width: VERY_LARGE_FONT_SIZE,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: LARGE_FONT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

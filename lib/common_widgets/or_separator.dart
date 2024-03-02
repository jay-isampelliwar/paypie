import 'package:flutter/material.dart';

import '../constants/degine_constants.dart';

class OrSeparator extends StatelessWidget {
  const OrSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: LARGE_SPACE),
          child: Text("Or"),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

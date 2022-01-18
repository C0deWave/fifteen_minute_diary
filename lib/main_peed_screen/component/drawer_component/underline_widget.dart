import 'package:flutter/material.dart';

class UnderlineWidget extends StatelessWidget {
  const UnderlineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 1,
        color: Colors.grey.shade400,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.clickFunction,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Function() clickFunction;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.white)),
          child: MaterialButton(
            onPressed: clickFunction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                icon,
                Expanded(
                    child: Center(
                        child: Text(
                  text,
                  style: const TextStyle(fontSize: 20),
                ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

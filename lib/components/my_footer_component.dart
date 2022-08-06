import 'package:flutter/material.dart';

class MyFooterComponent extends StatelessWidget {
  const MyFooterComponent({
    Key ?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\u00a9 Copyright ${DateTime.now().year} - BGM , tous droits réservés',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

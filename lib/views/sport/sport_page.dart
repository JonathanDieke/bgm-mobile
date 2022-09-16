import 'package:flutter/material.dart';

import 'components/sport_form.dart';

class SportPage extends StatefulWidget {
  SportPage({Key? key}) : super(key: key);

  @override
  State<SportPage> createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  @override
  Widget build(BuildContext context) {
    return SportFormComponent();
  }
}

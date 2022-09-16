import 'package:flutter/material.dart';

import 'components/insulin_form.dart';

class InsulinPage extends StatefulWidget {
  InsulinPage({Key? key}) : super(key: key);

  @override
  State<InsulinPage> createState() => _InsulinPageState();
}

class _InsulinPageState extends State<InsulinPage> {
  @override
  Widget build(BuildContext context) {
    return const InsulinFormComponent();
  }
}

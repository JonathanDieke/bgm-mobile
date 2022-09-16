import 'package:flutter/material.dart';

import 'components/sleep_form.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key}) : super(key: key);

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    return SleepForm();
  }
}

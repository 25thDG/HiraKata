import 'package:flutter/material.dart';

import '../widgets/counter_view.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CounterView(title: title);
  }
}

import 'package:flutter/material.dart';
class VendorRegistrationScreen extends StatelessWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink,
          )
        ],

      ),
    );
  }
}

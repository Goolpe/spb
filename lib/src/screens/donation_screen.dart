import 'package:flutter/material.dart';

import 'package:shelters/index.dart';

class DonationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SheltersScaffold(
      appBar: SheltersAppBar(
        leadingIcon: SheltersIcon.menu,
        title: 'Donation'
      ),
      bodyList: [
      ],
    );
  }
}

import 'package:ecommerce_app/features/account/services/account_services.dart';
import 'package:ecommerce_app/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            // children: [
            //   // AccountButton(
            //   //   text: 'Orders',
            //   //   onTap: () {},
            //   // ),
            //   // AccountButton(
            //   //   text: 'WishList',
            //   //   onTap: () {},
            //   // ),
            // ],
            ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: 'Sign Out',
              onTap: () => AccountServices().logOut(context),
            ),
          ],
        )
      ],
    );
  }
}

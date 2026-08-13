import 'package:flutter/material.dart';

import 'widgets/logout_button.dart';
import 'widgets/profile_action_tile.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_info_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: ListView(
          children: const [
            ProfileHeader(),

            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProfileInfoCard(),
            ),

            SizedBox(height: 18),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProfileActionTile(
                icon: Icons.edit_outlined,
                title: "Modifier mes informations",
              ),
            ),

            SizedBox(height: 14),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProfileActionTile(
                icon: Icons.settings_outlined,
                title: "Paramètres",
              ),
            ),

            SizedBox(height: 24),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LogoutButton(),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

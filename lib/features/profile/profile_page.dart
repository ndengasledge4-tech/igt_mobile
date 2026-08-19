import 'package:flutter/material.dart';

import '../../app/routes/route_names.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_action_tile.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_info_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const ProfileHeader(),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProfileInfoCard(),
            ),

            const SizedBox(height: 18),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProfileActionTile(
                icon: Icons.edit_outlined,
                title: "Modifier mes informations",
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProfileActionTile(
                icon: Icons.settings_outlined,
                title: 'Paramètres',
                onTap: () => Navigator.pushNamed(context, RouteNames.settings),
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LogoutButton(),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

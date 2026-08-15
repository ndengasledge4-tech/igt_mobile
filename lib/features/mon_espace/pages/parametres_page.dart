import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../widgets/logout_bottom_sheet.dart';

class ParametresPage extends StatelessWidget {
  const ParametresPage({super.key});

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const LogoutBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Paramètres',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('COMPTE'),

            _buildGroupedCard([
              _buildSettingItem(
                context,
                'Modifier mes informations',
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.profil);
                },
              ),
              _buildSettingItem(
                context,
                'Modifier mon mot de passe',
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.modifierMotDePasse);
                },
              ),
            ]),

            const SizedBox(height: 24),

            _buildSectionHeader('NOTIFICATIONS'),

            _buildGroupedCard([
              _buildSettingItem(context, 'Préférences de notifications'),
            ]),

            const SizedBox(height: 24),

            _buildSectionHeader('SÉCURITÉ'),

            _buildGroupedCard([
              _buildSettingItem(context, 'Sécurité du compte'),
              _buildSettingItem(context, 'Sessions actives'),
            ]),

            const SizedBox(height: 24),

            _buildSectionHeader('APPLICATION'),

            _buildGroupedCard([
              _buildSettingItem(context, 'Version 1.0.0', showChevron: false),
              _buildSettingItem(context, 'Informations légales'),
            ]),

            const SizedBox(height: 24),

            _buildSectionHeader('SESSION'),

            _buildGroupedCard([
              _buildSettingItem(
                context,
                'Déconnexion',
                textColor: AppColors.error,
                chevronColor: AppColors.error,
                onTap: () {
                  _showLogoutBottomSheet(context);
                },
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildGroupedCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          if (index == items.length - 1) {
            return items[index];
          }

          return Column(
            children: [
              items[index],
              const Divider(
                height: 1,
                color: AppColors.divider,
                indent: 16,
                endIndent: 16,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title, {
    VoidCallback? onTap,
    Color? textColor,
    bool showChevron = true,
    Color? chevronColor,
  }) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor ?? AppColors.text,
        ),
      ),
      trailing: showChevron
          ? Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: chevronColor ?? AppColors.hint,
            )
          : null,
    );
  }
}

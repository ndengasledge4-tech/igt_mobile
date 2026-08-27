import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';

class MonEspacePage extends StatelessWidget {
  const MonEspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: AppScreenHeader(
              eyebrow: 'Compte étudiant',
              title: 'Profil',
              subtitle: 'Vos informations et préférences',
              icon: Icons.person_rounded,
            ),
          ),
          SliverToBoxAdapter(
            child: AppResponsiveContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ProfileHero(),
                  const SizedBox(height: 28),
                  const AppSectionHeading(
                    title: 'Mon compte',
                    subtitle: 'Informations administratives et activité',
                  ),
                  const SizedBox(height: 14),
                  _MenuGroup(
                    items: [
                      _ProfileAction(
                        Icons.badge_rounded,
                        'Informations personnelles',
                        'Coordonnées et identité',
                        AppColors.primaryLight,
                        () => Navigator.pushNamed(context, RouteNames.profil),
                      ),
                      _ProfileAction(
                        Icons.account_balance_wallet_rounded,
                        'Situation financière',
                        'Frais et paiements',
                        AppColors.secondary,
                        () => Navigator.pushNamed(
                          context,
                          RouteNames.situationFinanciere,
                        ),
                      ),
                      _ProfileAction(
                        Icons.history_rounded,
                        'Activité récente',
                        'Connexions et opérations',
                        const Color(0xFF7A668D),
                        () => Navigator.pushNamed(
                          context,
                          RouteNames.activiteRecente,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const AppSectionHeading(
                    title: 'Préférences',
                    subtitle: 'Personnalisez votre expérience',
                  ),
                  const SizedBox(height: 14),
                  _MenuGroup(
                    items: [
                      _ProfileAction(
                        Icons.tune_rounded,
                        'Paramètres',
                        'Thème, compte et accessibilité',
                        AppColors.accent,
                        () =>
                            Navigator.pushNamed(context, RouteNames.parametres),
                      ),
                      _ProfileAction(
                        Icons.lock_rounded,
                        'Sécurité du compte',
                        'Mot de passe et sessions',
                        const Color(0xFF9A645D),
                        () => Navigator.pushNamed(
                          context,
                          RouteNames.securiteCompte,
                        ),
                      ),
                      _ProfileAction(
                        Icons.help_rounded,
                        'Aide et assistance',
                        'Guides et contact IGT',
                        const Color(0xFF547C68),
                        () => Navigator.pushNamed(context, RouteNames.aide),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => _showLogoutSheet(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Se déconnecter'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      foregroundColor: themeError(context),
                      side: BorderSide(
                        color: themeError(context).withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Se déconnecter ?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Vous pourrez vous reconnecter à tout moment avec votre identifiant étudiant.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.connexion,
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text('Confirmer la déconnexion'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(sheetContext),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Annuler'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryStrong, Color(0xFF174D70)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryStrong.withValues(alpha: 0.2),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: const Text(
              'AM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aymen Mensah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '2024IG001 · Licence 3',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 11),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    'Étudiant actif',
                    style: TextStyle(
                      color: Color(0xFFB9E0DB),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuGroup extends StatelessWidget {
  final List<_ProfileAction> items;

  const _MenuGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _ProfileTile(action: items[i]),
            if (i != items.length - 1)
              Divider(
                height: 1,
                indent: 70,
                endIndent: 16,
                color: context.semanticColors.border,
              ),
          ],
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final _ProfileAction action;

  const _ProfileTile({required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: action.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: isDark ? 0.18 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(action.icon, color: action.color, size: 21),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(action.title, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    action.subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: context.semanticColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAction {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ProfileAction(
    this.icon,
    this.title,
    this.subtitle,
    this.color,
    this.onTap,
  );
}

Color themeError(BuildContext context) => Theme.of(context).colorScheme.error;

import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _isEditing = false;

  // Controllers for editing mode
  final TextEditingController _nomController = TextEditingController(
    text: "DUPONT",
  );
  final TextEditingController _prenomController = TextEditingController(
    text: "Jean",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "jean.dupont@igt.edu",
  );
  final TextEditingController _telController = TextEditingController(
    text: "+225 07 12 34 56",
  );

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader.secondary(
        title: 'Mon profil',
        subtitle: _isEditing ? 'Modification en cours' : 'Identité étudiante',
        actions: [
          IconButton(
            tooltip: _isEditing ? 'Annuler' : 'Modifier',
            onPressed: () => setState(() => _isEditing = !_isEditing),
            icon: Icon(_isEditing ? Icons.close : Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. EN-TÊTE DU PROFIL
            AppResponsiveContent(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "JD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Jean DUPONT",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "2024IG001",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: context.semanticColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AppResponsiveContent(
              child: Column(
                children: [
                  // 3. SECTION « INFORMATIONS PERSONNELLES »
                  _buildPersonalCard(),
                  const SizedBox(height: 16),
                  // 5. SECTION « INFORMATIONS ACADÉMIQUES »
                  _buildAcademicCard(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informations personnelles",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          if (!_isEditing) ...[
            _buildInfoRow("Nom", "DUPONT"),
            _buildDivider(),
            _buildInfoRow("Prénom", "Jean"),
            _buildDivider(),
            _buildInfoRow("Email", "jean.dupont@igt.edu"),
            _buildDivider(),
            _buildInfoRow("Téléphone", "+225 07 12 34 56", isLast: true),
          ] else ...[
            _buildEditField("Nom", _nomController, Icons.person_outline),
            const SizedBox(height: 16),
            _buildEditField("Prénom", _prenomController, Icons.person_outline),
            const SizedBox(height: 16),
            _buildEditField("Email", _emailController, Icons.email_outlined),
            const SizedBox(height: 16),
            _buildEditField(
              "Téléphone",
              _telController,
              Icons.phone_android_outlined,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: "Enregistrer",
              onPressed: () {
                setState(() {
                  _isEditing = false;
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAcademicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informations académiques",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          _buildInfoRow("Matricule", "2024IG001"),
          _buildDivider(),
          _buildInfoRow("Formation", "Informatique de Gestion"),
          _buildDivider(),
          _buildInfoRow("Niveau", "2ème année"),
          _buildDivider(),
          _buildInfoRow("Classe", "IG2"),
          _buildDivider(),
          _buildInfoRow("Campus", "Principal"),
          _buildDivider(),
          _buildInfoRow("Année", "2025–2026", isLast: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.semanticColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: context.semanticColors.border, height: 1),
    );
  }

  Widget _buildEditField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

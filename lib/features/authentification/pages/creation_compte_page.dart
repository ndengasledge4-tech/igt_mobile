import 'package:flutter/material.dart';

import '../../../app/routes/route_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class CreationComptePage extends StatefulWidget {
  const CreationComptePage({super.key});

  @override
  State<CreationComptePage> createState() =>
      _CreationComptePageState();
}

class _CreationComptePageState extends State<CreationComptePage> {
  final _formKey = GlobalKey<FormState>();

  final _matriculeController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();

  String? _campus;
  String? _formation;
  String? _niveau;
  String? _classe;

  @override
  void dispose() {
    _matriculeController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();

    super.dispose();
  }

  void _continuer() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Navigation d'interface uniquement.
    Navigator.pushNamed(
      context,
      RouteNames.reinitialisation,
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.title.copyWith(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: _inputDecoration(
        hint: hint,
        icon: icon,
      ),
      items: items.map(
            (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        },
      ).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner une option';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: const Text(
          'Créer un compte',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              10,
              24,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Créer votre compte étudiant',
                  style: AppTextStyles.headline2,
                ),

                const SizedBox(height: 8),

                Text(
                  'Complétez les informations ci-dessous pour créer votre compte étudiant IGT.',
                  style: AppTextStyles.bodySmall.copyWith(
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 22),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.softBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Renseignez les informations correspondant à votre dossier étudiant.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.45,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                _fieldLabel('Matricule'),

                TextFormField(
                  controller: _matriculeController,
                  decoration: _inputDecoration(
                    hint: 'Votre matricule étudiant',
                    icon: Icons.badge_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre matricule';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Nom'),

                TextFormField(
                  controller: _nomController,
                  decoration: _inputDecoration(
                    hint: 'Votre nom',
                    icon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre nom';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Prénom'),

                TextFormField(
                  controller: _prenomController,
                  decoration: _inputDecoration(
                    hint: 'Votre prénom',
                    icon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre prénom';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Adresse e-mail'),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration(
                    hint: 'Votre adresse e-mail',
                    icon: Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre adresse e-mail';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Téléphone'),

                TextFormField(
                  controller: _telephoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration(
                    hint: 'Votre numéro de téléphone',
                    icon: Icons.phone_outlined,
                  ),
                ),

                const SizedBox(height: 20),

                _fieldLabel('Campus'),

                _dropdown(
                  hint: 'Sélectionner le campus',
                  icon: Icons.location_on_outlined,
                  value: _campus,
                  items: const [
                    'Campus principal',
                    'Campus Nord',
                    'Campus Sud',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _campus = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Formation'),

                _dropdown(
                  hint: 'Sélectionner la formation',
                  icon: Icons.school_outlined,
                  value: _formation,
                  items: const [
                    'Informatique',
                    'Gestion',
                    'Réseaux et Télécommunications',
                    'Marketing',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formation = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Niveau'),

                _dropdown(
                  hint: 'Sélectionner le niveau',
                  icon: Icons.layers_outlined,
                  value: _niveau,
                  items: const [
                    '1ère année',
                    '2ème année',
                    '3ème année',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _niveau = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                _fieldLabel('Classe'),

                _dropdown(
                  hint: 'Sélectionner la classe',
                  icon: Icons.groups_outlined,
                  value: _classe,
                  items: const [
                    'Classe A',
                    'Classe B',
                    'Classe C',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _classe = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _continuer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continuer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'J’ai déjà un compte',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
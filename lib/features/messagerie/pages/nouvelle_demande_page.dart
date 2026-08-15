import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class NouvelleDemandePage extends StatefulWidget {
  const NouvelleDemandePage({super.key});

  @override
  State<NouvelleDemandePage> createState() => _NouvelleDemandePageState();
}

class _NouvelleDemandePageState extends State<NouvelleDemandePage> {
  int _step = 0;

  String? _selectedService;
  String? _selectedSubject;

  final _services = const [
    'Secrétariat',
    'Service académique',
    'Administration',
    'Service communication',
    'Support / Admin.',
    'Direction',
  ];

  final _subjects = const [
    'Problème d’inscription',
    'Problème concernant le dossier',
    'Problème concernant les notes',
    'Question générale',
    'Problème de communication',
    'Problème technique',
    'Demande adressée à la direction',
    'Autre demande',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppDimensions.appBarHeight,
        centerTitle: false,
        titleSpacing: AppDimensions.md,
        title: Text(
          'Nouvelle conversation',
          style: AppTextStyles.headline3.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: AppDimensions.md),
          child: SizedBox.square(
            dimension: 32,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppDimensions.iconSmall,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.softBlue,
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.md),
                children: [
                  _StepIndicator(currentStep: _step),
                  const SizedBox(height: AppDimensions.md),
                  _InfoNotice(text: _noticeText),
                  const SizedBox(height: AppDimensions.lg),
                  _buildStepContent(),
                ],
              ),
            ),
            _BottomAction(
              label: _step == 2 ? 'Envoyer' : 'Continuer',
              icon: _step == 2 ? Icons.send_rounded : null,
              onPressed: _handleNext,
            ),
          ],
        ),
      ),
    );
  }

  String get _noticeText {
    switch (_step) {
      case 0:
        return 'Étape 1 sur 3 — Choisissez le service que vous souhaitez contacter.';
      case 1:
        return 'Étape 2 sur 3 — Choisissez le sujet de votre demande.';
      default:
        return 'Étape 3 sur 3 — Rédigez votre message.';
    }
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _SelectionSection(
          title: 'Service destinataire',
          items: _services,
          selectedValue: _selectedService,
          onSelected: (value) {
            setState(() {
              _selectedService = value;
            });
          },
        );

      case 1:
        return _SelectionSection(
          title: 'Sujet de la demande',
          items: _subjects,
          selectedValue: _selectedSubject,
          onSelected: (value) {
            setState(() {
              _selectedSubject = value;
            });
          },
        );

      default:
        return const _MessageForm();
    }
  }

  void _handleNext() {
    if (_step < 2) {
      setState(() {
        _step++;
      });
      return;
    }

    // UI uniquement.
    // Le traitement réel de l'envoi devra être effectué
    // par le contrôleur / ViewModel / Provider de l'application.
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index <= currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.divider,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              if (index < 2) const SizedBox(width: AppDimensions.xs),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoNotice extends StatelessWidget {
  const _InfoNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.sm + 2),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: AppDimensions.iconSmall,
          ),
          const SizedBox(width: AppDimensions.sm),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionSection extends StatelessWidget {
  const _SelectionSection({
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  final String title;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.label.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),
        ...items.map((value) {
          final isSelected = value == selectedValue;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.sm),
            child: _SelectionTile(
              title: value,
              isSelected: isSelected,
              onTap: () => onSelected(value),
            ),
          );
        }),
      ],
    );
  }
}

class _SelectionTile extends StatelessWidget {
  const _SelectionTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.softBlue : AppColors.card,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: AppDimensions.iconSmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageForm extends StatelessWidget {
  const _MessageForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(text: 'Sujet'),
        const SizedBox(height: AppDimensions.xs),
        const TextField(
          maxLines: 1,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: 'Résumé de votre demande'),
        ),
        const SizedBox(height: AppDimensions.md),
        const _FieldLabel(text: 'Message'),
        const SizedBox(height: AppDimensions.xs),
        const TextField(
          minLines: 6,
          maxLines: 8,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: 'Décrivez votre demande en détail...',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: AppDimensions.md),
        const _AttachmentSection(),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.label.copyWith(
        color: AppColors.text,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _AttachmentSection extends StatelessWidget {
  const _AttachmentSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pièce jointe',
            style: AppTextStyles.label.copyWith(
              color: AppColors.text,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.xs),
          Text(
            'Optionnel',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: AppDimensions.sm),
          Material(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            child: InkWell(
              onTap: () {
                // UI uniquement.
                // Le choix du fichier sera géré par la couche métier.
              },
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.md,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.attach_file_rounded,
                      color: AppColors.secondaryText,
                      size: AppDimensions.iconSmall,
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    Text(
                      'Ajouter un fichier',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, size: AppDimensions.iconSmall)
              : const SizedBox.shrink(),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            textStyle: AppTextStyles.button,
          ),
        ),
      ),
    );
  }
}

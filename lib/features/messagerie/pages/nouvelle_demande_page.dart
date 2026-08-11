import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

class NouvelleDemandePage extends StatefulWidget {
  const NouvelleDemandePage({super.key});

  @override
  State<NouvelleDemandePage> createState() => _NouvelleDemandePageState();
}

class _NouvelleDemandePageState extends State<NouvelleDemandePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final List<String> _services = const [
    'Secrétariat',
    'Service académique',
    'Administration',
    'Support technique',
  ];

  String? _selectedService;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
      _isSuccess = false;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _isSuccess = true;
      _messageController.clear();
      _selectedService = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Nouvelle demande'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedService,
              decoration: _fieldDecoration('Service concerné'),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: _services
                  .map(
                    (service) => DropdownMenuItem<String>(
                      value: service,
                      child: Text(service),
                    ),
                  )
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Sélectionnez un service.';
                }
                return null;
              },
              onChanged: _isLoading
                  ? null
                  : (value) {
                      setState(() => _selectedService = value);
                    },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _messageController,
              enabled: !_isLoading,
              minLines: 7,
              maxLines: 9,
              decoration: _fieldDecoration(
                'Votre demande',
              ).copyWith(alignLabelWithHint: true),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Décrivez votre demande.';
                }
                if (value.trim().length < 12) {
                  return 'Votre demande est trop courte.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            if (_errorMessage != null) ...[
              _FeedbackBanner(
                text: _errorMessage!,
                color: AppColors.error,
                icon: Icons.error_outline,
              ),
              const SizedBox(height: 12),
            ],
            if (_isSuccess) ...[
              const _FeedbackBanner(
                text: 'Votre demande a été envoyée avec succès.',
                color: AppColors.success,
                icon: Icons.check_circle_outline,
              ),
              const SizedBox(height: 12),
            ],
            SizedBox(
              height: 48,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _submit,
                icon: _isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(_isLoading ? 'Envoi...' : 'Envoyer'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: AppTextStyles.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({
    required this.text,
    required this.color,
    required this.icon,
  });

  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

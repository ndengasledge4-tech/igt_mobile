import 'package:flutter/material.dart';

class WaitingValidationPage extends StatelessWidget {
  const WaitingValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 35, 24, 30),
                child: Column(
                  children: [
                    _buildIllustration(),

                    const SizedBox(height: 30),

                    const Text(
                      'Compte en attente de validation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF26384D),
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Votre demande de création de compte a bien été '
                      'enregistrée.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8A98A8),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 25),

                    _buildInformationCard(),

                    const SizedBox(height: 25),

                    _buildStatus(),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF4388C5),
                          side: const BorderSide(color: Color(0xFF4388C5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Retour à la connexion',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE6EAF0))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF526477),
            ),
          ),

          const SizedBox(width: 4),

          const Text(
            'Validation du compte',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FB),
        borderRadius: BorderRadius.circular(35),
      ),
      child: const Icon(
        Icons.hourglass_top_rounded,
        color: Color(0xFF4388C5),
        size: 62,
      ),
    );
  }

  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE2E8EF)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Que se passe-t-il maintenant ?',
            style: TextStyle(
              color: Color(0xFF26384D),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 15),

          _InformationRow(
            icon: Icons.fact_check_outlined,
            text: 'Votre dossier est en cours de vérification.',
          ),

          SizedBox(height: 13),

          _InformationRow(
            icon: Icons.verified_user_outlined,
            text: 'L’administration vérifiera vos informations.',
          ),

          SizedBox(height: 13),

          _InformationRow(
            icon: Icons.notifications_none_rounded,
            text: 'Vous serez informé lorsque votre compte sera validé.',
          ),
        ],
      ),
    );
  }

  Widget _buildStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(Icons.access_time_rounded, color: Color(0xFFD99000), size: 25),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              'Statut : en attente de validation',
              style: TextStyle(
                color: Color(0xFF9A6A00),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InformationRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F6FA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 19, color: const Color(0xFF4388C5)),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF69798A),
                fontSize: 14,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../app/routes/route_names.dart';
import '../../../../../app/theme/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.78, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, RouteNames.onboarding);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // =========================================================
          // IMAGE DE FOND
          // =========================================================
          Image.asset(
            'assets/images/salles/igt.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) {
              return Container(color: AppColors.primaryDark);
            },
          ),

          // =========================================================
          // OVERLAY PRINCIPAL
          // =========================================================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryDark.withValues(alpha: 0.48),
                  AppColors.primary.withValues(alpha: 0.72),
                  AppColors.primaryDark.withValues(alpha: 0.94),
                ],
                stops: const [0.0, 0.48, 1.0],
              ),
            ),
          ),

          // =========================================================
          // VOILE CENTRAL
          // =========================================================
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.15),
                radius: 0.85,
                colors: [
                  Colors.white.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // =========================================================
          // ELEMENTS DECORATIFS
          // =========================================================
          Positioned(
            top: -90,
            right: -70,
            child: _buildCircle(size: 220, opacity: 0.08),
          ),

          Positioned(
            bottom: 90,
            left: -100,
            child: _buildCircle(size: 250, opacity: 0.06),
          ),

          // =========================================================
          // CONTENU
          // =========================================================
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // =================================================
                        // LOGO
                        // =================================================
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: _buildLogo(size),
                        ),

                        const SizedBox(height: 28),

                        // =================================================
                        // BADGE
                        // =================================================
                        _buildBadge(),

                        const SizedBox(height: 17),

                        // =================================================
                        // NOM
                        // =================================================
                        const Text(
                          'IGT MOBILE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                            height: 1.05,
                          ),
                        ),

                        const SizedBox(height: 9),

                        // =================================================
                        // SOUS-TITRE
                        // =================================================
                        Text(
                          'Votre espace étudiant,\n'
                          'partout avec vous.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.88),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.45,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // =================================================
                        // LOADER
                        // =================================================
                        _buildLoader(),

                        const SizedBox(height: 12),

                        Text(
                          'Chargement...',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.70),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // =========================================================
          // FOOTER
          // =========================================================
          Positioned(left: 24, right: 24, bottom: 22, child: _buildFooter()),
        ],
      ),
    );
  }

  // ===============================================================
  // LOGO
  // ===============================================================

  Widget _buildLogo(Size size) {
    final logoSize = size.width < 380 ? 125.0 : 142.0;

    return Container(
      width: logoSize + 18,
      height: logoSize + 18,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.28),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 35,
            spreadRadius: 2,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Image.asset(
          'assets/logo/logo.png',
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) {
            return const Icon(
              Icons.school_rounded,
              size: 62,
              color: AppColors.primary,
            );
          },
        ),
      ),
    );
  }

  // ===============================================================
  // BADGE
  // ===============================================================

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'ESPACE ÉTUDIANT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // LOADER
  // ===============================================================

  Widget _buildLoader() {
    return Container(
      width: 54,
      height: 54,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: const CircularProgressIndicator(
        strokeWidth: 2.2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  // ===============================================================
  // CERCLES DECORATIFS
  // ===============================================================

  Widget _buildCircle({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: opacity),
          width: 1,
        ),
      ),
    );
  }

  // ===============================================================
  // FOOTER
  // ===============================================================

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: 42,
          height: 1,
          color: Colors.white.withValues(alpha: 0.28),
        ),
        const SizedBox(height: 11),
        Text(
          'INSTITUT DE GESTION ET DE TECHNOLOGIE',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.68),
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.9,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'IGT • Espace étudiant',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.45),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

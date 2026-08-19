abstract final class RouteNames {
  const RouteNames._();

<<<<<<< HEAD
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const activation = '/activation';
  static const login = '/login';
  static const createPassword = '/create-password';
  static const forgotPassword = '/forgot-password';
=======
  // ============================================================
  // AUTHENTIFICATION
  // ============================================================
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String connexion = '/connexion';
  static const String creationCompte = '/creation-compte';
  static const String motDePasseOublie = '/mot-de-passe-oublie';
  static const String reinitialisation = '/reinitialisation';
  static const String waitingValidation = '/waiting-validation';

  // ============================================================
  // NAVIGATION PRINCIPALE
  // ============================================================

<<<<<<< HEAD
  static const academic = '/academic';
  static const timetable = '/timetable';
  static const results = '/results';
  static const subjectDetails = '/results/subject';
  static const documents = '/documents';
=======
  static const String navigation = '/navigation';
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

  // ============================================================
  // ACCUEIL
  // ============================================================

  static const String accueil = '/accueil';

<<<<<<< HEAD
  static const navigation = '/navigation';
  static const newsDetail = '/news-detail';
=======
  // ============================================================
  // ACADEMIE
  // ============================================================

  static const String academie = '/academie';
  static const String mesCours = '/mes-cours';
  static const String semestre = '/semestre';
  static const String coursDetail = '/cours-detail';
  static const String mesNotes = '/mes-notes';
  static const String noteDetail = '/note-detail';
  static const String mesResultats = '/mes-resultats';
  static const String resultatDetail = '/resultat-detail';
  static const String emploiDuTemps = '/emploi-du-temps';
  static const String emploiDuTempsDetail = '/emploi-du-temps-detail';
  static const String mesDocuments = '/mes-documents';
  static const String documentDetail = '/document-detail';
  static const String monParcours = '/mon-parcours';

  // ============================================================
  // ACTUALITE
  // ============================================================

  static const String actualite = '/actualite';
  static const String actualiteDetail = '/actualite-detail';
  static const String evenements = '/evenements';

  // ============================================================
  // MESSAGERIE
  // ============================================================

  static const String messagerie = '/messagerie';
  static const String conversation = '/conversation';
  static const String nouvelleDemande = '/nouvelle-demande';

  // ============================================================
  // MON ESPACE
  // ============================================================

  static const String monEspace = '/mon-espace';
  static const String profil = '/profil';
  static const String situationFinanciere = '/situation-financiere';
  static const String historiquePaiements = '/historique-paiements';
  static const String parametres = '/parametres';
  static const String modifierMotDePasse = '/modifier-mot-de-passe';
  static const String securiteCompte = '/securite-compte';
  static const String modifierTelephone = '/modifier-telephone';
  static const String modifierEmail = '/modifier-email';
  static const String activiteRecente = '/activite-recente';
  static const String notificationsPreferences = '/notifications-preferences';
  static const String informationsLegales = '/informations-legales';
  static const String sessionsActives = '/sessions-actives';
  static const String aide = '/aide';
  static const String aPropos = '/a-propos';
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
}

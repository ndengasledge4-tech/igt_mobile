abstract final class RouteNames {
  const RouteNames._();

  // Authentication and application shell.
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const connexion = '/connexion';
  static const creationCompte = '/creation-compte';
  static const motDePasseOublie = '/mot-de-passe-oublie';
  static const reinitialisation = '/reinitialisation';
  static const waitingValidation = '/waiting-validation';
  static const navigation = '/navigation';

  // Main prototype modules.
  static const accueil = '/accueil';
  static const academie = '/academie';
  static const mesCours = '/mes-cours';
  static const semestre = '/semestre';
  static const coursDetail = '/cours-detail';
  static const mesNotes = '/mes-notes';
  static const noteDetail = '/note-detail';
  static const mesResultats = '/mes-resultats';
  static const resultatDetail = '/resultat-detail';
  static const emploiDuTemps = '/emploi-du-temps';
  static const emploiDuTempsDetail = '/emploi-du-temps-detail';
  static const mesDocuments = '/mes-documents';
  static const documentDetail = '/document-detail';
  static const monParcours = '/mon-parcours';

  static const actualite = '/actualite';
  static const actualiteDetail = '/actualite-detail';
  static const evenements = '/evenements';

  static const messagerie = '/messagerie';
  static const conversation = '/conversation';
  static const nouvelleDemande = '/nouvelle-demande';
  static const teacherHome = '/enseignant';

  static const monEspace = '/mon-espace';
  static const profil = '/profil';
  static const situationFinanciere = '/situation-financiere';
  static const historiquePaiements = '/historique-paiements';
  static const parametres = '/parametres';
  static const modifierMotDePasse = '/modifier-mot-de-passe';
  static const securiteCompte = '/securite-compte';
  static const modifierTelephone = '/modifier-telephone';
  static const modifierEmail = '/modifier-email';
  static const activiteRecente = '/activite-recente';
  static const notificationsPreferences = '/notifications-preferences';
  static const informationsLegales = '/informations-legales';
  static const sessionsActives = '/sessions-actives';
  static const aide = '/aide';
  static const aPropos = '/a-propos';

  // Legacy aliases retained while the first-generation screens are migrated.
  static const activation = '/activation';
  static const login = '/login';
  static const createPassword = '/create-password';
  static const forgotPassword = '/forgot-password';
  static const dashboard = '/dashboard';
  static const news = '/news';
  static const newsDetail = '/news-detail';
  static const events = '/events';
  static const academic = '/academic';
  static const timetable = '/timetable';
  static const results = '/results';
  static const subjectDetails = '/results/subject';
  static const documents = '/documents';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const settings = '/settings';
}

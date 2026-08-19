# Audit technique complet — IGT Mobile

> **Date de l'audit :** 19 août 2026
>
> **Périmètre :** état du dépôt local `/Users/apple/StudioProjects/igt_mobile`
>
> **Branche :** `main` — 2 commits devant et 16 commits derrière `origin/main`
>
> **Version déclarée :** `1.0.0+1`
>
> **Verdict :** prototype d'interfaces Flutter, non prêt pour la production

## 1. Résumé exécutif

Le projet compile suffisamment pour être analysé par Flutter, possède une structure de dossiers claire et plusieurs interfaces visuelles déjà dessinées. En revanche, il ne constitue pas encore une application métier fonctionnelle : les couches contrôleurs, repositories, services, stockage et utilitaires sont vides ; les modèles ne sont utilisés nulle part ; l'authentification est simulée ; les données visibles sont codées en dur.

État global :

| Domaine | État | Conclusion |
|---|---:|---|
| Interfaces Flutter | Partiel | Plusieurs écrans soignés, mais données statiques et actions inactives |
| Architecture de dossiers | Présente | Intention feature-first, sans implémentation métier |
| Backend / API / Firebase | Absent | Aucun client, configuration ou dépendance |
| Authentification / session | Simulée | Toute saisie ouvre l'application |
| Persistance locale / sécurisée | Absente | Fichiers prévus mais vides |
| Tests Dart/Flutter | Échec | 1 test exécuté, 0 réussi, 1 échoué |
| Analyse statique | Échec du contrôle | 0 erreur de compilation, 1 warning et 21 infos |
| Formatage Dart | Réussi | 197 fichiers contrôlés, 0 changement requis |
| Build Android actuel | Non concluant | Debug interrompu après 222,5 s, aucun APK debug produit |
| Publication Android | Bloquée | Release configurée avec la clé de signature debug |
| Niveau production | Non | Lacunes fonctionnelles, sécurité, tests et livraison |

Le point le plus important est de ne pas confondre « absence d'erreur de compilation dans l'analyseur » avec « application terminée ». L'UI masque aujourd'hui l'absence presque totale de comportement métier.

## 2. Méthode et limites de l'audit

L'audit a inclus :

- inventaire des fichiers, modules, routes, assets et dépendances ;
- lecture des pages, widgets, modèles et configurations natives ;
- recherche des fichiers vides, TODO, callbacks sans effet et données codées en dur ;
- exécution du formatage en mode vérification, de `dart analyze`, `flutter analyze`, `flutter test`, `flutter doctor` et d'un build Android debug ;
- inspection de la CI GitHub Actions et de la configuration de publication Android ;
- contrôle de l'état Git avant et après les validations.

Limites :

- le build Android debug a été interrompu après 222,5 secondes, car Gradle restait silencieux sur `assembleDebug` ; ce résultat est **non concluant**, pas une preuve d'erreur de compilation ;
- les builds iOS, macOS, Web, Linux et Windows n'ont pas été exécutés ;
- aucune API ni aucun environnement distant n'existe dans le dépôt à tester ;
- la couverture ne peut pas servir de référence tant que l'unique test échoue ; aucun seuil de couverture n'est configuré ;
- l'audit porte sur le checkout local, qui diverge fortement de `origin/main`.

## 3. État du dépôt et métriques

### 3.1 Git

```text
## main...origin/main [ahead 2, behind 16]
```

- Le checkout local possède 2 commits absents de `origin/main` et ne possède pas 16 commits distants.
- Aucun fichier suivi ou non suivi n'était modifié avant la rédaction de ce rapport.
- L'audit n'a modifié aucune source applicative.
- Il faut réconcilier la branche avant toute conclusion de livraison sur la version distante ; ce rapport décrit uniquement la version locale auditée.

### 3.2 Taille du code Dart

| Mesure | Valeur |
|---|---:|
| Fichiers Dart dans `lib/` | 196 |
| Lignes dans `lib/` | environ 6 939 |
| Fichiers Dart vides | 53 |
| Fichiers Dart non vides | 143 |
| Fichiers de test Dart | 1 |
| Tests d'intégration | 0 |
| Modèles | 16 |
| Dépendances runtime tierces | 0 |

Les 53 fichiers vides ne sont pas de simples fichiers isolés : ils comprennent l'intégralité des couches prévues pour l'accès aux données et la logique métier.

## 4. Architecture réelle

```text
lib/main.dart
  └── IgtApp / MaterialApp
      ├── thème clair Material 3
      └── RouteGenerator
          └── pages / screens / widgets de présentation

lib/core/models                 16 modèles isolés
lib/core/controllers            vides
lib/core/repositories           vides
lib/core/services               vides
lib/core/database               vides
lib/core/constants et utils     vides
```

### 4.1 Bootstrap

- `lib/main.dart:5-8` appelle `WidgetsFlutterBinding.ensureInitialized()` puis lance immédiatement `IgtApp`.
- Aucun service, environnement, gestionnaire d'erreurs, stockage, session ou Firebase n'est initialisé.
- `lib/app/app.dart:12-20` configure un `MaterialApp`, le thème clair, la route `/` et `RouteGenerator`.
- Il n'y a ni thème sombre, ni localisation, ni observateur de navigation, ni gestion de deep links.
- Le splash attend toujours trois secondes puis ouvre l'onboarding, sans vérifier une session ou une préférence « onboarding déjà vu » (`splash_page.dart:24-32`).

### 4.2 Couche `app`

La couche contient les routes et le thème. Son intention est correcte, mais son usage est incohérent :

- `AppRouter` est défini dans `lib/app/routes/app_router.dart`, mais n'est utilisé nulle part ;
- certaines navigations utilisent des routes nommées, d'autres `MaterialPageRoute`, d'autres reconstruisent tout le shell ;
- la convention `Screen`/`Page` est redondante : la plupart des `Screen` enveloppent une `Page`, tandis que le mot de passe oublié fait l'inverse ;
- `ActivationScreen` et `CreatePasswordScreen` ajoutent un `Scaffold` autour de pages qui possèdent déjà leur propre `Scaffold` ;
- beaucoup de couleurs et dimensions restent codées en dur malgré les fichiers de thème.

### 4.3 Couche `core`

Les 40 fichiers d'infrastructure suivants sont vides :

- **Constantes :** `api_constants.dart`, `app_constants.dart`, `assets.dart` ;
- **Contrôleurs :** auth, document, event, news, notification, profile, result, student, timetable ;
- **Base/persistance :** `local_database.dart`, `shared_preferences_service.dart` ;
- **Repositories :** auth, campus, class, comment, document, event, formation, like, news, notification, participation, profile, result, student, subject, timetable ;
- **Services :** analytics, auth, Firebase, notification, storage ;
- **Utilitaires :** extensions, formatters, helpers, logger, validators.

Ces noms décrivent une architecture envisagée, pas des capacités disponibles.

### 4.4 Couche `shared`

La navigation principale et cinq petits composants réutilisables sont implémentés. Dix abstractions partagées sont vides, notamment :

- `navigation/widgets/app_bottom_navigation.dart` ;
- `app_avatar.dart`, `app_header.dart`, `confirmation_dialog.dart` ;
- `custom_button.dart`, `custom_card.dart`, `custom_loader.dart`, `custom_textfield.dart` ;
- `empty_widget.dart`, `loading_widget.dart`.

### 4.5 Gestion d'état

La gestion d'état se limite à `setState` local pour l'index de navigation, l'onboarding, l'affichage du mot de passe, les filtres visuels et l'emploi du temps. Il n'existe aucun Provider, Riverpod, Bloc/Cubit, ChangeNotifier, injection de dépendances ou état applicatif partagé.

Le `PageController` de l'onboarding créé à `onboarding_page.dart:17` n'est pas libéré dans `dispose()`.

## 5. Modules et état fonctionnel

| Module | Interfaces présentes | État réel | Manques principaux |
|---|---|---|---|
| Splash | Oui | Affichage et délai fixe de 3 s | Session, restauration, routage conditionnel |
| Onboarding | Oui, 3 pages | Navigation locale | Persistance du statut, `dispose` du contrôleur |
| Connexion | Oui | Bypass direct vers l'application | Formulaire, validation, API, erreurs, session |
| Activation | Oui | Succès simulé | Vérification matricule/code, états erreur/chargement |
| Création mot de passe | Oui | Dialogue de succès systématique | Lecture/comparaison, règles réelles, appel backend |
| Mot de passe oublié | Oui | SnackBar de succès systématique | Validation e-mail, API, gestion d'erreur |
| Dashboard | Oui | Identité, résumé et actualités statiques | Données utilisateur et agrégats réels |
| Actualités | Liste + détail | Données fixes, images de démonstration | Repository, pagination, modèle transmis, erreurs réseau |
| Événements | Placeholder | Texte « Page des événements » | Liste, détail, inscription, modèle et route de détail |
| Académique | Oui | Informations statiques | Données étudiant, semestres, filière réelle |
| Résultats | Liste + détail | 4 matières fixes, même détail pour toutes | Données typées, détail paramétré, états d'accès |
| Emploi du temps | Quotidien/hebdo | Planning fixe | Jour réellement filtré, source de données, synchronisation |
| Documents | Liste + filtres visuels | Recherche/ouverture/téléchargement inactifs | API, lecteur, cache, permissions, erreurs |
| Notifications | Liste | 6 Maps statiques | Push, persistance, lecture, navigation cible, état vide |
| Profil | Affichage | Identité fixe | Édition, photo, sauvegarde, paramètres connectés |
| Paramètres | Placeholder | Texte « Page des paramètres » | Toutes les préférences et actions |
| Déconnexion | Dialogue | Navigation seulement | Révocation token/session et nettoyage sécurisé |

### 5.1 Interfaces absentes ou incomplètes

Les lacunes visibles les plus importantes sont :

- `event_detail_page.dart` et `event_detail_screen.dart` entièrement vides ;
- aucune route de détail d'événement ;
- événements et paramètres réduits à des placeholders (`events_page.dart:8-10`, `settings_page.dart:8-10`) ;
- aucun écran d'édition de profil ;
- les cartes « Modifier mes informations » et « Paramètres » n'ont aucun `onTap` (`profile_page.dart:29-45`) ;
- aucun lecteur ou écran de téléchargement de document ;
- aucune interface de commentaires ou de participation ;
- aucun état générique chargement/erreur/hors-ligne réellement utilisé ;
- aucun écran ou comportement de session expirée ;
- aucun état vide actif pour documents, résultats ou notifications.

### 5.2 Actions visibles sans effet

- ouvrir et télécharger un document : `document_card.dart:25-29,104-108` ;
- recherche de documents : `search_document.dart:8-20` ;
- filtre d'actualités : `news_filter.dart:8-40` ;
- filtre de documents : change seulement la couleur sélectionnée, sans filtrer la liste ;
- aimer et participer : `news_action_buttons.dart:16,36` ;
- « Lire la suite » de l'annonce : `announcement_card.dart:94-99` ;
- ouvrir une notification : `notification_tile.dart:29-30` ;
- « Tout marquer lu » : `notification_app_bar.dart:47-50` ;
- édition du profil et paramètres : callbacks absents ;
- déconnexion : aucune session n'est révoquée.

## 6. Navigation et routes

Le générateur déclare 18 destinations : splash, onboarding, activation, connexion, création et récupération de mot de passe, dashboard, actualités, détail actualité, événements, académique, emploi du temps, résultats, documents, notifications, profil, paramètres et shell de navigation.

Le shell principal utilise un `IndexedStack` de cinq onglets : Accueil, Actualités, Académique, Documents et Profil (`navigation_page.dart:28-39`).

Défauts constatés :

- les raccourcis « Résultats » et « Horaire » ouvrent tous deux l'onglet Académique, pas leur écran annoncé (`quick_access_grid.dart:22-47`) ;
- les raccourcis remplacent la route courante par une nouvelle `NavigationPage`, ce qui réinitialise le shell et fragilise le bouton retour ;
- `SubjectDetailsScreen` est ouvert sans matière en argument : toutes les matières affichent le même détail de mathématiques ;
- `NewsDetailScreen` reçoit zéro article : le détail est toujours le même ;
- `RouteGenerator._page()` ne transmet pas les `RouteSettings`, sauf traitement spécial pour la route académique ;
- le logout utilise la chaîne `'/login'` au lieu de `RouteNames.login` ;
- les routes événements et paramètres sont enregistrées, mais aucun parcours UI normal ne les appelle ;
- le splash contourne le routeur nommé en instanciant directement `OnboardingScreen`.

## 7. Modèles et données

Les 16 modèles couvrent :

- utilisateurs : `UserModel`, `StudentModel`, `AdministratorModel` ;
- structure académique : `CampusModel`, `FormationModel`, `ClassModel`, `SubjectModel` ;
- contenu : `NewsModel`, `CommentModel`, `LikeModel`, `EventModel`, `ParticipationModel`, `DocumentModel`, `NotificationModel` ;
- scolarité : `ResultModel`, `TimetableModel`.

Ils sont immuables et possèdent un constructeur `const` et une méthode `toMap`. Cependant :

- aucun modèle n'est importé ou consommé par les écrans ;
- aucun repository ne les utilise, puisque tous les repositories sont vides ;
- il n'existe ni `fromMap`, ni `fromJson`, ni `copyWith`, ni égalité métier ;
- l'identifiant n'est pas un champ du modèle et doit être injecté à `toMap` ;
- les écrans utilisent des Maps dynamiques et des littéraux ;
- aucune date de création/modification n'est gérée, sauf la date métier de `EventModel` ;
- aucune validation d'intégrité des valeurs n'existe.

Exemples de données codées en dur : Aymen Bensalem, filière Génie Informatique, notes, enseignants, documents de juillet 2025, six notifications et tous les créneaux d'emploi du temps.

## 8. Authentification et sécurité

### 8.1 Bloquant fonctionnel

L'authentification est entièrement contournable :

- le bouton de connexion ignore le numéro étudiant et le mot de passe, puis ouvre directement `RouteNames.navigation` (`login_button.dart:15-22`) ;
- l'activation ignore matricule et code (`activate_button.dart:14-17`) ;
- le bouton de création de mot de passe n'utilise aucune valeur saisie (`create_password_button.dart:16-27`) ;
- les exigences du mot de passe apparaissent toujours comme validées ;
- le mot de passe oublié affiche toujours « lien envoyé » sans service ;
- les champs n'ont ni contrôleur, ni `Form`, ni validateurs ;
- auth controller, repository et service sont vides ;
- aucun token, stockage sécurisé, expiration ou contrôle d'autorisation n'existe.

### 8.2 Configuration et secrets

- Aucun secret, token ou clé API en clair n'a été détecté dans les fichiers suivis.
- Aucun `google-services.json`, `GoogleService-Info.plist` ou fichier Firebase n'est présent.
- L'absence de secrets vient ici de l'absence de backend, et non d'une intégration sécurisée terminée.
- La release Android utilise `signingConfigs.getByName("debug")` (`android/app/build.gradle.kts:28-33`) : publication impossible en l'état.

## 9. Assets, réseau et erreurs d'exécution

### 9.1 Assets invalides

Deux erreurs sont avérées :

1. Le fichier réel est `assets/logo/Logo.png`, alors que quatre widgets chargent `assets/logo/logo.png` : splash, login, activation et création de mot de passe. La casse est significative dans l'AssetManifest et sur les systèmes sensibles à la casse.
2. `NewsDetailHeader` charge `assets/images/news_detail.jpg` (`news_detail_header.dart:12-16`), mais ce fichier n'existe pas.

Conséquence : erreurs `Unable to load asset` sur les écrans concernés. L'unique test actuel ne détecte pas explicitement ces assets.

### 9.2 Images réseau

`NewsCard` et `AnnouncementCard` chargent des images depuis `picsum.photos`, sans `loadingBuilder` ni `errorBuilder`.

- Android : la permission `INTERNET` existe uniquement dans les manifests debug/profile, pas dans `android/app/src/main/AndroidManifest.xml` ; les images réseau ne sont donc pas correctement préparées pour la release.
- macOS : l'entitlement release ne déclare pas `com.apple.security.network.client`.
- Le contenu de démonstration dépend d'un tiers externe et n'a aucun fallback.

## 10. Dépendances et intégrations

`pubspec.yaml` ne déclare que :

- `flutter` en runtime ;
- `flutter_test` et `flutter_lints` en développement.

Il manque donc toute dépendance permettant réellement :

- client HTTP/API ou Firebase ;
- authentification et stockage sécurisé ;
- base locale / préférences ;
- gestion d'état et injection de dépendances ;
- sérialisation des modèles ;
- notifications push et analytics ;
- téléchargement et ouverture de fichiers ;
- routage typé ;
- localisation.

Le lockfile est présent. `flutter pub outdated` n'a pas été exécuté ; son intérêt est limité tant qu'aucune dépendance métier n'est déclarée.

## 11. Résultats des validations

### 11.1 Environnement

| Commande | Code | Durée | Résultat |
|---|---:|---:|---|
| `flutter --version` | 0 | 0,716 s | Flutter 3.44.8 stable, Dart 3.12.2, DevTools 2.57.0 |
| `dart --version` | 0 | 1,397 s | Dart 3.12.2 stable, macOS x64 |
| `flutter doctor -v` | 0 | 18,327 s | Android, iOS, macOS et Web opérationnels |

Environnement détecté : Android SDK 36.1, JDK 21, Xcode 26.4, CocoaPods 1.16.2, Chrome disponible. Seul avertissement de `flutter doctor` : les binaires Flutter et Dart ne sont pas présents dans le `PATH`, bien qu'ils soient utilisables via leur chemin absolu.

### 11.2 Formatage

```text
Commande : dart format --output=none --set-exit-if-changed .
Code     : 0
Résultat : Formatted 197 files (0 changed)
Durée    : 0,54 s
```

Le formatage est conforme.

### 11.3 Analyse Dart et Flutter

| Commande | Code | Durée | Diagnostics |
|---|---:|---:|---|
| `dart analyze --format machine` | 2 | 10,346 s | 0 erreur, 1 warning, 21 infos |
| `flutter analyze` | 1 | 7,016 s | mêmes 22 diagnostics |

Le contrôle CI échoue malgré l'absence d'erreur de compilation, car les diagnostics produisent un code non nul.

Répartition :

- **1 warning :** import inutilisé de `route_names.dart` dans `create_password_button.dart:3` ;
- **2 infos :** paramètres nommés avec underscores inutiles dans `category_filter.dart:28` et `notifications_page.dart:78` ;
- **19 infos de dépréciation :** appels à `withOpacity`, à remplacer par `withValues`.

Fichiers concernés par `withOpacity` :

- `academic_info.dart:79` ;
- `semester_summary.dart:17,89` ;
- `login_header.dart:23` ;
- `splash_loader.dart:21` ;
- `splash_logo.dart:51` ;
- `dashboard_header.dart:45,65,83` ;
- `announcement_card.dart:14` ;
- `notification_icon.dart:15` ;
- `profile_info_card.dart:14` ;
- `detail_header.dart:32` ;
- `grade_card.dart:17` ;
- `info_tile.dart:26` ;
- `results_header.dart:32` ;
- `results_summary_card.dart:11` ;
- `subject_card.dart:119` ;
- `lesson_card.dart:29`.

### 11.4 Tests unitaires et widgets

```text
Commande : flutter test --reporter expanded
Code     : 1
Durée    : 5,907 s
Tests    : 1 exécuté, 0 réussi, 1 échoué
```

Échec unique :

- `test/widget_test.dart:7` attend exactement un widget texte `IGT Campus` ;
- `IGT Campus` est le `MaterialApp.title`, pas un widget `Text` rendu ;
- le splash affiche « INSTITUT DE GESTION ET DE TECHNOLOGIE », « Plateforme Étudiante » et « Apprendre • Réussir • Innover » ;
- résultat : `Expected: exactly one matching candidate`, `Actual: _TextWidgetFinder:<Found 0 widgets>`.

Inventaire des tests :

- 1 seul test widget Dart ;
- 0 test unitaire de modèle ;
- 0 test de contrôleur, repository ou service ;
- 0 test de navigation ou formulaire ;
- 0 test d'intégration ;
- 0 golden test ;
- fichiers iOS/macOS `RunnerTests.swift` encore placeholders sans assertion métier ;
- aucune mesure ni seuil de couverture dans la CI.

### 11.5 Build Android

```text
Commande : flutter build apk --debug
Durée    : 222,5 s
Résultat : interrompu sur Gradle assembleDebug, code final 130
Artefact : aucun app-debug.apk généré
Statut   : NON CONCLUANT
```

Un ancien `app-release.apk` et un ancien `app-release.aab`, datés du 13 août 2026, existaient déjà dans `build/`. Ils ne prouvent pas que le checkout actuel se construit. Ils sont en outre issus d'une configuration release signée avec la clé debug.

## 12. CI/CD et plateformes

Le dépôt contient les scaffolds Android, iOS, Web, Linux, macOS et Windows. La CI ne valide que l'analyse, les tests et Android.

Problèmes de `.github/workflows/ci.yaml` :

- `channel` est mal orthographié `chanel` aux lignes 27 et 58 ;
- `flutter-version: 'stable'` n'épingle pas une version reproductible ;
- le pipeline exécute `flutter test`, actuellement rouge ;
- aucun seuil ou rapport de couverture ;
- aucun test d'intégration ;
- aucun build iOS, Web, macOS, Linux ou Windows ;
- APK et AAB sont produits avec la configuration de signature debug actuelle.

Métadonnées encore génériques :

- `README.md` est le README Flutter initial ;
- `pubspec.yaml` décrit « A new Flutter project. » ;
- Web conserve le nom `igt`, les couleurs et la description du template ;
- le label Android est `igt`, iOS affiche `Igt`, alors que l'application utilise `IGT Campus` ;
- aucune stratégie d'environnements dev/staging/prod n'est définie.

## 13. Défauts UI et cohérence

- `ResultsHeader` contient déjà `ResultsSummaryCard`, puis `ResultsPage` réinsère la même carte ; la seconde copie utilise des textes blancs sur fond clair et devient partiellement illisible.
- Le jour sélectionné dans `DaySelector` reste local ; `DailyTimetable` reçoit zéro jour et affiche toujours les mêmes cours.
- Toutes les matières ouvrent le même détail statique.
- Toutes les actualités ouvrent le même détail statique.
- `NotificationEmpty` est implémenté mais impossible à atteindre avec la liste constante toujours remplie.
- Les écrans et widgets n'utilisent pratiquement pas `Semantics`, `Tooltip`, localisation ou tests d'accessibilité.
- Les états chargement, erreur réseau et retry ne sont pas prévus dans les parcours.

## 14. Registre des risques priorisés

| Priorité | Risque | Impact | Preuve principale |
|---|---|---|---|
| P0 | Authentification contournée | Accès sans identité ni autorisation | `login_button.dart:15-22` |
| P0 | Couche métier/infrastructure vide | Application non fonctionnelle | 40 fichiers `core` vides |
| P0 | Publication signée en debug | Livraison Store impossible/non sûre | `build.gradle.kts:28-33` |
| P1 | Assets invalides | Crash/erreur visuelle à l'exécution | `logo.png`, `news_detail.jpg` |
| P1 | Unique test en échec | CI rouge, aucune protection de régression | `widget_test.dart:7` |
| P1 | Actions majeures inactives | Parcours trompeurs et inutilisables | documents, notifications, profil, actualités |
| P1 | Événements/détail/paramètres absents | Modules annoncés non livrés | fichiers vides/placeholders |
| P1 | Réseau release incomplet | Images distantes indisponibles | manifests Android, entitlement macOS |
| P2 | Navigation incohérente | Mauvaise destination, pile réinitialisée | `quick_access_grid.dart` |
| P2 | Données statiques | Aucun usage réel multi-utilisateur | pages dashboard/results/etc. |
| P2 | Détails non paramétrés | Contenu incorrect | résultats et actualités |
| P2 | CI non reproductible | Builds variables et couverture partielle | `stable`, `chanel` |
| P3 | 22 diagnostics statiques | Dette et CI en échec | analyse Dart/Flutter |
| P3 | Documentation générique | Onboarding développeur insuffisant | README/pubspec/Web |

## 15. Plan de remise à niveau recommandé

### Phase 0 — rendre le dépôt fiable

1. Réconcilier `main` avec `origin/main` et refaire cet audit sur la branche de référence.
2. Corriger les deux chemins d'assets et ajouter/tester l'image de détail.
3. Corriger les 22 diagnostics et le test widget.
4. Corriger `channel`, épingler Flutter 3.44.8 ou la version d'équipe et sécuriser la signature release.
5. Obtenir au minimum un build Android debug et release reproductible en CI.

### Phase 1 — flux d'authentification vertical complet

1. Choisir l'API/backend et documenter les environnements.
2. Implémenter modèles de réponse, client, repository, service/session et stockage sécurisé.
3. Transformer les écrans en vrais `Form` avec contrôleurs, validation, chargement et erreurs.
4. Implémenter activation, connexion, renouvellement, déconnexion et mot de passe oublié.
5. Couvrir ce flux par tests unitaires, widget et intégration.

### Phase 2 — données et architecture applicative

1. Définir une gestion d'état cohérente et une injection de dépendances.
2. Connecter les 16 modèles à des repositories et ajouter la désérialisation.
3. Remplacer progressivement les données codées en dur par des états typés.
4. Unifier la convention `Page`/`Screen` et la navigation avec arguments typés.
5. Ajouter gestion globale des erreurs, logs non sensibles, retry et mode hors-ligne si requis.

### Phase 3 — terminer les modules

1. Événements et détail/participation.
2. Documents : recherche, filtre, lecteur, téléchargement, cache.
3. Notifications : push, lecture, navigation cible et état vide.
4. Profil : édition et paramètres.
5. Actualités/commentaires/likes et détails paramétrés.
6. Résultats et emploi du temps alimentés par l'étudiant connecté.

### Phase 4 — qualité et livraison

1. Fixer un seuil de couverture progressif ; viser d'abord les domaines et repositories.
2. Ajouter tests de navigation, formulaires, widgets critiques, intégration et goldens ciblés.
3. Tester Android, iOS et Web au minimum dans la CI.
4. Compléter accessibilité, localisation, responsive et métadonnées Store/Web.
5. Documenter installation, architecture, variables d'environnement, commandes et processus de release.

## 16. Critères minimum avant production

Le projet ne devrait pas être déclaré prêt avant que tous les points suivants soient satisfaits :

- authentification réelle et testée, sans bypass ;
- aucun secret embarqué et stockage de session sécurisé ;
- toutes les actions visibles ont un comportement ou sont retirées ;
- zéro asset manquant ;
- `flutter analyze` et `flutter test` verts ;
- build release reproductible et signé avec une clé de production protégée ;
- dépendances backend, réseau et persistance réellement intégrées ;
- scénarios erreur/chargement/vide/hors-ligne couverts ;
- tests unitaires des règles métier et test d'intégration du parcours principal ;
- CI épinglée et exécutée sur les plateformes réellement supportées ;
- README et documentation d'exploitation complétés.

## 17. Conclusion

Le projet possède une base visuelle exploitable et une organisation de dossiers qui peut servir de point de départ. Son état réel est toutefois celui d'une maquette interactive : la majorité des écrans métier affichent des données statiques, les interfaces critiques sont incomplètes, l'authentification n'existe pas, les services et repositories sont vides, l'unique test échoue et la livraison release n'est pas sécurisée.

La priorité n'est pas d'ajouter davantage d'écrans isolés, mais de terminer un premier flux vertical fiable — authentification, session, API, stockage, états et tests — puis d'étendre cette architecture aux autres modules.

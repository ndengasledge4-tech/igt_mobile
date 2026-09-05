# IGT Mobile

IGT Mobile est le prototype du portail étudiant de l’Institut de Gestion et de Technologie. Cette étape du projet est volontairement **frontend et mock** : les écrans servent à valider l’expérience, le design system et la navigation avant les travaux pratiques consacrés aux données réelles.

## Architecture

- `lib/app/` : démarrage, routes, thèmes clair/sombre et état local du thème ;
- `lib/features/` : écrans regroupés par domaine fonctionnel ;
- `lib/shared/` : composants visuels et navigation réutilisables ;
- `lib/mock/` : fixtures et données de démonstration, sans réseau ni CRUD ;
- `lib/core/models/` : modèles existants destinés aux futures couches métier ;
- `lib/core/controllers/`, `repositories/`, `services/` et `database/` : emplacements pédagogiques laissés volontairement vides.

Les couleurs, espacements, styles typographiques et thèmes se trouvent dans `lib/app/theme/`. Les assets locaux sont centralisés dans `lib/core/constants/assets.dart`.

## Lancer le projet

Prérequis : une installation Flutter compatible avec le SDK déclaré dans `pubspec.yaml`.

```bash
flutter pub get
flutter run
```

## Qualité et tests

```bash
dart format .
flutter analyze
flutter test
```

Le thème peut être basculé entre clair, sombre et système depuis la page **Paramètres**. Ce choix n’est pas persisté : la persistance, l’authentification, Firebase/API, les repositories et les services seront implémentés ultérieurement par les étudiants.

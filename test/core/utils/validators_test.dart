 import 'package:flutter_test/flutter_test.dart';
 import 'package:igt/core/utils/validators.dart';

 void main() {
   group('Validators', () {
     test('refuse un formulaire vide', () {
       expect(
           Validators.requiredText('', fieldName: 'Le nom'),
           isNotNull,
       );
     });

     test('accepte un email valide et refuse un email invalide', () {
       expect(Validators.email('amira@igt.edu'), isNull);
       expect(Validators.email('amira@igt'), isNotNull);
     });

     test('applique la politique de mot de passe', () {
       expect(Validators.password('Court1'), isNotNull);
       expect(Validators.password('Solide2026'), isNull);
     });

     test('compare la confirmation', () {
       expect(
           Validators.passwordConfirmation('Solide2026', 'Solide2026'),
           isNull,
       );
       expect(
           Validators.passwordConfirmation('Autre2026', 'Solide2026'),
           isNotNull,
       );
     });

     test('refuse les caractères dangereux dans un matricule', () {
       expect(Validators.matricule('2026IG001'), isNull);
       expect(Validators.matricule('2026/IG/001'), isNotNull);
     });
   });
 }
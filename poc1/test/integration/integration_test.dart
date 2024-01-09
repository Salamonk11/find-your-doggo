import 'package:flutter_test/flutter_test.dart';
import 'package:poc1/main.dart';
import 'package:poc1/pages/breed_section.dart';
import 'package:poc1/widget/breed_card.dart';
import 'package:poc1/widget/breed_section/breed_section_image.dart';
import 'package:poc1/widget/custom_button.dart';

void main() {
  testWidgets(
    'HomePage to Breed Section Integration Test',
    (WidgetTester tester) async {
      // Costruisci l'app e renderizza il widget HomePage
      await tester.pumpWidget(const DoggoApp());

      // Attendi il completamento del caricamento iniziale
      await tester.pumpAndSettle();

      // Verifica che il widget BreedCard sia presente ora
      expect(find.byType(BreedCard), findsWidgets);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Esegui un tap su uno dei card
      await tester.tap(find.byType(BreedCard).first);

      // Attendi il completamento della transizione della pagina
      await tester.pumpAndSettle();

      // Verifica che il widget BreedSection sia stato caricato dopo il tap
      expect(find.byType(BreedSection), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Esegui un tap su uno dei card
      await tester.tap(find.byType(CustomButton).first);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verifica che il widget BreedSection sia stato caricato dopo il tap
      expect(find.byType(BreedSectionImg), findsWidgets);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:poc1/pages/home_page.dart';
import 'package:poc1/widget/custom_app_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DoggoApp());
}

class DoggoApp extends StatelessWidget {
  const DoggoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindYourDoggo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const FindYourDoggo(title: 'FindYourDoggo'),
    );
  }
}

class FindYourDoggo extends StatefulWidget {
  const FindYourDoggo({super.key, required this.title});

  final String title;

  @override
  State<FindYourDoggo> createState() => _FindYourDoggoState();
}

class _FindYourDoggoState extends State<FindYourDoggo>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: CustomAppbar(
          title: widget.title,
        ),
        body: const HomePage(),
      ),
    );
  }
}

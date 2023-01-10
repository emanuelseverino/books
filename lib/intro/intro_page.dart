import 'package:books/signup/signup_page.dart';
import 'package:books/singin/singin_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: IntroPage());

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.asset(
                'images/logo.png',
                height: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Experiências\nque trasnformam',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Conheça nossos livros,\nexplore sua imaginação',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const SignUpPage()));
                    },
                    child: const Text('CRIAR CONTA'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const SignInPage()));
                    },
                    child: const Text('ENTRAR'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

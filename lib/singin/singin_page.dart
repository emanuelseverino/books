import 'package:books/firebase/firebase_repository.dart';
import 'package:books/singin/signin_cubit.dart';
import 'package:books/singin/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SigninCubit(
          context.read<FirebaseRepository>(),
        ),
        child: BlocListener<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.status == SigninStatus.error) {}
          },
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                Text(
                  'Bem vindo\nde volta',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Apresente suas credenciasi\npara acessar sua conta',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BlocBuilder<SigninCubit, SigninState>(
                          buildWhen: (previous, current) =>
                              previous.emailAddress != current.emailAddress,
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (emailAddrres) => context
                                  .read<SigninCubit>()
                                  .emailChanged(emailAddrres),
                              decoration: const InputDecoration(
                                hintText: 'e-mail',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu e-mail';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Por favor, digite um e-mail válido';
                                }
                                return null;
                              },
                            );
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<SigninCubit, SigninState>(
                          buildWhen: (previous, current) =>
                              previous.password != current.password,
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (password) => context
                                  .read<SigninCubit>()
                                  .passwordChanged(password),
                              decoration: const InputDecoration(
                                hintText: 'senha',
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua senha';
                                } else if (value.length < 6) {
                                  return 'Por favor, sua senha precisa ter mais que 6 digitos';
                                }
                                return null;
                              },
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<SigninCubit, SigninState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return state.status == SigninStatus.success
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              // Get.snackbar('Erro', 'Errou animal', backgroundColor: Colors.redAccent, snackPosition: SnackPosition.BOTTOM,);
                              if (_formKey.currentState!.validate()) {
                                context.read<SigninCubit>().signIn();
                              }
                            },
                            child: const Text('ENTRAR'),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

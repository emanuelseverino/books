import 'package:books/signup/signup_cubit.dart';
import 'package:books/signup/singup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebase/firebase_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignupCubit(
          context.read<FirebaseRepository>(),
        ),
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignupStatus.error) {}
          },
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                Text(
                  'Crie\numa conta',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Para poder aproveitar tudo\nque nosso app tem para oferecer',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BlocBuilder<SignupCubit, SignupState>(
                          buildWhen: (previous, current) =>
                              previous.name != current.name,
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (name) =>
                                  context.read<SignupCubit>().nameChanged(name),
                              decoration: const InputDecoration(
                                hintText: 'nome',
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu nome';
                                } else if (value.length < 2) {
                                  return 'Por favor, digite um nome válido';
                                }
                                return null;
                              },
                            );
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                          buildWhen: (previous, current) =>
                              previous.emailAddress != current.emailAddress,
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (email) => context
                                  .read<SignupCubit>()
                                  .emailChanged(email),
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
                      BlocBuilder<SignupCubit, SignupState>(
                          buildWhen: (previous, current) =>
                              previous.password != current.password,
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (password) => context
                                  .read<SignupCubit>()
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
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'confrimar senha',
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirme sua senha';
                          } else if (value.length < 6) {
                            return 'Por favor, sua senha precisa ter mais que 6 digitos';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<SignupCubit, SignupState>(
                  buildWhen: (previous, current) =>
                  previous.status != current.status,
                  builder: (context, state) {
                    return state.status == SignupStatus.success
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        // Get.snackbar('Erro', 'Errou animal', backgroundColor: Colors.redAccent, snackPosition: SnackPosition.BOTTOM,);
                        if (_formKey.currentState!.validate()) {
                          context.read<SignupCubit>().signUp();
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

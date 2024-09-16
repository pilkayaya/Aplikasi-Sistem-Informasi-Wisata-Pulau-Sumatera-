import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_app/bloc/login/login_bloc.dart';
import 'package:wisata_app/cubit/setting_app_cubit.dart';
import 'package:wisata_app/params/auth_param.dart';
import 'package:wisata_app/ui/register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formState = GlobalKey<FormState>();
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  bool _obscurePassword = true;

  void _onLoginButtonPressed(BuildContext context) {
    if (formState.currentState!.validate()) {
      final username = tecUsername.text;
      final password = tecPassword.text;

      if (username.isNotEmpty && password.isNotEmpty) {
        context.read<LoginBloc>().add(LoginPressed(
          authParam: AuthParam(username: username, password: password),
        ));
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Selamat Datang!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F2F00),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Selamat datang kembali! Masuk untuk melanjutkan penjelajahan Anda di Pulau Sumatera. Temukan destinasi baru, baca ulasan wisata, dan rencanakan petualangan Anda dengan mudah.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F2F00),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: tecUsername,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tecPassword,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          resetForm();
                          context.read<SettingAppCubit>().checkSession();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else if (state is LoginError) {
                          resetForm();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login Failed: ${state.message}'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoginFatalError) {
                          return Column(
                            children: [
                              const Icon(Icons.error),
                              const SizedBox(height: 10),
                              Text(state.message),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  resetForm();
                                  context.read<LoginBloc>().add(LoginReset());
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          );
                        }
                        return ElevatedButton(
                          onPressed: state is LoginLoading
                              ? null
                              : () => _onLoginButtonPressed(context),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Belum punya akun? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetForm() {
    tecUsername.text = '';
    tecPassword.text = '';
  }
}
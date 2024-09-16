import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_app/bloc/register/register_bloc.dart';
import 'package:wisata_app/params/register_param.dart';
import 'package:wisata_app/repo/register_repository.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final formState = GlobalKey<FormState>();
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecFirstName = TextEditingController();
  TextEditingController tecLastName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecPassword2 = TextEditingController();

  void _onRegisterButtonPressed(BuildContext context) {
    if (formState.currentState!.validate()) {
      final username = tecUsername.text;
      final firstName = tecFirstName.text;
      final lastName = tecLastName.text;
      final email = tecEmail.text;
      final password = tecPassword.text;
      final password2 = tecPassword2.text;

      if (username.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          password2.isNotEmpty) {
        context.read<RegisterBloc>().add(RegisterPressed(
              registerParam: RegisterParam(
                username: username,
                email: email,
                password: password,
                password2: password2,
                firstName: firstName,
                lastName: lastName,
                isActive: true,
                isPengguna: true,
              ),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(registerRepository: RegisterRepository()),
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
                    'Buat Akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F2F00),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Buat akun baru untuk mulai menjelajah destinasi wisata di Pulau Sumatera',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
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
                        return 'Masukkan username Anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tecFirstName,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Nama Depan',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan nama depan Anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tecLastName,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Nama Belakang',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan nama belakang Anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tecEmail,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan email Anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tecPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan password Anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tecPassword2,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Konfirmasi Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan konfirmasi password Anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else if (state is RegisterError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () => _onRegisterButtonPressed(context),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Register',
                            style: TextStyle(fontSize: 18)),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun? ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
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
}

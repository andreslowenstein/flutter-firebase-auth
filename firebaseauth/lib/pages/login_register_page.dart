import 'package:firebaseauth/pages/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    BlocProvider.of<HomeBloc>(context).add(LoginEvent(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    ));
  }

  Future<void> createUserWithEmailAndPassword() async {
    BlocProvider.of<HomeBloc>(context).add(RegisterEvent(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    ));
  }

  Widget _title() {
    return Text('Firebase Auth');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _entryField('email', _controllerEmail),
                  _entryField('password', _controllerPassword),
                  _submitButton(),
                  _loginOrRegisterButton(),
                ],
              ),
            );
          }
          if (state is LoginLoading || state is RegisterLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginError) {
            return Container(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}

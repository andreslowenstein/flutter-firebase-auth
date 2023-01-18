import 'package:firebaseauth/pages/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    BlocProvider.of<HomeBloc>(context).add(LoginEvent(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    ));
  }

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    BlocProvider.of<HomeBloc>(context).add(RegisterEvent(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    ));
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
                  _submitButton(context),
                  // _loginOrRegisterButton(),
                ],
              ),
            );
          }
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginError) {
            return Container(
              child: Text(state.error),
            );
          }
          if (state is HomeLoaded) {
            return Column(
              children: [
                Text("Logged in!"),
                Column(
                  children: [
                    Image.network(state.meme),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context)
                          .add(GetMemeEvent()),
                      child: Text("Generate meme"),
                    )
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
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

  Widget _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => isLogin
          ? signInWithEmailAndPassword(context)
          : createUserWithEmailAndPassword(context),
      child: Text("asd"),
    );
  }
}

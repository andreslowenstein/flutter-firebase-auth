import 'package:firebaseauth/pages/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      backgroundColor: Color(0xFFb79eee),
      appBar: AppBar(
        title: _title(),
        backgroundColor: Color(0xFF7646e0),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Color(0xFF7646e0),
                      size: 200,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _entryField('Email', _controllerEmail),
                    SizedBox(
                      height: 20,
                    ),
                    _entryField('Password', _controllerPassword),
                    SizedBox(
                      height: 40,
                    ),
                    _submitButton(context, "0", "Login"),
                    _submitButton(context, "1", "Register"),
                  ],
                ),
              ),
            );
          }
          if (state is LoginLoading || state is GetMemeLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF7646e0),
              ),
            );
          }
          if (state is LoginError) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.error,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          BlocProvider.of<HomeBloc>(context).add(LogoutEvent()),
                      child: Text(
                        "Go back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is HomeLoaded) {
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Logged in!",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Image.network(state.meme),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(GetMemeEvent()),
                          child: Text(
                            "Generate meme",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(LogoutEvent()),
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 199, 199, 199), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 199, 199, 199), width: 1.5),
        ),
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context, String option, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: MaterialButton(
          color: Color(0xFF7646e0),
          textColor: Colors.white,
          onPressed: () => option == "0"
              ? signInWithEmailAndPassword(context)
              : createUserWithEmailAndPassword(context),
          child: Text(title),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}

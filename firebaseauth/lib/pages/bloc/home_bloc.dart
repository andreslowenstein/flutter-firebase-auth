import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/services/service.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../auth.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Service _service;

  HomeBloc()
      : this._service = Service(),
        super(HomeInitial()) {
    on<LoginEvent>((event, emit) async {
      await loginEvent(event, emit);
    });
    on<RegisterEvent>((event, emit) async {
      await registerEvent(event, emit);
    });
    on<GetMemeEvent>(((event, emit) async {
      await getMemeEvent(event, emit);
    }));
  }

  Future<void> loginEvent(LoginEvent event, Emitter emit) async {
    try {
      emit(LoginLoading());

      await Auth().signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      String meme = await _service.getMeme();

      emit(HomeLoaded(meme: meme));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message!));
    } catch (e) {
      throw e;
    }
  }

  Future<void> registerEvent(RegisterEvent event, Emitter emit) async {
    try {
      emit(LoginLoading());

      await Auth().createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      String meme = await _service.getMeme();

      emit(HomeLoaded(meme: meme));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message!));
    } catch (e) {
      throw e;
    }
  }

  Future<void> getMemeEvent(GetMemeEvent event, Emitter emit) async {
    try {
      emit(GetMemeLoading());
    } catch (e) {
      throw e;
    }
  }
}

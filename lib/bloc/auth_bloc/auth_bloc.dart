import 'package:cafe_mobile_app/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository}) : super(AuthenticationUninitialized());
  //    : assert(userRepository != null);

  // @override
  // AuthenticationState get initialState => AuthenticationUninitialized(); moved to constructor

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event
      ) async* {
    if(event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      if(hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if(event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persisteToken(event.token);
      yield AuthenticationAuthenticated();
    }
    if(event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }

}
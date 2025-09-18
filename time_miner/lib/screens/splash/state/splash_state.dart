sealed class SplashState {}

class SplashInitialState extends SplashState {}

class SplashFetchedState extends SplashState {
  final bool isLoggedIn;

  SplashFetchedState({required this.isLoggedIn});
}

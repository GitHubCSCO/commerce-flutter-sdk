abstract class InAppBrowserState {}

class InAppBrowserInitialState extends InAppBrowserState {}

class InAppBrowserTokenUpdatedState extends InAppBrowserState {
  final String token;
  InAppBrowserTokenUpdatedState(this.token);
}

class InAppBrowserErrorState extends InAppBrowserState {
  final String message;
  InAppBrowserErrorState(this.message);
}

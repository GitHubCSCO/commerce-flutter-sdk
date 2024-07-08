part of 'load_website_url_bloc.dart';

abstract class LoadWebsiteUrlState {
  const LoadWebsiteUrlState();
}

class LoadWebsiteUrlInitialState extends LoadWebsiteUrlState {}

class LoadWebsiteUrlLoadingState extends LoadWebsiteUrlState {}

class LoadWebsiteUrlLoadedState extends LoadWebsiteUrlState {
  final String authorizedURL;
  const LoadWebsiteUrlLoadedState({required this.authorizedURL});
}

class LoadCustomUrlLoadedState extends LoadWebsiteUrlState {
  final String customURL;
  const LoadCustomUrlLoadedState({required this.customURL});
}

class LoadWebsiteUrlFailureState extends LoadWebsiteUrlState {
  final String error;

  LoadWebsiteUrlFailureState(this.error);
}

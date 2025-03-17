part of 'load_website_url_bloc.dart';

abstract class LoadWebsiteUrlEvent {}

class LoadWebsiteUrlLoadEvent extends LoadWebsiteUrlEvent {
  String redirectUrl;
  bool isloadInAppBrowser;
  LoadWebsiteUrlLoadEvent({
    required this.redirectUrl,
    required this.isloadInAppBrowser,
  });
}

class LoadCustomUrlLoadEvent extends LoadWebsiteUrlEvent {
  String? customUrl;
  LoadCustomUrlLoadEvent({
    required this.customUrl,
  });
}

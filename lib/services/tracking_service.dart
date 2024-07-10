import 'package:commerce_flutter_app/core/extensions/firebase_options_extension.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

//TODO
//Maybe we can find a better solution than this.
//TrackingService is dependent on sessionService and sessionService is dependent on TrackingService
//For now since all of them are singleton, we call _initialize only when 
class TrackingService implements ITrackingService{
  late final ISessionService sessionService;
  late final IAccountService accountService;
  late final FirebaseOptions firebaseOptions;

  void _initialize() async{    
    sessionService = sl<ISessionService>();
    accountService = sl<IAccountService>();
    firebaseOptions = sl<FirebaseOptions>();
    if(firebaseOptions.isValid()){
      analytics = FirebaseAnalytics.instance;
      crashlytics = FirebaseCrashlytics.instance;
    }
  }

  FirebaseAnalytics? analytics;
  FirebaseCrashlytics? crashlytics;
  
  @override
  Future<void> forceCrash() async {
    _initialize();
    crashlytics?.crash();
  }
  
  @override
  Future<void> setUserID(String userId) async {
    _initialize();
    analytics?.setUserId(id: userId);
  }
  
  @override
  Future<void> trackEvent(AnalyticsEvent analyticsEvent) async {
    _initialize();
    var result = await sessionService.getCachedOrCurrentSession();
    var session = result.getResultSuccessValue();
    if(session!=null && session.isAuthenticated == true){
      try {
        var accountResult = await accountService.getCachedOrCurrentAccountAsync();
        var account = accountResult.getResultSuccessValue();

        analyticsEvent.withProperty(name: 'user_id', strValue: account?.id ?? '');

        if(!analyticsEvent.properties.containsKey('bill_to_id')){
          analyticsEvent.withProperty(name: 'bill_to_id', strValue: session.billTo?.id ?? '');
        }

        if(!analyticsEvent.properties.containsKey('ship_to_id')){
          analyticsEvent.withProperty(name: 'ship_to_id', strValue: session.shipTo?.id ?? '');
        }
      } catch (e) {
        await trackError(e);
      }
    }

    analytics?.logEvent(
      name: analyticsEvent.eventName,
      parameters: analyticsEvent.properties
    );
  }
  
  @override
  Future<void> trackError(dynamic e, {StackTrace? trace, Map<String, String>? reason}) async {
    _initialize();
    if(e is ErrorResponse){
      await crashlytics?.recordError(e.exception, trace, reason: e.extractErrorMessage());
    }else{
      await crashlytics?.recordError(e, trace, reason: reason);
    } 
  }

}
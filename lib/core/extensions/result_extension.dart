import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension GetResultSuccessValue<S,E> on Result<S,E>{
  S? getResultSuccessValue(){
    if(this is Success<S,E>){
      return (this as Success<S,E>).value;
    }
    return null;
  }
}
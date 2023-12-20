import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:flutter/material.dart';

void main() {
  ClientConfig.hostUrl = 'mobilespire.commerce.insitesandbox.com';
  ClientConfig.clientId = 'fluttermobile';
  ClientConfig.clientSecret = 'd66d0479-07f7-47b2-ee1e-0d3a536e6091';

  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('My App'),
          ),
          body: Center(
            child: Text('Hello, World!'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await sl<IAuthenticationService>().logInAsync(
                'saif',
                'tester1',
              );
              var service = sl<IMobileSpireContentService>();
              var result = await service.getPageContenManagmentSpire('Shop');
              switch (result) {
                case Success(value: final value):
                  {
                    print(value);
                    break;
                  }
                case Failure(errorResponse: final errorResponse):
                  {
                    print(errorResponse);
                    break;
                  }
              }
            },
            child: Icon(Icons.add),
          )),
    );
  }
}

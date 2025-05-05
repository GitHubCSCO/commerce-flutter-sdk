import 'package:get_it/get_it.dart';

/// A little bag of all the things the wrapper can customize:
typedef ServiceOverrides = Future<void> Function(GetIt sl);

class CommerceConfig {
  final ServiceOverrides? overrideServices;
  final bool? isRunningAsPackage;

  CommerceConfig({
    this.isRunningAsPackage = true,
    this.overrideServices,
  });
}

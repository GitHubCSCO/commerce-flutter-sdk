import 'package:map_launcher/map_launcher.dart';

mixin MapDirection {
  Future<void> launchMap(double latitude, double longitude) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first
        .showDirections(destination: Coords(latitude, longitude));
  }
}

import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'exceptions.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger;
  logger.info(
    green.wrap(
      'Executing postgen script',
    ),
  );
  try {
    final rootPath = Directory.current.path;
    final libPath = path.join(rootPath, 'lib');
    final pubSpecFile = File('$rootPath/pubspec.yaml');
    if (await pubSpecFile.exists()) {
      var config1 = path.join(libPath, 'core/config/custom_configuration.dart');
      var config2 =
          path.join(libPath, 'core/config/custom_configuration.g.dart');
      final customConfigDart1 = File(config1);
      final customConfigDart2 = File(config2);
      if (await customConfigDart1.exists() &&
          await customConfigDart2.exists()) {
        logger.info(
          green.wrap(
            'Executing dart formatter',
          ),
        );
        final buildRunnerProcess = await Process.start(
          'dart',
          ['format', config1, config2],
          runInShell: true,
          workingDirectory: rootPath,
        );
        await stdout.addStream(buildRunnerProcess.stdout);
        await stderr.addStream(buildRunnerProcess.stderr);
      }
    } else {
      throw RootFolderException();
    }
  } on RootFolderException catch (_) {
    logger.alert(
      red.wrap(
        'Executing command from a different folder. Please execute from your project root.',
      ),
    );
  }
}

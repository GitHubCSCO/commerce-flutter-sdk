import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'exceptions.dart';

Future run(HookContext context) async {
  final logger = context.logger;
  logger.info(
    green.wrap(
      'Executing pregen script',
    ),
  );
  try {
    final rootPath = Directory.current.path;
    final libPath = path.join(rootPath, 'lib');
    final customConfig = path.join(libPath, 'core/config/');
    final pubSpecFile = File('$rootPath/pubspec.yaml');
    if (await pubSpecFile.exists()) {
      final brick = Brick.version(name: 'model', version: '0.9.1');
      Map<String, dynamic> variables = <String, dynamic>{
        'model_name': 'CustomConfiguration',
        'style': 'json_serializable',
        'additionals': ['copyWith', 'json', 'equatable', 'toString'],
        'jsonFile': './assets/config/custom_config.json',
        'on-conflict': 'overwrite',
      };
      final customConfigDart1 =
          File(path.join(libPath, 'core/config/custom_configuration.dart'));
      if (await customConfigDart1.exists()) {
        await customConfigDart1.delete();
      }
      final customConfigDart2 =
          File(path.join(libPath, 'core/config/custom_configuration.g.dart'));
      if (await customConfigDart2.exists()) {
        await customConfigDart2.delete();
      }
      final generator = await MasonGenerator.fromBrick(brick);
      final target = DirectoryGeneratorTarget(Directory(customConfig));
      await generator.hooks.preGen(
        vars: variables,
        onVarsChanged: (vars) => variables = vars,
      );
      await generator.generate(target, vars: variables);
      await generator.hooks.postGen(vars: variables);
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

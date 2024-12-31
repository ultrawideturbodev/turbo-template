// ignore_for_file: avoid_slow_async_io
import 'dart:io';

Future<void> main() async {
  stdout.write('Enter the feature name: ');
  final featureName = stdin.readLineSync()!;

  stdout.write("Enter the snake_case file name without '_view' (e.g. profile): ");
  final snakeName = stdin.readLineSync()!;

  final filename = '${snakeName}_view.dart';
  final viewModelFilename = '${snakeName}_view_model.dart';
  final argumentsFilename = '${snakeName}_arguments.dart';
  final originFilename = '${snakeName}_origin.dart';

  final pascalName = snakeToPascal('$snakeName');
  final viewModelPascalName = snakeToPascal('${snakeName}_view_model');
  final kebabName = snakeToKebab(snakeName);

  final featureDir = featureName == 'core'
      ? Directory('../lib/$featureName')
      : Directory('../lib/features/$featureName');

  final viewsDir = Directory('${featureDir.path}/views/$snakeName');
  if (!await viewsDir.exists()) {
    await viewsDir.create(recursive: true);
  }

  final viewFile = File('${viewsDir.path}/$filename');
  final content = '''

import '${snakeName}_view_model.dart';

class ${pascalName}View extends StatelessWidget {
  const ${pascalName}View({
    super.key,
    required this.arguments,
    required this.origin,
  });

  final ${pascalName}Arguments arguments;
  final ${pascalName}Origin origin;

  static const String path = '$kebabName';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<${pascalName}ViewModel>(
      isReactive: false,
      argumentBuilder: () => OriginArguments(data: arguments, origin: origin),
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
          return const TurboScaffold(
            appBar: TurboAppBar(
            context: context,
            header: EmojiHeader(
              emoji: Emoji.unicorn,
              title: '$pascalName',
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        );
      },
      viewModelBuilder: () => ${pascalName}ViewModel.locate,
    );
  }
}
''';
  await viewFile.writeAsString(content);
  await addFileToGit(viewFile.path);

  final viewModelFile = File('${viewsDir.path}/$viewModelFilename');
  final viewModelContent = '''
class $viewModelPascalName extends BaseViewModel<OriginArguments<${pascalName}Origin, ${pascalName}Arguments>> with Loglytics {
  $viewModelPascalName();
  
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\\\

  static $viewModelPascalName get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => $viewModelPascalName());
  
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\\\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\\\

  @override
  Future<void> initialise() async {
    super.initialise();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }
  
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\\\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\\\
  // 🎩 STATE --------------------------------------------------------------------------------- \\\\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\\\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\\\
  
  ${pascalName}Origin get origin => arguments.origin;
  ${pascalName}Arguments get args => arguments.data;
  
  // 🏗 HELPERS ------------------------------------------------------------------------------- \\\\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\\\

}
''';

  await viewModelFile.writeAsString(viewModelContent);
  await addFileToGit(viewModelFile.path);

  final argumentsFile = File('${viewsDir.path}/$argumentsFilename');
  final argumentsContent = '''
class ${pascalName}Arguments extends ViewArguments {
  ${pascalName}Arguments({required this.id});

  final String? id;

  @override
  Map<String, dynamic> toMap() => {
      if (id != null) 'id': id,
    };

  factory ${pascalName}Arguments.fromMap(Map<String, dynamic> map) => ${pascalName}Arguments(
        id: map['id'] as String?,
      );
}
''';

  await argumentsFile.writeAsString(argumentsContent);
  await addFileToGit(argumentsFile.path);

  final originFile = File('${viewsDir.path}/$originFilename');
  final originContent = '''
enum ${pascalName}Origin {
  core,
}
''';

  await originFile.writeAsString(originContent);
  await addFileToGit(originFile.path);
}

String snakeToPascal(String text) {
  return text.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
}

String toCamelCase(String text) {
  return text[0].toLowerCase() + text.substring(1);
}

Future<void> addFileToGit(String filePath) async {
  final result = await Process.run('git', ['add', filePath]);
  if (result.exitCode != 0) {
    stderr.writeln('Error adding file $filePath to Git:');
    stderr.writeln(result.stderr);
  }
}

String snakeToKebab(String text) {
  return text.replaceAll('_', '-');
}

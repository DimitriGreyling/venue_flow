class ProjectSettings {
  static ProjectSettings? _instance;

  ProjectSettings._internal();

  static ProjectSettings get instance {
    _instance ??= ProjectSettings._internal();
    return _instance!;
  }

  bool isDebugMode = false;
}

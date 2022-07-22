import 'package:flutter/services.dart';
import 'package:test_multi_image_picker/domain/utilities/strings.dart';
import "package:yaml/yaml.dart";

class Config {
  static YamlMap? _config;

  Future<void> load() async {
    if (_config == null) {
      final data = await rootBundle.loadString(Strings.cAppConfigFile);
      Config._config = loadYaml(data);
    } else {
      throw ("Config already loaded");
    }
  }

  String get(String key) {
    return Config._config!.value[key];
  }
}

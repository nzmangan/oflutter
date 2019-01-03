import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class SettingService {
  Secret secret;

  Future<Secret> _getSecret() async {
    if (secret == null) {
      secret = await SecretLoader(secretPath: "secrets.json").load();
    }

    return secret;
  }

  Future<String> urlEvents() async {
    return (await _getSecret()).url;
  }

  Future<String> apiMapKey() async {
    return (await _getSecret()).apiMapKey;
  }

  Future<String> sentry() async {
    return (await _getSecret()).sentry;
  }
}

class Secret {
  final String apiMapKey;
  final String url;
  final String sentry;
  Secret({this.apiMapKey = "", this.url = "", this.sentry = ""});
  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      apiMapKey: jsonMap["apiMapKey"],
      url: jsonMap["url"],
      sentry: jsonMap["sentry"],
    );
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath, (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}

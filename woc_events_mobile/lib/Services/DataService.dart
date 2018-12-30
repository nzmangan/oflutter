import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:woc_events_mobile/Lib/DI.dart';

class DataService {
  final Logger log = DI.getLogger('DataService');
  Future<R> get<R>(String url, Function resultMapper) async {
    try {
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw (resp.body);
      }

      return resultMapper(resp.body);
    } catch (ex, stackTrace) {
      log.severe('Failed to deserialize json.', ex, stackTrace);
      return null;
    }
  }

  Future<List<R>> getList<R>(String url, Function resultMapper) async {
    try {
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw (resp.body);
      }

      return resultMapper(resp.body);
    } catch (ex, stackTrace) {
      log.severe('Failed to deserialize json.', ex, stackTrace);
      return null;
    }
  }

  Future<R> post<T, R>(String url, T requestPayload, Function payloadMapper,
      Function resultMapper) async {
    try {
      String payload = json.encode(payloadMapper(requestPayload));

      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (resp.statusCode != 200) {
        throw (resp.body);
      }

      return resultMapper(resp.body);
    } catch (ex, stackTrace) {
      log.severe('Failed to deserialize json.', ex, stackTrace);
      return null;
    }
  }
}

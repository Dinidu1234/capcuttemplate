import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/app_constants.dart';
import '../models/template_item.dart';

class TemplateRemoteSource {
  final http.Client client;

  TemplateRemoteSource({required this.client});

  Future<List<TemplateItem>> fetchTemplates({
    required int offset,
    required int limit,
  }) async {
    final response = await client.post(
      Uri.parse(AppConstants.templatesApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'offset': offset,
        'limit': limit,
        'mode': 'Latest_videos',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('API request failed: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final data = (decoded['data'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(TemplateItem.fromJson)
        .where((item) => item.id.isNotEmpty)
        .toList();

    return data;
  }
}

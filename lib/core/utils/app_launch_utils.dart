import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLaunchUtils {
  static String? cleanTemplateUrl(String? url) {
    final trimmed = url?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed
        .replaceAll('https://www.capcut.com//', 'https://www.capcut.com/')
        .replaceAll('/template-detail//', '/template-detail/');
  }

  static String? extractAfDp(String url) {
    try {
      final uri = Uri.parse(url);
      final afDp = uri.queryParameters['af_dp'];
      return (afDp == null || afDp.isEmpty) ? null : afDp;
    } catch (_) {
      return null;
    }
  }

  static String? extractTemplateIdFromWebUrl(String url) {
    final cleaned = cleanTemplateUrl(url);
    if (cleaned == null) return null;
    try {
      final pathSegments = Uri.parse(cleaned).pathSegments;
      for (final segment in pathSegments) {
        if (RegExp(r'^\d{10,}$').hasMatch(segment)) {
          return segment;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static String buildCapCutDeepLinkFromTemplateId(String templateId) {
    return 'capcut://template/detail?template_id=$templateId&tab_name=template&enter_from=shared_h5link_template';
  }

  static Future<bool> openTemplateSmart(
    String? url,
    BuildContext context,
  ) async {
    final cleaned = cleanTemplateUrl(url);
    if (cleaned == null) {
      if (context.mounted) {
        _showMessage(context, 'Invalid template link.');
      }
      return false;
    }

    Future<bool> tryOpen(String target, {bool external = false}) async {
      try {
        final uri = Uri.parse(target);
        final mode = external
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault;
        if (await canLaunchUrl(uri)) {
          return launchUrl(uri, mode: mode);
        }
      } catch (e) {
        log('Failed to open url: $target error: $e');
      }
      return false;
    }

    final afDp = extractAfDp(cleaned);
    if (afDp != null && await tryOpen(afDp)) {
      return true;
    }

    final templateId = extractTemplateIdFromWebUrl(cleaned);
    if (templateId != null) {
      final deepLink = buildCapCutDeepLinkFromTemplateId(templateId);
      if (await tryOpen(deepLink)) return true;
    }

    if (await tryOpen(cleaned, external: true)) {
      return true;
    }

    if (context.mounted) {
      _showMessage(context, 'Unable to open this template link.');
    }
    return false;
  }

  static void _showMessage(BuildContext context, String message) {
    showCupertinoDialog<void>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Notice'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

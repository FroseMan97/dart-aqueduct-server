import 'dart:async';
import 'dart:io';

class HTMLRenderer {
  final Map<String, String> _cache = {};

  Future<String> renderHTML(
      String path, Map<String, String> templateVariables) async {
    final template = await _loadHTMLTemplate(path);
    final result = template.replaceAllMapped(RegExp("{{([a-zA-Z_]+)}}"), (match) {
      final key = match.group(1);
      return templateVariables[key] ?? "null";
    });
    print(result);
    return result;
  }

  Future<String> _loadHTMLTemplate(String path) async {
    var contents = _cache[path];
    if (contents == null) {
      try {
        final file = File(path);
        contents = file.readAsStringSync();
        _cache[path] = contents;
      } catch (_) {}
    }

    return contents;
  }
}

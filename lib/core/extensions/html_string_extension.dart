import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

extension StringExtensions on String {
  String? styleHtmlContent() {
    if (isEmpty) {
      return null;
    }

    try {
      Document doc = parse(this) as Document;

      var headNode = doc.documentElement?.querySelector('html > head');

      if (headNode == null) {
        headNode = Element.html('<head></head>');
        doc.documentElement!.children.insert(0, headNode);
      }

      var metaNode = headNode.querySelector('meta');

      if (metaNode == null) {
        metaNode = Element.html('<meta/>');
        headNode.children.add(metaNode);
      }

      metaNode.attributes['name'] = 'viewport';
      metaNode.attributes['content'] =
          'width=device-width, initial-scale=1.0, shrink-to-fit=no';

      var bodyNode = doc.documentElement?.querySelector('html > body');

      if (bodyNode == null) {
        bodyNode = Element.html('<body></body>');
        doc.documentElement?.children.add(bodyNode);
      }

      bodyNode.attributes['style'] =
          'color: #666666; font-size:12; font-family:-apple-system, BlinkMacSystemFont, sans-serif; margin: 16px; padding: 0px;';

      var result = doc.documentElement?.outerHtml;

      return result;
    } catch (e) {
      return this;
    }
  }

  bool checkURLValid() {
    var result = Uri.tryParse(this)?.isAbsolute == true &&
        Uri.parse(this).scheme == 'https';
    return result;
  }

  String? image360HtmlContent() {
    if (isEmpty) {
      return '';
    }

    try {
      var doc = Document();
      var headNode = Element.html(
          '<head><script src="https://scripts.sirv.com/sirv.js"></script></head>');
      doc.documentElement?.children.add(headNode);

      var metaNode = Element.html('<meta/>');
      headNode.children.add(metaNode);
      metaNode.attributes['name'] = 'viewport';
      metaNode.attributes['content'] =
          'width=device-width, initial-scale=1.0, shrink-to-fit=no';

      var bodyNode = Element.html('<body></body>');
      doc.documentElement?.children.add(bodyNode);

      var imageNode = Element.html(
          '<div class="Sirv" data-src="$this?fullscreen=false&spinOnAnyDrag=false" data-mobile-options="spinOnAnyDrag:false;"></div>');
      bodyNode.children.add(imageNode);

      return doc.documentElement?.outerHtml;
    } catch (e) {
      return this;
    }
  }

  bool isImage360() {
    return isNotEmpty && this == '360';
  }
}

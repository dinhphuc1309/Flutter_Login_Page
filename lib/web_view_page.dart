import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  String url;

  WebViewPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webViewController;
  bool _isWebLoading = true;
  late Uri uri;

  @override
  void initState() {
    super.initState();
    uri = Uri.parse(widget.url);
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isWebLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(uri.origin)) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('${widget.title}: ${uri.query}'),
              ),
            ),
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            body: WebViewWidget(controller: _webViewController!),
          ),
        ),
        _buildLoading(),
      ],
    );
  }

  Widget _buildLoading() {
    return _isWebLoading
        ? Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }
}

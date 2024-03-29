import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/web_view_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();

  final colorBlack = const Color(0xFF0F0F0F);
  final colorWhite = const Color(0xFFFBFBFB);
  final colorLightGrey = const Color(0xFFcfcfcf);
  final colorDarkGrey = const Color(0xFF565656);
  final colorPrimary = const Color(0xffbb2649);

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Result'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorBlack,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _idController,
                          decoration: InputDecoration(
                            hintText: 'ID',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: colorLightGrey,
                            ),
                            filled: true,
                            fillColor: colorDarkGrey,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            isDense: true,
                          ),
                          style: TextStyle(
                            color: colorWhite,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter ID';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _sessionIdController,
                          decoration: InputDecoration(
                            hintText: 'Session ID',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: colorLightGrey,
                            ),
                            filled: true,
                            fillColor: colorDarkGrey,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            isDense: true,
                          ),
                          style: TextStyle(
                            color: colorWhite,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Session ID';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                ),
                onPressed: () {
                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      final id = _idController.text;
                      final sessionId = _sessionIdController.text;
                      String url =
                          'https://www.google.com.vn/?id=$id&session-id=$sessionId';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewPage(
                            title: 'Google',
                            url: url,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorWhite,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return colorDarkGrey.withOpacity(0.2);
                    },
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

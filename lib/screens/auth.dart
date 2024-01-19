import 'package:flutter/material.dart';
import 'package:talk_one/screens/tab.dart';
import 'package:flutter/rendering.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  bool _passwordVisible = true;

  _submit() {
    SemanticsService.announce('Login successfully', TextDirection.ltr);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TabScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Card(
                margin: const EdgeInsets.all(20),
                elevation: 0,
                color: Theme.of(context).colorScheme.background,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(deviceWidth * 0.05),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            // focusNode: _emailFocus,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,

                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          TextFormField(
                            // focusNode: _passwordFocus,
                            keyboardAppearance:
                                MediaQuery.of(context).platformBrightness,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_sharp
                                      : Icons.visibility_off_sharp,
                                  size: 20,
                                ),
                              ),
                              errorMaxLines: 2,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _passwordVisible,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: deviceWidth * 0.15)),
                onPressed: () {
                  _submit();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

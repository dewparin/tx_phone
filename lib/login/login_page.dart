import 'package:flutter/material.dart';
import 'package:tx_phone/constant.dart';
import 'package:tx_phone/phone_guide_feature/phone_list/phone_list_screen.dart';

const _requiredTextLength = 7;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: bgGradientPurpleOrangeYellow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to',
                  style: textStyle16w500DarkGrey,
                ),
                Text(
                  'PhoneX',
                  style: textStyle36w400Gradient.copyWith(height: 48 / 36),
                ),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setFormState(bool ready) {
    setState(() {
      _isFormValid = ready;
    });
  }

  Widget _buildForm(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter ID',
          ),
          onChanged: (text) {
            if (text.isEmpty || text.length < _requiredTextLength) {
              _setFormState(false);
            } else {
              _setFormState(true);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: !_isFormValid
                ? null
                : () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                Navigator.pushReplacementNamed(
                  context,
                  PhoneListScreen.routeName,
                );
              }
            },
            style: OutlinedButton.styleFrom(
              primary: activeMenuTop,
            ),
            child: const Text('Submit'),
          ),
        ),
      ],
    ),
  );
}

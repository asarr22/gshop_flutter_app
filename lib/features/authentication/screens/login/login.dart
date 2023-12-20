import 'package:flutter/material.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login.widget/login_form.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login.widget/login_header_footer.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesValue.padding),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header

              LoginPageHeader(isDarkMode: isDarkMode),
              const SizedBox(height: 30),

              // Login Form
              const LoginForm(),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Divider(color: Colors.grey),
                  ),
                  Text(
                    TextValue.orSignInwith,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Flexible(
                    child: Divider(color: Colors.grey),
                  ),
                ],
              ),

              //Footer
              const SizedBox(height: 20),
              const LoginPageFooter()
            ],
          ),
        ),
      ),
    );
  }
}

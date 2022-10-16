import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/services/form_validation/validation_helper.dart';
import 'package:bookingapp/src/core/shareable_components/my_button.dart';
import 'package:bookingapp/src/core/shareable_components/my_text_form_field.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/title_text.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/clickable_text.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/hint_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<bool> _logIn(LoginModel loginModel) => AuthCubit.get(context).logIn(loginModel);

  void _navigateToHomeScreen() => AuthCubit.get(context).navigateToHomeScreen(context);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
    _passController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// validation Provider
    final validationProvider = Provider.of<ValidationHelper>(context);

    /// getting validation items
    final email = validationProvider.email;
    final pass = validationProvider.pass;

    /// validation methods from Provider
    void validateEmailForm(String? value) => validationProvider.validateEmailForm(value);
    void validatePassForm(String? value) => validationProvider.validateLoginPassForm(value);

    bool btnEnabled = validationProvider.enableLoginButton;

    MyTextFormField buildEmailField() {
      return MyTextFormField(
        focusNode: _emailFocus,
        labelText: 'Your email',
        hintText: 'enter your email',
        controller: _emailController,
        inputAction: TextInputAction.next,
        inputType: TextInputType.emailAddress,
        validationItem: email,
        validateForm: (value) => validateEmailForm(value),
      );
    }

    MyTextFormField buildPasswordField() {
      return MyTextFormField(
        focusNode: _passFocus,
        obscureText: true,
        labelText: 'Password',
        hintText: 'enter password',
        controller: _passController,
        inputAction: TextInputAction.done,
        inputType: TextInputType.visiblePassword,
        validationItem: pass,
        validateForm: (value) => validatePassForm(value),
      );
    }

    Expanded buildTwitterButton() {
      return Expanded(
        child: MyButton(
          text: 'Twitter',
          onPressed: () {},
          icon: FontAwesomeIcons.twitter,
          backgroundColor: AppColors.twitterBlue,
        ),
      );
    }

    Expanded buildFacebookButton() {
      return Expanded(
        child: MyButton(
          text: 'Facebook',
          onPressed: () {},
          icon: FontAwesomeIcons.facebookF,
          backgroundColor: AppColors.facebookBlue,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: 'Log in'),
              const SizedBox(height: 30),
              Row(
                children: [
                  buildFacebookButton(),
                  const SizedBox(width: 15),
                  buildTwitterButton(),
                ],
              ),
              const SizedBox(height: 15),
              const HintText(text: 'or log in with email'),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildEmailField(),
                    buildPasswordField(),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              HintText(
                alignment: Alignment.centerRight,
                text: 'Forgot your password?',
                onTap: () {},
              ),
              const SizedBox(height: 15),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return MyButton(
                    text: 'Log in',
                    onPressed: !btnEnabled
                        ? null
                        : () {
                            _logIn(LoginModel(
                                    email: _emailController.text, password: _passController.text))
                                .whenComplete(() => _navigateToHomeScreen());
                          },
                  );
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HintText(text: "Don't have an account? "),
                  ClickableText(
                    text: 'Sign up',
                    onTap: () => Navigator.pushNamed(context, Routes.registerRoute),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

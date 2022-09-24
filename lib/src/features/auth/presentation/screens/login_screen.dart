import 'package:bookingapp/src/config/routes/app_routes.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<bool> _logIn(LoginModel loginModel) => AuthCubit.get(context).logIn(loginModel, context);
  void _navigateToHomeScreen() => AuthCubit.get(context).navigateToHomeScreen(context);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    return SingleChildScrollView(
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
                _buildFacebookButton(),
                const SizedBox(width: 15),
                _buildTwitterButton(),
              ],
            ),
            const SizedBox(height: 15),
            const HintText(text: 'or log in with email'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildEmailField(),
                  _buildPasswordField(),
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
                  onPressed: () {
                    _logIn(LoginModel(
                      email: _emailController.text.isNotEmpty
                          ? _emailController.text
                          : 'umrhsnE2020@gmail.com',
                      password:
                          _passwordController.text.isNotEmpty ? _passwordController.text : '123456',
                    )).whenComplete(() => _navigateToHomeScreen());
                  },
                );
              },
            ),
            const SizedBox(height: 8),
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
    );
  }

  MyTextFormField _buildEmailField() {
    return MyTextFormField(
      focusNode: _emailFocus,
      labelText: 'Your email',
      hintText: 'enter your email',
      controller: _emailController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
    );
  }

  MyTextFormField _buildPasswordField() {
    return MyTextFormField(
      focusNode: _passwordFocus,
      obscureText: true,
      labelText: 'Password',
      hintText: 'enter password',
      controller: _passwordController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.visiblePassword,
    );
  }

  Expanded _buildTwitterButton() {
    return Expanded(
      child: MyButton(
        text: 'Twitter',
        onPressed: () {},
        icon: FontAwesomeIcons.twitter,
        backgroundColor: AppColors.twitterBlue,
      ),
    );
  }

  Expanded _buildFacebookButton() {
    return Expanded(
      child: MyButton(
        text: 'Facebook',
        onPressed: () {},
        icon: FontAwesomeIcons.facebookF,
        backgroundColor: AppColors.facebookBlue,
      ),
    );
  }
}

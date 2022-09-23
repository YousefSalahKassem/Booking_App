import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/shareable_components/my_button.dart';
import 'package:bookingapp/src/core/shareable_components/my_text_form_field.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/title_text.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/clickable_text.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/hint_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void _register(RegisterModel registerModel) => AuthCubit.get(context).register(registerModel);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmationFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: 'Sign up'),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildFacebookButton(),
                  const SizedBox(width: 15),
                  _buildTwitterButton(),
                ],
              ),
              const SizedBox(height: 15),
              const HintText(text: 'or sign up with email'),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildNameField(),
                    _buildEmailField(),
                    _buildPasswordField(),
                    _buildPasswordConfirmationField(),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return MyButton(
                    text: 'Sign up',
                    onPressed: () => _register(
                      RegisterModel(
                        name: _nameController.text.isNotEmpty
                            ? _nameController.text
                            : 'Abdullah Mansour',
                        email: _emailController.text.isNotEmpty
                            ? _emailController.text
                            : 'abdullah.mansour@gmail.com',
                        password: _passwordController.text.isNotEmpty
                            ? _passwordController.text
                            : '123456',
                        passwordConfirmation: _passwordConfirmationController.text.isNotEmpty
                            ? _passwordConfirmationController.text
                            : '123456',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              const HintText(
                text: 'By signing up, you agreed with our terms of services and privacy policy',
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HintText(text: 'Already have an account? '),
                  ClickableText(
                    text: 'Log in',
                    onTap: () => Navigator.pushNamed(context, Routes.loginRoute),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  MyTextFormField _buildNameField() {
    return MyTextFormField(
      focusNode: _nameFocus,
      labelText: 'Your name',
      hintText: 'enter your name',
      controller: _nameController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
    );
  }

  MyTextFormField _buildEmailField() {
    return MyTextFormField(
      focusNode: _emailFocus,
      labelText: 'Your email',
      hintText: 'enter your email',
      controller: _emailController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.name,
    );
  }

  MyTextFormField _buildPasswordField() {
    return MyTextFormField(
      focusNode: _passwordFocus,
      obscureText: true,
      labelText: 'Password',
      hintText: 'enter password',
      controller: _passwordController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.visiblePassword,
    );
  }

  MyTextFormField _buildPasswordConfirmationField() {
    return MyTextFormField(
      focusNode: _passwordConfirmationFocus,
      obscureText: true,
      labelText: 'Password confirmation',
      hintText: 're-enter password',
      controller: _passwordConfirmationController,
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

import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/services/form_validation/validation_helper.dart';
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
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Future<bool> _register(RegisterModel registerModel) =>
      AuthCubit.get(context).register(registerModel);

  void _navigateToHomeScreen() => AuthCubit.get(context).navigateToHomeScreen(context);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _passConfirmFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _passController.addListener(() => setState(() {}));
    _passConfirmController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _passConfirmController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _passConfirmFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// validation Provider
    final validationProvider = Provider.of<ValidationHelper>(context);

    /// getting validation items
    final name = validationProvider.name;
    final email = validationProvider.email;
    final pass = validationProvider.pass;
    final passConfirm = validationProvider.passConfirm;

    /// validation methods from Provider
    void validateNameForm(String? value) => validationProvider.validateNameForm(value);
    void validateEmailForm(String? value) => validationProvider.validateEmailForm(value);
    void validatePassForm(String? value) => validationProvider.validateRegisterPassForm(value);
    void validatePassConfirmForm(String? value) =>
        validationProvider.validatePassConfirmForm(value);

    bool btnEnabled = validationProvider.enableLoginButton;

    MyTextFormField buildNameField() {
      return MyTextFormField(
        focusNode: _nameFocus,
        labelText: 'Your name',
        hintText: 'enter your name',
        controller: _nameController,
        inputAction: TextInputAction.next,
        inputType: TextInputType.name,
        validationItem: name,
        validateForm: (value) => validateNameForm(value),
      );
    }

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
        inputAction: TextInputAction.next,
        inputType: TextInputType.visiblePassword,
        validationItem: pass,
        validateForm: (value) => validatePassForm(value),
      );
    }

    MyTextFormField buildPasswordConfirmationField() {
      return MyTextFormField(
        focusNode: _passConfirmFocus,
        obscureText: true,
        labelText: 'Password confirmation',
        hintText: 're-enter password',
        controller: _passConfirmController,
        inputAction: TextInputAction.done,
        inputType: TextInputType.visiblePassword,
        validationItem: passConfirm,
        validateForm: (value) => validatePassConfirmForm(value),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                      buildNameField(),
                      buildEmailField(),
                      buildPasswordField(),
                      buildPasswordConfirmationField(),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return MyButton(
                      text: 'Sign up',
                      onPressed: !btnEnabled
                          ? null
                          : () => _register(
                                RegisterModel(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passController.text,
                                  passwordConfirmation: _passConfirmController.text,
                                ),
                              ).whenComplete(() => _navigateToHomeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 15),
                const HintText(
                  text: 'By signing up, you agreed with our terms of services and privacy policy',
                ),
                const SizedBox(height: 15),
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
      ),
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

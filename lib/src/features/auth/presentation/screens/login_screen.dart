import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _logIn(LoginModel loginModel) => AuthCubit.get(context).logIn(loginModel);

  @override
  void initState() {
    AuthCubit.get(context).navigateToTestHome(context);
    super.initState();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is LoginLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthError) {
        return const Center(child: Text('ERROR', style: TextStyle(color: Colors.red)));
      } else if (state is LoginComplete) {
        return Center(child: Text('type:${state.status.type}'));
      } else {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              _logIn(const LoginModel(
                email: 'abdullah.mansour@gmail.com',
                password: '123456',
              ));
            },
            child: const Text('LOGIN'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _buildBodyContent());
  }
}

import 'package:fix_flex/cubits/login_cubit/login_cubit.dart';
import 'package:fix_flex/cubits/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/back_ground.dart';
import '../components/default_form_field.dart';
import '../cubits/login_cubit/login_state.dart';
import '../helper/secure_storage/secure_keys/secure_key.dart';
import '../helper/secure_storage/secure_keys/secure_variable.dart';
import '../helper/secure_storage/secure_storage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  static const String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackGround(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => LoginCubit(),
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) async {
                      if (state is LoginLoadingState) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        LoginCubit.get(context).isLoading = true;
                      } else if (state is LoginErrorState) {
                        LoginCubit.get(context).isLoading = false;
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 4),
                            content: Text(
                              state.error,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else if (state is LoginSuccessState) {
                        LoginCubit.get(context).isLoading = false;
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        Duration(milliseconds: 500);
                        SecureVariables.token =
                            await SecureStorage.getData(key: SecureKey.token);
                        SecureVariables.userId =
                            await SecureStorage.getData(key: SecureKey.userId);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      }
                    },
                    builder: (context, state) {
                      var cubit = LoginCubit.get(context);
                      return Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Image.asset(
                              'assets/images/fixFlex3.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 100,
                            ),

                            //Email TFF
                            defaultFormField(
                              controller: cubit.emailController,
                              keyType: TextInputType.emailAddress,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9@a-zA-Z.]")),
                              ],
                              validate: cubit.validateEmail,
                              fillColor: Colors.white,
                              prefix: Icons.email,
                              label: 'Email',
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            //Password TFF
                            BlocBuilder<ObscurePasswordCubit,
                                ObscurePasswordState>(
                              builder: (context, state) {
                                return defaultFormField(
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: cubit.passwordController,
                                  keyType: TextInputType.visiblePassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return '• Password Can\'t be empty';
                                    }
                                    return null;
                                  },
                                  fillColor: Colors.white,
                                  prefix: Icons.lock,
                                  label: 'Password',
                                  suffix: ObscurePasswordCubit.get(context)
                                      .LoginPasswordIcon,
                                  suffixPressed: () {
                                    ObscurePasswordCubit.get(context)
                                        .changeLoginPasswordVisibility();
                                  },
                                  isPassword: ObscurePasswordCubit.get(context)
                                      .isLoginPasswordShow,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 130,
                            ),
                            //Login Button
                            Container(
                              width: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xff134161),
                                // color: Color(0xff222a32),
                              ),
                              child: AbsorbPointer(
                                absorbing: LoginCubit.get(context).isLoading,
                                child: TextButton(
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      if (cubit.emailController.text
                                              .isNotEmpty &&
                                          cubit.passwordController.text
                                              .isNotEmpty) {
                                        cubit.login(
                                          email: cubit.emailController.text
                                              .toLowerCase(),
                                          password:
                                              cubit.passwordController.text,
                                        );
                                        ObscurePasswordCubit.get(context).isLoginPasswordShow = true;
                                        ObscurePasswordCubit.get(context).isRegisterPasswordShow = true ;
                                        ObscurePasswordCubit.get(context).isRegisterConfirmPasswordShow = true;
                                      }
                                    }
                                  },
                                  child: LoginCubit.get(context).isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Login',
                                          style: TextStyle(
                                            // color: Color(0xff222a32),
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            //Register line
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RegisterScreen.id);
                                  },
                                  child: const Text(
                                    'Register Now',
                                    style: TextStyle(
                                      color: Color(0xff66a3d5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

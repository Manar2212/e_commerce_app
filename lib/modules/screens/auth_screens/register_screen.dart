
import 'package:e_commerce_app/modules/screens/auth_screens/auth_cubits/auth_cubit.dart';
import 'package:e_commerce_app/modules/screens/auth_screens/login_screen.dart';
import 'package:e_commerce_app/modules/screens/home_screen.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/layout_screen.dart';
import '../../../shared/components/custome_button.dart';
import '../../../shared/components/custome_textformfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String id = 'registerscreen';


  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final
    phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    bool isPassword = true;
    GlobalKey<FormState> formkey = GlobalKey();
    return BlocConsumer<AuthCubit,AuthState>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            Navigator.pushReplacementNamed(context, LayoutScreen.id);
          }else if(state is RegisterFailureState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context,state){
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    SizedBox(height: 100,),
                    Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                    SizedBox(height: 30,),
                    CustomeTextformfield(controller: nameController, prefixIcon: Icons.perm_identity, hintText: 'UserName', labelText:'UserName'),
                    SizedBox(height: 20,),
                    CustomeTextformfield(controller: emailController, prefixIcon: Icons.email_outlined, hintText: 'Email', labelText:'Email',inputType: TextInputType.emailAddress),
                    SizedBox(height: 20,),
                    CustomeTextformfield(controller: passwordController, prefixIcon: Icons.lock_outline, hintText: 'Password', labelText:'Password',suffixIcon: isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined,
                    isObscure: isPassword,
                    suffixPressed: (){
                      isPassword = !isPassword;
                      BlocProvider.of<AuthCubit>(context).emit(RegisterPasswordState());
                    },
                    ),
                    SizedBox(height: 20,),
                    CustomeTextformfield(controller: phoneController, prefixIcon: Icons.phone, hintText: 'Phone', labelText:'Phone',inputType: TextInputType.phone),
                    SizedBox(height: 20,),
                    CustomeButton(widget: state is RegisterLoadingState?  CircularProgressIndicator(color: Colors.white,) : Text('Register',style: TextStyle(color: Colors.white,fontSize: 20),), function: (){
                      if(formkey.currentState!.validate()){
                        BlocProvider.of<AuthCubit>(context).register(name: nameController.text, email: emailController.text, phone: phoneController.text, password: passwordController.text);
                      }
                    }),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account'),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(context, LoginScreen.id);
                        }, child: Text('Login Now')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}

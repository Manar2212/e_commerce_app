import 'package:e_commerce_app/layout/layout_screen.dart';
import 'package:e_commerce_app/modules/screens/auth_screens/register_screen.dart';
import 'package:e_commerce_app/modules/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/custome_button.dart';
import '../../../shared/components/custome_textformfield.dart';
import 'auth_cubits/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'loginscreen';
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool isPassword = true;
    GlobalKey<FormState> formkey = GlobalKey();
    return Scaffold(
      body:Container(
        height: double.infinity,
        width:  double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/auth_background.png'),fit: BoxFit.fill),
        ),
          child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
             if(state is LoginSuccessState){
               Navigator.pushReplacementNamed(context, LayoutScreen.id);
             }else if(state is LoginFailureState){
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(state.errMessage)),
               );
             }
            },
          builder: (context, state) {
            return Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Text('Login to continue process',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                              ))),
                      Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60),
                                topLeft: Radius.circular(60),
                              ),
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: formkey,
                                child: ListView(
                                  children: [
                                    Center(child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize:25 ),)),
                                    SizedBox(height: 30,),
                                    CustomeTextformfield(controller: emailController, prefixIcon: Icons.email_outlined, hintText: 'Email', labelText:'Email',inputType: TextInputType.emailAddress),
                                    SizedBox(height: 20,),
                                    CustomeTextformfield(controller: passwordController, prefixIcon: Icons.lock_outline, hintText: 'Password', labelText:'Password',suffixIcon: isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined,
                                      isObscure: isPassword,
                                      suffixPressed: (){
                                        isPassword = !isPassword;
                                        BlocProvider.of<AuthCubit>(context).emit(RegisterPasswordState());
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                      TextButton(onPressed: (){}, child: Text('Forget Password?')),
                                    ],),
                                    CustomeButton(widget: state is LoginLoadingState?  CircularProgressIndicator(color: Colors.white,) : Text('Login',style: TextStyle(color: Colors.white,fontSize: 20),), function: (){
                                      if(formkey.currentState!.validate()){
                                        BlocProvider.of<AuthCubit>(context).login( email: emailController.text,  password: passwordController.text);
                                      }
                                    }),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Don\'t have an account'),
                                        TextButton(onPressed: (){
                                          Navigator.pushReplacementNamed(context, RegisterScreen.id);
                                        }, child: Text('Register Now')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  );
          },
),
        ),
    );
  }
}

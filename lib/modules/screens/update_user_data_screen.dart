import 'dart:io';

import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/shared/components/custome_button.dart';
import 'package:e_commerce_app/shared/components/custome_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/constants/constants.dart';

class UpdateUserDataScreen extends StatelessWidget {
   UpdateUserDataScreen({Key? key}) : super(key: key);
static String id = 'updateuserdatascreen';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    cubit.getUserData();
    nameController.text = cubit.userModel!.name!;
    emailController.text = cubit.userModel!.email!;
    phoneController.text = cubit.userModel!.phone!;
    String? image;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data',style: TextStyle(color: fifthColor),),
        elevation: 0,
        backgroundColor: thirdColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  decoration:   BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(cubit.userModel!.image!),
                      radius: 60,
                    ),
                  ),
                ),
                Positioned(child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: (){
                    image = cubit.pickImage() as String ;
                  },
                ),
                bottom: -10,
                  left: 200,
                )
              ],
            ),
            SizedBox(height: 30,),
            CustomeTextformfield(controller: nameController, prefixIcon: Icons.person, hintText: 'Name', labelText: 'Name'),
            SizedBox(height: 10,),
            CustomeTextformfield(controller: emailController, prefixIcon: Icons.email, hintText: 'Email', labelText: 'Email'),
            SizedBox(height: 10,),
            CustomeTextformfield(controller: phoneController, prefixIcon: Icons.phone, hintText: 'Phone', labelText: 'Phone'),
            SizedBox(height: 10,),
            BlocConsumer<LayoutCubit, LayoutState>(
            listener: (context, state) {
              if(state is UpdateProfileSuccessState){
                Navigator.pop(context);
                cubit.getUserData();
                showSnackBar(context, message: 'Update Data Successfully', errOrSuccess: true);
              }else if(state is UpdateProfileFailureState){
                showSnackBar(context, message: state.errMessage, errOrSuccess: false);
              }
            },
            builder: (context, state) {
              return CustomeButton(widget: state is UpdateProfileLoadingState ? CircularProgressIndicator(color: Colors.white,): Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),), function:(){
                if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty){
                  cubit.updateUserData(name: nameController.text.trim(), email: emailController.text.trim(), phone: phoneController.text.trim(),image: image.toString());
                }else{
                  showSnackBar(context, message: 'Please enter all data!!!!!!', errOrSuccess: false);
                }
            });
  },
)

          ],
        ),
      ),
    );
  }

   void showSnackBar( BuildContext context, {required String message,required bool errOrSuccess}) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('$message'),backgroundColor: errOrSuccess ? Colors.green : Colors.red),
     );
   }

}



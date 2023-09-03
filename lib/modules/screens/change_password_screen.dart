import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/shared/components/custome_button.dart';
import 'package:e_commerce_app/shared/components/custome_textformfield.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
static String id = 'changepasswordscreen';
  @override
  Widget build(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password',style: TextStyle(color: fifthColor),),
        elevation: 0,
        backgroundColor: thirdColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomeTextformfield(controller: currentPasswordController, prefixIcon: Icons.lock_outline, hintText: 'Current Password', labelText: 'Current Password',),
            SizedBox(height: 20,),
            CustomeTextformfield(controller: newPasswordController, prefixIcon: Icons.lock_outline, hintText: 'New Password', labelText: 'New Password'),
            SizedBox(height: 20,),
            BlocConsumer<LayoutCubit, LayoutState>(
              listener: (context, state) {
                if(state is ChangePasswordSuccessState){
                  Navigator.pop(context);
                  showSnackBar(context, message: 'Updated Password Successfully', errOrSuccess: true);
                }else{
                  if(state is ChangePasswordFailureState){
                    showSnackBar(context, message: state.errMessage, errOrSuccess: false);
                  }
                }
              },
              builder: (context, state) {
                final cubit = BlocProvider.of<LayoutCubit>(context);
                return CustomeButton(widget: state is ChangePasswordLoadingState ?
                  CircularProgressIndicator(color: Colors.white)
                  : Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                    function: (){
                  if(currentPasswordController.text.trim() == currentPassword){
                    if(newPasswordController.text.trim().length >= 6){
                      cubit.changePassword(currentPassword: currentPasswordController.text.trim(), newPassword: newPasswordController.text.trim());
                    }else{
                      showSnackBar(context, message: 'must be at least 6 characters', errOrSuccess: false);
                    }
                  }else{
                    showSnackBar(context,errOrSuccess: false,message: 'Current Password dosen\'t match , Please try again');
                  }
                    });
              },
            ),
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

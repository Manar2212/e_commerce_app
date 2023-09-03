import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
static String id = 'categoriesscreen';
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.9,
        ), itemCount: categories.length,
            itemBuilder: (context,index){
          return Column(
            children: [
              Expanded(child: Image.network(categories[index].image,fit: BoxFit.fill,)),
              SizedBox(height: 10,),
              Text('${categories[index].name}',style: TextStyle(fontWeight: FontWeight.bold,color: fifthColor),)
            ],
          );
        }
        ),
      ),
    );
  }
}

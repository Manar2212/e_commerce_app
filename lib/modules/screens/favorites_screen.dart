import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/favorite_product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
            child: Column(
              children: [
                // TextFormField(
                //   onChanged: (input){
                //     cubit.getFilteredFavorites(input: input);
                //   },
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //     prefixIcon: Icon(Icons.search),
                //     filled: true,
                //     fillColor: Colors.grey.withOpacity(0.3),
                //     hintText: 'Search',
                //   ),
                // ),
                SizedBox(height: 10,),
                cubit.favorites.isEmpty ? Center(child: CircularProgressIndicator(),) :
                Expanded(
                  child: ListView.builder(
                      itemCount:  cubit.favorites.length,
                      itemBuilder: (context,index){
                        return FavoriteProductItem(productModel:  cubit.favorites[index] , cubit: cubit);
                      }
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// Card(
// elevation: 3,
// color: thirdColor,
// margin: EdgeInsets.only(top:10,bottom: 10),
// child: Padding(
// padding: const EdgeInsets.all(10),
// child: Row(
// children: [
// Image.network(cubit.favorites[index].image,fit: BoxFit.fill,width: 100,height: 100,),
// SizedBox(width: 10,),
// Expanded(
// child: Column(
// children: [
// Text(cubit.favorites[index].name,style: TextStyle(color: fifthColor,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),maxLines: 1,),
// SizedBox(height: 5,),
// Text('${cubit.favorites[index].price}\$',style: TextStyle(fontWeight: FontWeight.bold),),
// SizedBox(height: 5,),
// MaterialButton(onPressed: (){
// cubit.addOrRemoveFavoritesProducts(productID: cubit.favorites[index].id.toString());
// },
// child: Text('Remove',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
// elevation: 3,
// color: fourthColor,
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// )
// ],
// ),
// ),
// ],
// ),
// ),
// );
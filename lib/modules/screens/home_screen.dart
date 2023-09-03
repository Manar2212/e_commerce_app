import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/modules/screens/categories_screen.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'homescreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        PageController controller = PageController();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (input){
                    cubit.getFilteredProducts(input: input);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 10,),
                      cubit.banners.isEmpty ?
                          Center(child: CircularProgressIndicator()) :
                          Container(
                        height: 220,
                        width: double.infinity,
                        child: PageView.builder(
                          physics: BouncingScrollPhysics(),
                            itemCount: cubit.banners.length,
                            controller: controller,
                            onPageChanged: (int index){
                            cubit.ChangeBanner(index,controller);
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Image.network(cubit.banners[index].image,fit: BoxFit.fill,),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count:  cubit.banners.length,
                          axisDirection: Axis.horizontal,
                          effect:  ScrollingDotsEffect(
                              spacing:  8.0,
                              radius:  10,
                              dotWidth:  8,
                              dotHeight:  8,
                              strokeWidth:  1.5,
                              dotColor:  Colors.grey,
                              activeDotColor:  fourthColor,
                          ),
                        ),
                      ),
                      ListTile(title: Text('Categories',style: TextStyle(color: fifthColor,fontWeight: FontWeight.bold)),
                      trailing: TextButton(child: Text('View all'),onPressed: (){
                      },),
                      ),
                      cubit.categories.isEmpty ?
                          Center(child: CircularProgressIndicator(),) :
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(cubit.categories[index].image),
                              );
                            },
                            separatorBuilder: (context,index){
                              return SizedBox(width: 10,);
                            },
                            itemCount: cubit.categories.length),
                      ),
                      ListTile(
                        title: Text('Products',style: TextStyle(color: fifthColor,fontWeight: FontWeight.bold)),
                        trailing: TextButton(
                          child: Text('View all'),
                          onPressed: (){},
                        ),
                      ),
                      cubit.products.isEmpty ?
                          Center(child: CircularProgressIndicator(),) :
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5
                          ),
                          itemCount: cubit.filteredProducts.isEmpty ?
                          cubit.products.length : cubit.filteredProducts.length
                          ,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:(context,index){
                            return ProductItem(productModel: cubit.filteredProducts.isEmpty ?
                            cubit.products[index] : cubit.filteredProducts[index],cubit: cubit,
                            );
                          } ),

                    ],
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

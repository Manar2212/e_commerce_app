import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/modules/screens/cart_screen.dart';
import 'package:e_commerce_app/modules/screens/categories_screen.dart';
import 'package:e_commerce_app/modules/screens/favorites_screen.dart';
import 'package:e_commerce_app/modules/screens/home_screen.dart';
import 'package:e_commerce_app/modules/screens/profile_screen.dart';
import 'package:e_commerce_app/shared/network/local/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../shared/constants/constants.dart';
import '../../shared/network/remote/api_helper.dart';
import '../../shared/network/remote/end_points.dart';
part 'layout_state.dart';


class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  UserModel? userModel;


  //profile
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    // try{
    //    http.Response response = await http.get(
    //      Uri.parse('https://student.valuxapps.com/api/profile'),
    //      headers: {
    //        'lang':'en',
    //        'Authorization' : token!,
    //      }
    //    );
    //    if(response.statusCode == 200){
    //      var responseBody = jsonDecode(response.body);
    //      if(responseBody['status'] == true){
    //        userModel = UserModel.fromJson(responseBody['data']);
    //        print(responseBody);
    //        emit(GetUserDataSuccessState());
    //      }else{
    //        emit(GetUserDataFailureState(errMessage: responseBody['message']));
    //      }
    //    }
    // }on Exception catch(e){
    //   emit(GetUserDataFailureState(errMessage: e.toString()));
    // }

    var responseBody = await Api().get(url: Profile, token: token!);
    if (responseBody['status'] == true) {
      userModel = UserModel.fromJson(responseBody['data']);
      print(responseBody);
      emit(GetUserDataSuccessState());
    } else {
      emit(GetUserDataFailureState(errMessage: responseBody['message']));
    }
  }


  int bottomNavIndex = 0;
 List<Widget> layoutScreens = [HomeScreen(),CategoriesScreen(),FavoritesScreen(),CartScreen(),ProfileScreen()];
 void ChangeBottomNavBar(int index){
   bottomNavIndex = index;
   emit(ChangeBottomNav());
 }


 //get banners
  List<BannerModel> banners = [];
 Future<void> getBannerData()async{
   emit(GetBannerLoadingState());
   // try{
   //   http.Response response = await http.get(
   //     Uri.parse('https://student.valuxapps.com/api/banners'),
   //     headers: {
   //       'lang':'en',
   //     }
   //   );
   //   if(response.statusCode == 200){
   //     var responseBody = jsonDecode(response.body);
   //     if(responseBody['status'] == true){
   //       for(var item in responseBody['data']){
   //        banners.add(BannerModel.fromJson(item));
   //       }
   //       emit(GetBannerSuccessState());
   //     }else{
   //       emit(GetBannerFailureState(errMessage: 'something went wrong'));
   //     }
   //   }
   // }on Exception catch(ex){
   //   emit(GetBannerFailureState(errMessage: ex.toString()));
   // }
   var responseBody = await Api().get(url: Banners);
   if(responseBody['status'] == true){
           for(var item in responseBody['data']){
            banners.add(BannerModel.fromJson(item));
           }
           emit(GetBannerSuccessState());
         }else{
           emit(GetBannerFailureState(errMessage: 'something went wrong'));
         }
 }


  int bannerIndex = 0;
  void ChangeBanner(int index,PageController controller){
    bannerIndex = index;
     controller.animateToPage(index, duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
    emit(ChangeBannerState());
  }


  //get categories
  List<CategoryModel> categories = [];
  Future<void> getCategoriesData()async{
    emit(GetCategoriesLoadingState());
    // try{
    //   http.Response response =await  http.get(
    //     Uri.parse('https://student.valuxapps.com/api/categories'),
    //     headers: {
    //       'lang':'en'
    //     }
    //   );
    //   if(response.statusCode == 200){
    //     var responseBody = jsonDecode(response.body);
    //     if(responseBody['status'] == true){
    //       for(var item in responseBody['data']['data']){
    //         categories.add(CategoryModel.fromJson(item));
    //       }
    //       emit(GetCategoriesSuccessState());
    //     }else{
    //       emit(GetCategoriesFailureState(errMessage: 'Something went wrong'));
    //     }
    //   }
    // }on Exception catch(ex){
    //   emit(GetCategoriesFailureState(errMessage: ex.toString()));
    // }
    var responseBody = await Api().get(url: Categories);
    if(responseBody['status'] == true){
            for(var item in responseBody['data']['data']){
              categories.add(CategoryModel.fromJson(item));
            }
            emit(GetCategoriesSuccessState());
          }else{
            emit(GetCategoriesFailureState(errMessage: 'Something went wrong'));
          }
  }


  //get products
  List<ProductModel> products = [];
  Future<void> getProductsData()async{
    emit(GetProductsLoadingState());
    // try{
    //   http.Response response = await http.get(
    //     Uri.parse('https://student.valuxapps.com/api/home'),
    //     headers: {
    //       'Authorization' : token!,
    //       'lang':'en',
    //     }
    //   );
    //   if(response.statusCode == 200){
    //     var responseBody = jsonDecode(response.body);
    //     print(responseBody);
    //     if(responseBody['status'] == true){
    //       for(var item in responseBody['data']['products']){
    //         products.add(ProductModel.fromJson(item));
    //       }
    //       emit(GetProductsSuccessState());
    //     }else{
    //      emit(GetProductsFailureState(errMessage: 'Something went wrong'));
    //     }
    //   }
    // }on Exception catch(ex){
    //   emit(GetProductsFailureState(errMessage: ex.toString()));
    // }
    var responseBody = await Api().get(url: Home, token: token!);
    if(responseBody['status'] == true){
            for(var item in responseBody['data']['products']){
              products.add(ProductModel.fromJson(item));
            }
            emit(GetProductsSuccessState());
          }else{
           emit(GetProductsFailureState(errMessage: 'Something went wrong'));
          }
  }

  List<ProductModel> filteredProducts = [];
  void getFilteredProducts({required String input}){
    filteredProducts = products.where((element) => element.name.toLowerCase().startsWith(input.toLowerCase())  || element.price.toString().startsWith(input.toString())).toList();
    emit(GetFilteredProductsSuccessState());
  }


  // get favorites
  List<ProductModel> favorites = [];
  Set<String> favoritesID = {};
  Future<void> getFavoritesProducts()async{
    favorites = [];
    // try{
    //   http.Response response = await http.get(
    //     Uri.parse('https://student.valuxapps.com/api/favorites'),
    //     headers: {
    //       'Authorization' : token!,
    //       'lang':'en',
    //     }
    //   );
    //   if(response.statusCode == 200){
    //     var responseBody = jsonDecode(response.body);
    //     if(responseBody['status'] == true){
    //       for(var item in responseBody['data']['data']){
    //         favorites.add(ProductModel.fromJson(item['product']));
    //         favoritesID.add(item['product']['id'].toString());
    //       }
    //       print('Favorites Number is ${favorites.length}');
    //       emit(GetFilteredProductsSuccessState());
    //     }else{
    //       emit(GetFavoritesProductsFailureState());
    //     }
    //   }
    // }on Exception catch(e){
    //   emit(GetFavoritesProductsFailureState());
    // }
    var responseBody = await Api().get(url: Favorites, token: token!);
    if(responseBody['status'] == true){
            for(var item in responseBody['data']['data']){
              favorites.add(ProductModel.fromJson(item['product']));
              favoritesID.add(item['product']['id'].toString());
            }
            print('Favorites Number is ${favorites.length}');
            emit(GetFilteredProductsSuccessState());
          }else{
            emit(GetFavoritesProductsFailureState());
          }
  }

  //add or remove favorites
  Future<void> addOrRemoveFavoritesProducts({required String productID})async{
    // try{
    //   http.Response response = await http.post(
    //     Uri.parse('https://student.valuxapps.com/api/favorites'),
    //     headers: {
    //       'lang':'en',
    //       'Authorization':token!,
    //     },
    //     body: {
    //       'product_id':productID,
    //   }
    //   );
    //
    //   if(response.statusCode == 200){
    //     var responseBody = jsonDecode(response.body);
    //     if(responseBody['status'] == true){
    //       if(favoritesID.contains(productID)){
    //         //لو موجود اشيله delete
    //         favoritesID.remove(productID);
    //       }else{
    //         //add لو مش موجود اضيفه
    //         favoritesID.add(productID);
    //       }
    //       await getFavoritesProducts();
    //       emit(AddOrRemoveFavoritesProductsSuccessState());
    //     }else{
    //       emit(AddOrRemoveFavoritesProductsFailureState());
    //     }
    //   }
    // }on Exception catch(ex){
    //   emit(AddOrRemoveFavoritesProductsFailureState());
    // }
    var responseBody = await Api().post(url: Favorites, body: {'product_id':productID}, token: token!);
    if(responseBody['status'] == true){
            if(favoritesID.contains(productID)){
              //لو موجود اشيله delete
              favoritesID.remove(productID);
            }else{
              //add لو مش موجود اضيفه
              favoritesID.add(productID);
            }
            await getFavoritesProducts();
            emit(AddOrRemoveFavoritesProductsSuccessState());
          }else{
            emit(AddOrRemoveFavoritesProductsFailureState());
          }
  }

  // List<ProductModel> filteredFavorites = [];
  // void getFilteredFavorites({required String input})async{
  //   filteredFavorites = favorites.where((element) => element.name.toLowerCase().startsWith(input.toLowerCase()) || element.price.toString().startsWith(element.toString())).toList();
  //   emit(GetFilteredFavoritesSuccessState());
  // }
  
  List<ProductModel> carts = [];
  int totalPrice = 0;
  Set<String> cartsID = {};
Future<void> getCartsData()async{
  carts = [];
  var responseBody = await Api().get(url: Carts, token: token!);
  if(responseBody['status'] == true){
    totalPrice = responseBody['data']['total'].toInt();
    for(var item in responseBody['data']['cart_items']){
      carts.add(ProductModel.fromJson(item['product']));
      cartsID.add(item['product']['id'].toString());
    }
    print('Carts Number is ${carts.length}');
    emit(GetCartsSuccessState());
  }else{
    emit(GetCartsFailureState());
  }
}

Future<void> addOrRemoveCartData({required String productID})async{
  var responseBody = await Api().post(url: Carts, body: {'product_id': productID}, token: token!);
  if(responseBody['status'] == true){
    if(cartsID.contains(productID)){
      cartsID.remove(productID);
    }else{
      cartsID.add(productID);
    }
    await getCartsData();
    emit(AddOrRemoveCartsProductsSuccessState());
  }else{
    emit(AddOrRemoveCartsProductsFailureState());
  }
}



Future<void> changePassword({required String currentPassword,required String newPassword})async{
  emit(ChangePasswordLoadingState());
  var responseBody = await Api().post(url: ChangePassword, body: {
    "current_password": currentPassword,
    "new_password": newPassword,
  }, token: token!);

  if(responseBody['status'] == true){
    await CacheNetwork.insertToCache(key: 'password', value: newPassword);
    currentPassword = await CacheNetwork.getCacheData(key: newPassword);
    emit(ChangePasswordSuccessState());
  }else{
    emit(ChangePasswordFailureState(errMessage: responseBody['message']));
  }
}

  File? imageFile;
  Future<dynamic> pickImage()async{
    final pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickImage != null){
      // imageFile = File(pickImage.path);
      // print('image path : $imageFile');
      imageFile = File(pickImage.path);
      Uint8List? imageBytes = imageFile?.readAsBytesSync();
      String baseimage = base64Encode(imageBytes as List<int>);
      // var nameImage = basename(pickImage.path).toString();
      emit(UpdateImageSuccessState());
      // print('Image name is : $nameImage');
      print('baseimage is $baseimage');
      return baseimage;
    } else{
      emit(UpdateImageFailureState(errMessage: 'something error happen'));
    }
  }


Future<void> updateUserData({required String name,required String email,required String phone,required String image})async{
  emit(UpdateProfileLoadingState());
  var responseBody = await Api().put(url: UpdateProfile, body: {
    "name":name,
    "phone":phone,
    "email":email,
    "image":image,
  }, token: token!);

  if(responseBody['status'] == true){
    await getUserData();
    emit(UpdateProfileSuccessState());
  }else{
    emit(UpdateProfileFailureState(errMessage: responseBody['message']));
  }
}


}




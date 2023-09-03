part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class ChangeBottomNav extends LayoutState{}

class GetUserDataLoadingState extends LayoutState{}
class GetUserDataSuccessState extends LayoutState{}
class GetUserDataFailureState extends LayoutState{
  String errMessage;
  GetUserDataFailureState({required this.errMessage});
}

class GetBannerLoadingState extends LayoutState{}
class GetBannerSuccessState extends LayoutState{}
class GetBannerFailureState extends LayoutState{
  String errMessage;
  GetBannerFailureState({required this.errMessage});
}

class ChangeBannerState extends LayoutState{}

class GetCategoriesLoadingState extends LayoutState{}
class GetCategoriesSuccessState extends LayoutState{}
class GetCategoriesFailureState extends LayoutState{
  String errMessage;
  GetCategoriesFailureState({required this.errMessage});
}

class GetProductsLoadingState extends LayoutState{}
class GetProductsSuccessState extends LayoutState{}
class GetProductsFailureState extends LayoutState{
  String errMessage;
  GetProductsFailureState({required this.errMessage});
}

class GetFilteredProductsSuccessState extends LayoutState{}

class GetFavoritesProductsSuccessState extends LayoutState{}
class GetFavoritesProductsFailureState extends LayoutState{}

class AddOrRemoveFavoritesProductsSuccessState extends LayoutState{}
class AddOrRemoveFavoritesProductsFailureState extends LayoutState{}

// class GetFilteredFavoritesSuccessState extends LayoutState{}
// class GetFilteredFavoritesFailureState extends LayoutState{}

class GetCartsSuccessState extends LayoutState{}
class GetCartsFailureState extends LayoutState{}

class AddOrRemoveCartsProductsSuccessState extends LayoutState{}
class AddOrRemoveCartsProductsFailureState extends LayoutState{}

class ChangePasswordLoadingState extends LayoutState{}
class ChangePasswordSuccessState extends LayoutState{}
class ChangePasswordFailureState extends LayoutState{
  String errMessage;
  ChangePasswordFailureState({required this.errMessage});
}

class UpdateProfileLoadingState extends LayoutState{}
class UpdateProfileSuccessState extends LayoutState{}
class UpdateProfileFailureState extends LayoutState{
  String errMessage;
  UpdateProfileFailureState({required this.errMessage});
}

class UpdateImageSuccessState extends LayoutState{}
class UpdateImageFailureState extends LayoutState{
  String errMessage;
  UpdateImageFailureState({required this.errMessage});
}
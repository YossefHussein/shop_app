import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/constant.dart';
import '../../network/end_point.dart';
import '../../network/remote/dio_helper.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(value) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: searchProduct,
      data: {
        'text': value,
      },
      token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitial());
}

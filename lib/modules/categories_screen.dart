import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildCategoryItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
            separatorBuilder: (BuildContext context, int index) => myDivider());
      },
    );
  }

  Widget BuildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 5),
            Text(
              model.name,
              style: const TextStyle(fontSize: 25),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1,
      ),
    );

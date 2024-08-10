import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/favorites_model.dart';
import '../shared/components/widget.dart';
import '../shared/cubit/shop_cubit.dart';
import '../shared/cubit/shop_states.dart';
import '../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // Using ConditionalBuilder to check if homeModel is not null
        return ConditionalBuilder(
          // if the state is not [ShopLoadingGetFavoritesState] mean
          // it's call the favorite of user from api build the favorite from [buildFavItem]
          condition: ShopCubit.get(context).favoritesModel != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context).favoritesModel!.data.data[index],
                context),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
            separatorBuilder: (BuildContext context, int index) => myDivider(),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  // this widget for build the favorite to user
  Widget buildFavItem(FavoriteData? model, context) => Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              // alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model!.product.image,
                  ),
                  width: 120,
                  height: 150,
                ),
                // if there discount adding this widget
                if (model.product.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: pDiscountColor,
                    child: const Text(
                      'Discount',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name product
                    Text(
                      '${model.product.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 1,
                          ),
                    ),
                    const Spacer(),
                    // price and discount
                    Row(
                      children: [
                        Text(
                          '${model.product.price!.toString()}',
                          style: Theme.of(context)
                                .textTheme
                                .bodyMedium!.copyWith(
                                  color: pColor
                                )
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // discount price
                        if (model.product.oldPrice.toString() != 0)
                          Text(
                            model.product.oldPrice.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // remove the product
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                            // print(model.id);
                          },
                          icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .favoritesProduct[model.product.id]!
                                  ? pColor
                                  : Colors.grey,
                              radius: 15,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 14,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

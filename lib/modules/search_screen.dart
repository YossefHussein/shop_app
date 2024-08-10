import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/widget.dart';
import 'package:shop_app/shared/cubit/search/search_cubit.dart';
import 'package:shop_app/shared/cubit/search/search_states.dart';

import '../models/search_model.dart';
import '../shared/cubit/shop_cubit.dart';
import '../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  formFieldWidget(
                    controller: searchController,
                    labelText: 'title',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    onSubmits: (String value) {
                      SearchCubit.get(context).search(value);
                    },
                    type: TextInputType.text,
                    prefixIcon: Icon(Icons.search),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context).model!.data!.data[index],
                            context),
                        itemCount:
                            SearchCubit.get(context).model!.data!.data.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            myDivider(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// this widget for build the favorite to user
Widget buildSearchItem(Product? model, context) => Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            // alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.image),
                width: 120,
                height: 150,
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
                    '${model.name}',
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
                      Text('${model.price!.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: pColor)),
                      const SizedBox(
                        width: 5,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // remove the product
                          ShopCubit.get(context).changeFavorites(model.id);
                          // print(model.id);
                        },
                        icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                    .favoritesProduct[model.id]!
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

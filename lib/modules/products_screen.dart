import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import '../shared/components/widget.dart';
import '../shared/styles/colors.dart';

// Defining a stateless widget for the ProductsScreen
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using BlocConsumer to listen and build UI based on ShopCubit state
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoriteState) {
          if (state.model.status == false) {
            showToast(message: state.model.message, state: ToastStates.error);
          }
          if (state.model.status == true) {
            showToast(message: state.model.message, state: ToastStates.success);
          }
        }
      },
      builder: (context, state) {
        // Using ConditionalBuilder to check if homeModel is not null
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) {
            // If homeModel is not null, build the products UI
            return productsBuilder(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!, context);
          },
          fallback: (context) {
            // If homeModel is null, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  // Function to build the products UI
  Widget productsBuilder(
    HomeModel homeModel,
    CategoriesModel categoriesModel,
    context,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel Slider for displaying banners
          CarouselSlider(
            items: homeModel.data.banners.map((e) {
              return Image.network(
                e.image,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              // when open app carousel slider is scrolling without user
              // click on the slider
              autoPlay: true,
              viewportFraction: 1.0,
              // change the image after 3
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              // this is styling of movement
              autoPlayCurve: Curves.fastOutSlowIn,
              // scroll direction is horizontal
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                // Category
                Container(
                  height: 100,
                  // width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data.data[index]),
                    itemCount: categoriesModel.data.data.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 5,
                    ),
                  ),
                ),
                const Text(
                  'New Product',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // Container for the product grid
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1 / 1.5,
              // Generating product grid items
              children: List.generate(
                homeModel.data.products.length,
                (index) =>
                    buildGridProduct(homeModel.data.products[index], context),
              ),
            ),
          )
        ],
      ),
    );
  }

  // This to build category of the product item
  Widget buildCategoryItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image.network(
          model.image,
          height: 150,
          width: 100,
          fit: BoxFit.cover,
         
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100,
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // This for function to build the grid item
  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded widget to allow image to take available space
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    model.image,
                    width: double.infinity,
                    height: double.infinity,
                    
                  ),
                  // Showing discount label if product has a discount
                  if (model.discount != 0)
                    Container(
                      color: pDiscountColor,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            ),
            // product details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Product name
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, height: 1.1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      // Product price
                      Text(
                        '${model.price.round()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.1,
                          color: pColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // Showing old price if product has a discount
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      // Favorite button
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
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
                  )
                ],
              ),
            ),
          ],
        ),
      );
}

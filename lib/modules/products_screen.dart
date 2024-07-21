import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_state.dart';
import '../shared/colors.dart';

// Defining a stateless widget for the ProductsScreen
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using BlocConsumer to listen and build UI based on ShopCubit state
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // Using ConditionalBuilder to check if homeModel is not null
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            // If homeModel is not null, build the products UI
            return productsBuilder(ShopCubit.get(context).homeModel! , ShopCubit.get(context).categoriesModel!);
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
  Widget productsBuilder(HomeModel homeModel , CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel Slider for displaying banners
          CarouselSlider(
            items: homeModel.data.banners.map((e) {
              return Image(
                image: NetworkImage(
                  '${e.image}',
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1.0,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
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
                    itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data[index]),
                    itemCount: categoriesModel.data.data.length,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
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
                homeModel!.data.products.length,
                (index) => buildGridProduct(homeModel.data.products[index]),
              ),
            ),
          )
        ],
      ),
    );
  }

  // This to build category of the product
  Widget buildCategoryItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
         Image(
          image: NetworkImage(
              model.image),
          height: 150,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100,
          child:  Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Function to build individual grid product
  Widget buildGridProduct(ProductModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded widget to allow image to take available space
            Expanded(
              child: Stack(
                children: [
                  // Product image
                  Image(
                    image: NetworkImage(
                      '${model.image}',
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  // Showing discount label if product has a discount
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
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
            // Padding for product details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Product name
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, height: 1.1),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      // Product price
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.1,
                          color: defaultColor,
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
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}

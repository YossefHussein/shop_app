// Define a class named HomeModel
class HomeModel
{
  // Declare a late-initialized boolean variable named status
  late bool status;
  // Declare a late-initialized HomeDataModel variable named data
  late HomeDataModel data;
  // Define a named constructor fromJson for HomeModel class
  HomeModel.fromJson(Map <String,dynamic> json)
  {
    // Initialize status with the value from the json map
    status=json['status'];
    // Initialize data with a HomeDataModel instance created from json map
    data=HomeDataModel.fromJson(json['data']);
  }
}

// Define a class named HomeDataModel
class HomeDataModel
{
  // Declare a list of BannerModel objects named banners, initialized as an empty list
  List<BannerModel> banners=[];
  // Declare a list of ProductModel objects named products, initialized as an empty list
  List<ProductModel> products=[];

  // Define a named constructor fromJson for HomeDataModel class
  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
    // Iterate over each element in the 'banners' list from the json map
    json['banners'].forEach((element){
      // Add a BannerModel instance created from element to the banners list
      banners.add(BannerModel.fromJson(element));
    });
    // Iterate over each element in the 'products' list from the json map
    json['products'].forEach((element){
      // Add a ProductModel instance created from element to the products list
      products.add(ProductModel.fromJson(element));
    });
  }
}

// Define a class named BannerModel
class BannerModel
{
  // Declare a late-initialized integer variable named id
  late int id;
  // Declare a nullable string variable named image
  String? image;
  // Define a named constructor fromJson for BannerModel class
  BannerModel.fromJson(Map<String,dynamic> json)
  {
    // Initialize id with the value from the json map
    id=json['id'];
    // Initialize image with the value from the json map
    image=json['image'];
  }
}

// Define a class named ProductModel
class ProductModel
{
  // Declare a late-initialized integer variable named id
  late int id;
  // Declare a dynamic variable named price
  dynamic price;
  // Declare a dynamic variable named oldPrice
  dynamic oldPrice;
  // Declare a dynamic variable named discount
  dynamic discount;
  // Declare a late-initialized string variable named image
  late String image;
  // Declare a late-initialized string variable named name
  late String name;
  // Declare a late-initialized boolean variable named favorites
  late bool favorites;
  // Declare a late-initialized boolean variable named inCart
  late bool inCart;

  // Define a named constructor fromJson for ProductModel class
  ProductModel.fromJson(Map<String,dynamic> json)
  {
    // Initialize id with the value from the json map
    id=json['id'];
    // Initialize price with the value from the json map
    price=json['price'];
    // Initialize oldPrice with the value from the json map
    oldPrice=json['old_price'];
    // Initialize discount with the value from the json map
    discount=json['discount'];
    // Initialize name with the value from the json map
    name=json['name'];
    // Initialize image with the value from the json map
    image=json['image'];
    // Initialize favorites with the value from the json map
    favorites=json['in_favorites'];
    // Initialize inCart with the value from the json map
    inCart=json['in_cart'];
  }
}

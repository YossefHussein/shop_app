// Define a class named ShopLoginModel
class ShopLoginModel {
  // This is status, used to check if there is no error from the server but the data is not accurate
  bool? status;
  // This is the message from the server if the data is not accurate
  String? message;
  // User data object
  UserData? data;

  // This is a named constructor
  ShopLoginModel.formJson(Map<String, dynamic> json) {
    // Initialize status with the value from the json map
    status = json['status'];
    // Initialize message with the value from the json map
    message = json['message'];
    // If data is not null, initialize data with a UserData instance created from json map, otherwise null
    data = json['data'] != null ? UserData.formJson(json['data']) : null;
  }
}

// Define a class named UserData
class UserData {
  // Declare nullable integer variable named id
  int? id;
  // Declare nullable string variable named name
  String? name;
  // Declare nullable string variable named email
  String? email;
  // Declare nullable string variable named phone
  String? phone;
  // Declare nullable string variable named image
  String? image;
  // Declare nullable integer variable named points
  int? points;
  // Declare nullable integer variable named credit
  int? credit;
  // Declare nullable string variable named token
  String? token;

  // Constructor with named parameters
  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  // Named constructor
  UserData.formJson(Map<String, dynamic> json) {
    // Initialize id with the value from the json map
    id = json['id'];
    // Initialize name with the value from the json map
    name = json['name'];
    // Initialize email with the value from the json map
    email = json['email'];
    // Initialize phone with the value from the json map
    phone = json['phone'];
    // Initialize image with the value from the json map
    image = json['image'];
    // Initialize points with the value from the json map
    points = json['points'];
    // Initialize credit with the value from the json map
    credit = json['credit'];
    // Initialize token with the value from the json map
    token = json['token'];
  }
}

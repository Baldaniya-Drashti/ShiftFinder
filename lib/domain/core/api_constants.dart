import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = dotenv.env['DEV_API_BASE_URL']!;
  //core
  static String registerForPush = 'register-for-push';
  static String contactSupport = 'contact/support';

  //auth
  static String register = 'register';
  static String login = 'auth/login';
  static String sendOtp = 'auth/send-otp';
  static String verifyOtp = 'auth/verify-otp';
  static String logout = 'auth/logout';

  static String getUser = 'user/info';

  //edit user
  static String updateUser = 'edit/user';
  static String editUserSendOtp = 'edit/user/send/otp';
  static String editUserVerifyOtp = 'edit/user/verify/otp';

  //products
  static String getCustomerProducts = 'customer/products';
  static String getCustomerProductsDetails = 'customer/products/view';
  static String searchProduct = 'customer/products/search';

  //cart
  static String addProductToCart = 'cart/store';
  static String removeProductFromCart = 'cart/delete';
  static String getCartList = 'cart';

  //favourite
  static String addFavourite = 'favorites/store';
  static String removeFavourite = 'favorites/delete';
  static String getFavouriteList = 'favorites';

  //shipping address
  static String getShippingAddressList = 'shipping/address';
  static String addShippingAddress = 'shipping/address/store';
  static String updateShippingAddress = 'shipping/address/edit';
  static String deleteShippingAddress = 'shipping/address/delete';

  //payment methods
  static String getPaymentMethod = 'payment/get-card';
  static String addPaymentMethod = 'payment/add-card';
  static String makeDefaultPaymentMethod = 'payment/change-default-card';

  static String deletePaymentMethod = 'payment/detach';

  //checkout
  static String orderCheckout = 'checkout';
  static String orderPlace = 'order/place';

  //order
  static String getMyOrder = 'my-order';
  static String cancelOrder = 'my-order/cancel';
  static String returnReasonList = 'return/reason/list';
  static String returnRequest = 'return/request';

  //shop
  static String getVenderDetail = 'customer/view/shop';
  static String getVenderDetailFilter = 'customer/shop/product/filter';

  //chat
  static String getChatList = 'chat/list';
  static String getChatDetailList = 'chat/details';

  //notification
  static String getNotificationList = 'notification';
  static String readNotification = 'notification/read';
  static String getReviewProduct = 'review/product';

  //review
  static String getReviews = 'reviews';
  static String giveReviews = 'review';
}

// import 'package:dartz/dartz.dart';
// import 'package:grape_customer_app/application/main/profile/my_orders/return_reson_dto.dart';
// import 'package:grape_customer_app/domain/auth/auth_value_objects.dart';
// import 'package:grape_customer_app/domain/main/main_failure.dart';
// import 'package:grape_customer_app/infrastructure/core/common_response.dart';
// import 'package:grape_customer_app/infrastructure/main/cart_dto/cart_add_dto.dart';
// import 'package:grape_customer_app/infrastructure/main/checkout_dto/checkout_dto.dart';
// import 'package:grape_customer_app/infrastructure/main/notification_dto/get_review_product_dto.dart';
// import 'package:grape_customer_app/infrastructure/main/order_detail_dto/order_detail_dto.dart';
// import 'package:grape_customer_app/infrastructure/main/payemnt_method_dto/get_cards_dto.dart';
// import 'package:grape_customer_app/infrastructure/main/shipping_address_dto/shipping_address_dto.dart';

// abstract class IMainFacade {
//   Future<Either<MainFailure, CommonResponse>> getProductListAPI({
//     required int page,
//     String productId,
//   });
//   Future<Either<MainFailure, CommonResponse>> searchProductListAPI({
//     required int page,
//     String searchText = '',
//     required List<MapEntry<String, dynamic>> selectedFilterList,
//   });
//   Future<Either<MainFailure, CommonResponse>> getProductDetailsAPI({
//     required String productId,
//     required int page,
//   });
//   Future<Either<MainFailure, CommonResponse>> getProductReviewAPI({
//     required String productId,
//     required int page,
//   });
//   Future<Either<MainFailure, CartAddDTO>> addProductToCart({
//     required String productId,
//   });
//   Future<Either<MainFailure, String>> deleteProductFromCart({
//     required String productId,
//   });

//   Future<Either<MainFailure, String>> deleteProductFromFavourite({
//     required String productId,
//   });
//   Future<Either<MainFailure, String>> addProductToFavourite({
//     required String productId,
//   });
//   Future<Either<MainFailure, CommonResponse>> getCartListAPI(
//       {required int page});
//   Future<Either<MainFailure, CommonResponse>> getChatDetailListAPI({
//     required int page,
//     required String recieverId,
//   });
//   Future<Either<MainFailure, CommonResponse>> getChatListAPI(
//       {required int page});
//   Future<Either<MainFailure, CommonResponse>> getNotificationListAPI(
//       {required int page});
//   Future<Either<MainFailure, String>> getReadNotificationAPI({
//     required String notificationId,
//   });
//   Future<Either<MainFailure, GetReviewProductDTO>> reviewNotificationAPI({
//     required String dataId,
//   });
//   Future<Either<MainFailure, CommonResponse>> getFavouriteAPI(
//       {required int page});

//   Future<Either<MainFailure, List<ShippingAddressDTO>>> getShippingAddressAPI();
//   Future<Either<MainFailure, String>> addShippingAddress({
//     required Username fullName,
//     required MobileNumber mobileNumber,
//     required String countryCode,
//     required InputEmptyOrNot address,
//     required InputEmptyOrNot landMark,
//     required InputEmptyOrNot state,
//     required InputEmptyOrNot city,
//     required PinCode pinCode,
//   });

//   Future<Either<MainFailure, String>> editShippingAddress({
//     required String id,
//     required Username fullName,
//     required MobileNumber mobileNumber,
//     required String countryCode,
//     required InputEmptyOrNot address,
//     required InputEmptyOrNot landMark,
//     required InputEmptyOrNot state,
//     required InputEmptyOrNot city,
//     required PinCode pinCode,
//   });
//   Future<Either<MainFailure, String>> deleteShippinAddress(
//       {required String id});
//   Future<Either<MainFailure, String>> deleteCard({required String id});
//   Future<Either<MainFailure, String>> makeCardDefault({required String id});

//   Future<Either<MainFailure, String>> addPaymentMethod({
//     required String paymentMethodId,
//     bool isDefault = false,
//   });
//   Future<Either<MainFailure, List<GetCardsDTO>>> getPaymentMethod();
//   Future<Either<MainFailure, List<ReturnReasonModel>>> geReasonRefundList();

//   Future<Either<MainFailure, String>> addContactSupport({
//     required InputEmptyOrNot title,
//     required InputEmptyOrNot message,
//   });

//   Future<Either<MainFailure, CommonResponse>> orderCheckoutAPI({
//     String productId,
//     String quantity,
//     bool isFromcart = false,
//     required int page,
//   });

//   Future<Either<MainFailure, String>> orderPlacetAPI({
//     required CheckoutDTO checkoutDTO,
//   });

//   Future<Either<MainFailure, CommonResponse>> getMyOrdersAPI(
//       {required int page});

//   Future<Either<MainFailure, CommonResponse>> getShopDetailAPI(
//       {required int page, required String shopID});
//   Future<Either<MainFailure, CommonResponse>> getShopDetailFilterAPI({
//     required int page,
//     required String shopID,
//     required List<MapEntry<String, dynamic>> selectedFilterList,
//   });

//   Future<Either<MainFailure, OrderDetailDTO>> getOrderDetailAPI({
//     required String orderId,
//   });

//   Future<Either<MainFailure, String>> cancelOrderAPI({required String id});

//   Future<Either<MainFailure, String>> returnRequestAPI({
//     required String orderId,
//     required String reasonId,
//     required List<String> imageList,
//     String? comment,
//   });

//   Future<Either<MainFailure, String>> giveReviewToProduct({
//     required String productId,
//     required String rating,
//     required String reviewComment,
//   });
// }

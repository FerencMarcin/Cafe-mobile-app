import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usersVoucher_model.dart';
import '../model/voucher_model.dart';
import '../service/interceptor/dioClient.dart';
import '../service/time_service.dart';

class VoucherViewModel {
  final DioClient _dioClient = Get.find();
  final TimeService _timeService = Get.put(TimeService());

  final String availableCouponsUrl = '${dotenv.env['BASE_URL']!}/coupons/status/available';
  final String usersCouponsUrl = '${dotenv.env['BASE_URL']!}/usercoupons/user';
  final String updateUsersCouponsUrl = '${dotenv.env['BASE_URL']!}/usercoupons';

  Future<List<VoucherModel>> getVouchers(String sortType) async {
    final vouchers = await _dioClient.dioClient.get(availableCouponsUrl);
    List<VoucherModel> voucherList = <VoucherModel>[];
    if(vouchers.statusCode == 200) {
      vouchers.data.forEach((voucher) {
        voucherList.add(VoucherModel.fromJSON(voucher));
      });
    } else {
      throw "Wystąpił błąd";
    }
    if (sortType == 'desc') {
      voucherList.sort((a,b) => b.pointPrice!.compareTo(a.pointPrice!));
    } else {
      voucherList.sort((a,b) => a.pointPrice!.compareTo(b.pointPrice!));
    }
    return voucherList;
  }

  Future<List<UsersVoucherModel>> getUserVouchers(String sortType, bool onlyActive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if (userId != null) {
      List<UsersVoucherModel> usersVouchersList = <UsersVoucherModel>[];
      final userVouchers = await _dioClient.dioClient.get('$usersCouponsUrl/$userId');
      if(userVouchers.statusCode == 404) {
        throw userVouchers.data['message'];
      }
      if (userVouchers.statusCode == 200){
        try {
          List<VoucherModel> coupons = await getVouchers('desc');
          userVouchers.data.forEach((userVoucher) {
            UsersVoucherModel voucher = UsersVoucherModel.fromJSON(userVoucher);
            var chosenCoupon = coupons[coupons.indexWhere((coupon) => coupon.id == voucher.CouponId)];
            voucher.couponName = chosenCoupon.couponName;
            voucher.productPrice = chosenCoupon.productPrice;
            voucher.newProductPrice = chosenCoupon.newProductPrice;
            var expirationDate = DateTime.parse(userVoucher['expiration_date']);
            final format = DateFormat('yyyy-MM-dd');
            final formattedDateTime = _timeService.convertUtcToLocalTime(format, expirationDate);
            voucher.expirationDate = formattedDateTime;
            final daysToExpiration = _timeService.daysBetween(DateTime.now(), DateTime.parse(formattedDateTime));
            if(daysToExpiration > 0) {
              voucher.daysUntilExpiration = daysToExpiration;
            } else {
              voucher.daysUntilExpiration = 0;
              voucher.UserCouponStatusId = 2;
              _dioClient.dioClient.put(
                  '$updateUsersCouponsUrl/${voucher.id}',
                  data: { 'UserCouponStatusId': 2 }
              );
            }
            if(onlyActive && voucher.UserCouponStatusId == 1) {
              usersVouchersList.add(voucher);
            } else if (!onlyActive) {
              usersVouchersList.add(voucher);
            }
          });
          if (sortType == "desc") {
            usersVouchersList.sort((a,b) => b.expirationDate!.compareTo(a.expirationDate!));
          } else {
            usersVouchersList.sort((a,b) => a.expirationDate!.compareTo(b.expirationDate!));
          }
          return usersVouchersList;
        } catch (exception) {
         throw "Wystąpił błąd";
        }
      }
      throw "Wystąpił błąd";
    } else {
      throw "Błąd podczas dodawania rezerwacji";
    }
  }

  Future<String> createUserCoupon(int couponId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if (userId != null) {
      DateTime date = DateTime.now().add(const Duration(days: 14));
      var data = {
        "UserId": userId,
        "CouponId": couponId,
        "UserCouponStatusId": 1,
        "expiration_date": date.toString()
      };
      final response = await _dioClient.dioClient.post(
        '$updateUsersCouponsUrl/', data: data,
      );
      if(response.statusCode == 404) {
        return response.data['message'];
      } else if (response.statusCode == 200){
        return "Dodano nowy kupon";
      } else {
        return "Wystąpił błąd";
      }
    } else {
      return "Błąd podczas dodawania kuponu";
    }
  }
}
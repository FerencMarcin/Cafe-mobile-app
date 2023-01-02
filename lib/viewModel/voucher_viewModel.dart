import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/voucher_model.dart';
import '../service/interceptor/dioClient.dart';

class VoucherViewModel {
  final DioClient _dioClient = Get.find();

  final String availableCouponsUrl = '${dotenv.env['BASE_URL']!}/coupons/status/available';

  Future<List<VoucherModel>> getVouchers(String sortType) async {
    final vouchers = await _dioClient.dioClient.get(availableCouponsUrl);
    List<VoucherModel> voucherList = <VoucherModel>[];
    if(vouchers.statusCode == 200) {
      vouchers.data.forEach((voucher) async {
        voucherList.add(VoucherModel.fromJSON(voucher));
      });
    }
    if (sortType == 'desc') {
      voucherList.sort((a,b) => b.pointPrice!.compareTo(a.pointPrice!));
    } else {
      voucherList.sort((a,b) => a.pointPrice!.compareTo(b.pointPrice!));
    }
    return voucherList;
  }

  Future<List<VoucherModel>> getUserVouchers(String sortType, bool onlyActive) async {
    final vouchers = await _dioClient.dioClient.get(availableCouponsUrl);
    List<VoucherModel> voucherList = <VoucherModel>[];
    if(vouchers.statusCode == 200) {
      vouchers.data.forEach((voucher) async {
        voucherList.add(VoucherModel.fromJSON(voucher));
      });
    }
    if (sortType == 'desc') {
      voucherList.sort((a,b) => b.pointPrice!.compareTo(a.pointPrice!));
    } else {
      voucherList.sort((a,b) => a.pointPrice!.compareTo(b.pointPrice!));
    }
    return voucherList;
  }

  Future<String> createUserCoupon(int couponId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if (userId != null) {
      var data = {
        "UserId": userId,
        "ReservationStatusId": 1
      };
      final response = await _dioClient.dioClient.post(
        'http://10.0.2.2:3001/', data: data,
      );
      if(response.statusCode == 404) {
        return response.data['message'];
      } else if (response.statusCode == 200){
        return "Dodano nową rezerwację";
      } else {
        return "Wystąpił błąd";
      }
    } else {
      return "Błąd podczas dodawania rezerwacji";
    }
  }
}
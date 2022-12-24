import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/voucher_model.dart';
import '../service/interceptor/dioClient.dart';

class VoucherViewModel {
  final DioClient _dioClient = Get.find();

  Future<List<VoucherModel>> getVouchers(String sortType) async {
    final vouchers = await _dioClient.dioClient.get('http://10.0.2.2:3001/coupons/status/available');
    List<VoucherModel> voucherList = <VoucherModel>[];
    if(vouchers.statusCode == 200) {
      vouchers.data.forEach((voucher) {
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

}
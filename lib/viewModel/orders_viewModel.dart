import 'package:cafe_mobile_app/model/orderHeader_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/interceptor/dioClient.dart';

class OrdersViewModel {
  final DioClient _dioClient = Get.put(DioClient());

  Future<List<OrderHeaderModel>> getUserOrders(String sortBy, String sortType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId != null) {
      final orders = await _dioClient.dioClient.get('http://10.0.2.2:3001/orderheaders/client/$userId');
      List<OrderHeaderModel> ordersList = <OrderHeaderModel>[];
      if(orders.statusCode == 200) {
        orders.data.forEach((order) {
          var orderDateTime = DateTime.parse(order['updatedAt']);
          final format = DateFormat('yyyy-MM-dd hh:mm');
          final localeDateString = format.format(orderDateTime.toLocal());
          order['updatedAt'] = localeDateString;
          ordersList.add(OrderHeaderModel.fromJSON(order));
        });
      }
      if (sortBy == "date") {
        if (sortType == 'desc') {
          ordersList.sort((a,b) => b.date!.compareTo(a.date!));
        } else {
          ordersList.sort((a,b) => a.date!.compareTo(b.date!));
        }
      } else {
        if (sortType == 'desc') {
          ordersList.sort((a,b) => b.value!.compareTo(a.value!));
        } else {
          ordersList.sort((a,b) => a.value!.compareTo(b.value!));
        }
      }
      return ordersList;
    } else {
      throw Exception('Błąd podczas pobierania zamówień');
    }
  }
}
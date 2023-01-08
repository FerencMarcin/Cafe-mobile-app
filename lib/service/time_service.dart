import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TimeService {
   late tz.Location timeZone;

   TimeService() {
     tz.initializeTimeZones();
     var warsaw = tz.getLocation('Europe/Warsaw');
     tz.setLocalLocation(warsaw);
     timeZone = warsaw;
   }

   String convertUtcToLocalTime (DateFormat format, DateTime dateTime) {
     var convertedDateTime = tz.TZDateTime.from(dateTime, timeZone);
     final formattedDateTime = format.format(convertedDateTime);
     return formattedDateTime;
   }

   int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
     return (to.difference(from).inHours / 24).round();
   }
}
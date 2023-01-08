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
}
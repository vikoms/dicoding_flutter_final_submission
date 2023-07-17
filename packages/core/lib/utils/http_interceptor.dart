import 'package:logger/logger.dart';

// class LoggingInterceptor implements InterceptorContract {
//   @override
//   Future<RequestData> interceptRequest({required RequestData data}) async {
//     print(data.toString());
//     return data;
//   }

//   @override
//   Future<ResponseData> interceptResponse({required ResponseData data}) async {
//     var logger = Logger(
//       printer: PrettyPrinter(
//           methodCount: 2, // number of method calls to be displayed
//           errorMethodCount:
//               8, // number of method calls if stacktrace is provided
//           lineLength: 120, // width of the output
//           colors: true, // Colorful log messages
//           printEmojis: true, // Print an emoji for each log message
//           printTime: false // Should each log print contain a timestamp
//           ),
//     );
//     logger.v(data.toString());
//     return data;
//   }
// }

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

Future<SecurityContext> get globalContext async {
  final sslCert =
      await rootBundle.load('certificates/tmdb_certificates_new.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createClient();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<http.Client> createClient() async {
    var httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    IOClient client = IOClient(httpClient);
    return client;
    // return InterceptedClient.build(
    //   client: client, interceptors: [],
    //   interceptors: [
    //     LoggingInterceptor(),
    //   ],
    // );
  }
}

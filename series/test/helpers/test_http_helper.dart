import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks([MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}

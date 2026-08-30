import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:deposit_calc_satelit/core/network/api_path.dart';
part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiPath.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;
}

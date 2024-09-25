import 'package:flutter_standard/network/baseUrl.dart';
import '../network/ApiServices.dart';

class HomeRepository{
  final _apiService=NetworkApiServices();

  Future<dynamic> getHomeData() async{
    dynamic response =_apiService.getApi(BaseUrl.home);
    return response;
  }

  Future<dynamic> getSlider() async{
    dynamic response =_apiService.getApi(BaseUrl.slider);
    return response;
  }
  Future<dynamic> getCategory() async{
    dynamic response =_apiService.getApiWoocommerce(BaseUrl.category);
    return response;
  }
  Future<dynamic> getCategoryPagination(String pageNo) async{
    dynamic response =_apiService.getApiWoocommerceProduct(BaseUrl.categoryPagination,pageNo);
    return response;
  }
  Future<dynamic> getProducts(String pageNo) async{
    dynamic response =_apiService.getApiWoocommerceProduct(BaseUrl.products,pageNo);
    return response;
  }
  Future<dynamic> getProductCategoryWise(String categoryId,String pageNo) async{
    dynamic response =_apiService.getApiWoocommerceProductCategory(BaseUrl.products,categoryId,pageNo,"10");
    return response;
  }

  // Future<dynamic> getProductsCategory() async{
  //   dynamic response =_apiService.postApi(BaseUrl.products);
  //   return response;
  // }
}
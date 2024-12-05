import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:ammar_responsi/network/base_network.dart';

abstract class AmiiboView{
  void showLoading();
  void hideLoading();
  void showAmiiboList(List<amiibo> amiiboList);
  void showError(String message);
}

class AmiiboPresenter {
  final AmiiboView view;
  AmiiboPresenter(this.view);
  Future<void> loadAmiiboData(String endpoint)async{
    try{
      final List<dynamic> data = await BaseNetwork.getData(endpoint);
      final amiiboList = data.map((json)=> amiibo.fromJson(json)).toList();
      view.showAmiiboList(amiiboList);
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }
}
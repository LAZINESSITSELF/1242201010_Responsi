import 'package:ammar_responsi/model/amiibo_model.dart';
import 'package:ammar_responsi/presenters/amiibo_presenter.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> implements AmiiboView {
  late AmiiboPresenter _presenter;
  bool _isLoading = false;
  List<amiibo> _amiiboList = [];
  String? _errorMessage;
  String _currentEndpoint = 'api/amiibo/';

  @override
  void initState() {
    super.initState();
    _presenter = AmiiboPresenter(this);
    _presenter.loadAmiiboData(_currentEndpoint);
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentEndpoint = endpoint;
      _presenter.loadAmiiboData(endpoint);
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAmiiboList(List<amiibo> amiiboList) {
    setState(() {
      _amiiboList = amiiboList;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amiibo List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text("Error : ${_errorMessage}"))
                    : ListView.builder(
                        itemCount: _amiiboList.length,
                        itemBuilder: (context, index) {
                          final amiibo = _amiiboList[index];
                          return ListTile(
                            leading: amiibo.image.isNotEmpty
                                ? Image.network(amiibo.image)
                                : Image.network('https://placehold.co/600x400'),
                            title: Text(amiibo.name),
                            subtitle: Text('Game Series${amiibo.gameSeries}'),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailScreen(
                              //         id: anime.id, endpoint: _currentEndpoint),
                              //   ),
                              // );
                            },
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}

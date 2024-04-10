import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/features/auth/data/datasources/data_remote_datasource.dart';

class DataNotifier extends StateNotifier<List<dynamic>> {
  final DataRemoteDataSource _dataRemoteDataSource;

  DataNotifier(this._dataRemoteDataSource) : super([]);

  Future<void> fetchData(String token) async {
    final data = await _dataRemoteDataSource.fetchData(token);
    state = [data];
  }
}

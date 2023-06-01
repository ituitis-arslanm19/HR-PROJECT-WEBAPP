// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/constant/strings.dart';
import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/reader.dart';
import '../model/reader_detail.dart';

class ReaderService {
  NetworkManager networkManager;
  ReaderService({
    required this.networkManager,
  });

  Future<List<Reader>?> getReaders() async {
    ResponseModel<List<Reader>> result =
        await networkManager.send<List<Reader>, Reader>(
            "/reader", HttpMethod.GET, Reader(), null, null);
    return result.data;
  }

  Future<ReaderDetail?> getReaderDetail(int id) async {
    ResponseModel<ReaderDetail?> result =
        await networkManager.send<ReaderDetail, ReaderDetail>(
            "/reader/popup/$id", HttpMethod.GET, ReaderDetail(), null, null);
    return result.data;
  }

  Future<ReaderDetail?> updateReader(ReaderDetail readerDetail) async {
    ResponseModel<ReaderDetail?> result =
        await networkManager.send<ReaderDetail, ReaderDetail>(
            "/reader",
            HttpMethod.PUT,
            ReaderDetail(),
            json.encode(readerDetail.toJson()),
            null);
    return result.data;
  }

  Future<ReaderDetail?> create(ReaderDetail readerDetail) async {
    ResponseModel<ReaderDetail?> result =
        await networkManager.send<ReaderDetail, ReaderDetail>(
            "/reader",
            HttpMethod.POST,
            ReaderDetail(),
            json.encode(readerDetail.toJson()),
            null);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<Reader?> result =
        await networkManager.send<Reader, Reader>(
            "/reader/$id",
            HttpMethod.DELETE,
            Reader(),
            null,
            TOKEN);
    return result.error;
}
}
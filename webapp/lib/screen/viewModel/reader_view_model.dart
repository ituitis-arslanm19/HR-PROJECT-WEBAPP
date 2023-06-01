import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/reader.dart';
import '../service/reader_service.dart';
part 'reader_view_model.g.dart';

class ReaderViewModel = _ReaderViewModelBase with _$ReaderViewModel;

abstract class _ReaderViewModelBase with Store {
  final ReaderService readerService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Reader>? readerList;

  @observable
  List<Reader>? readers;

  _ReaderViewModelBase(this.readerService);

  @action
  init() async {
    readers = await readerService.getReaders();
    readerList = readers;
    if (readerList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    readerList = readers
        ?.where((reader) =>
            reader.name!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }

  @action
  delete(int id) async {
    return await readerService.delete(id);
  }
}

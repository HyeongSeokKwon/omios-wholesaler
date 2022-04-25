import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/edit_repository.dart';
import 'package:equatable/equatable.dart';

part 'inititem_event.dart';
part 'inititem_state.dart';

class InitEditItemBloc extends Bloc<InitEditItemEvent, InitEditItemState> {
  EditRepository editRepository = EditRepository();

  InitEditItemBloc() : super(InitEditItemState.initial()) {
    on<LoadEditProductDataEvent>(fetchData);
  }

  Future<void> fetchData(
      LoadEditProductDataEvent event, Emitter<InitEditItemState> emit) async {
    emit(state.copyWith(fetchState: FetchState.loading));
    try {
      Map data = await editRepository.getSalerProductInfo(event.productId);
      Map processedData = colorDataProcessing(data);

      emit(state.copyWith(
          fetchState: FetchState.success,
          data: data,
          color: processedData['colors'],
          size: processedData['size']));
    } catch (e) {
      emit(state.copyWith(fetchState: FetchState.error));
    }
  }

  Map colorDataProcessing(Map data) {
    List colors = [];
    Set size = {};
    Map processedData = {};
    for (var value in data['colors']) {
      if (value['on_sale']) {
        colors.add(value['display_color_name']);
        for (var optionValue in value['options']) {
          if (optionValue['on_sale']) {
            size.add(optionValue['size']);
          }
        }
      }
    }

    processedData['colors'] = colors;
    processedData['size'] = size.toList();
    print(processedData);
    return processedData;
  }
}

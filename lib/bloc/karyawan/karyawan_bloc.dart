import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'karyawan_event.dart';
part 'karyawan_state.dart';

// Bloc
class KaryawanBloc extends Bloc<KaryawanEvent, KaryawanState> {
  final Dio _dio = Dio();

  KaryawanBloc() : super(KaryawanInitialState()) {
    on<FetchKaryawanEvent>((event, emit) => _mapFetchToState(event, emit));
    on<SubmitKaryawanEvent>((event, emit) => _mapSubmitToState(event, emit));
  }


  void _mapFetchToState(FetchKaryawanEvent event,
      Emitter<KaryawanState> emit) async {
    emit(KaryawanLoadingState());

    try {
      Response response = await _dio.get(
          'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile/api/karyawan/all');
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> karyawanList = List<
            Map<String, dynamic>>.from(response.data['values']);
        emit(KaryawanLoadedState(karyawanList: karyawanList));
      }
    } catch (error) {
      emit(KaryawanErrorState(errorMessage: 'Failed to fetch data'));
    }
  }

  void _mapSubmitToState(SubmitKaryawanEvent event,
      Emitter<KaryawanState> emit) async {
    emit(KaryawanLoadingState());

    try {
      final Map<String, dynamic> requestData = {
        'nik': event.nik,
        'first_name': event.firstName,
        'last_name': event.lastName,
        'alamat': event.address,
        'aktif': event.active,
      };
      final List<Map<String, dynamic>> requestDataList = [requestData];

      Response response = await _dio.post(
          'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile/karyawan/insert',
          data: requestDataList);

      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(KaryawanSuccessState(successMessage: 'Data berhasil disimpan'));
      }
    } catch (error) {
      emit(KaryawanErrorState(errorMessage: 'Failed to submit data'));
    }
  }
}

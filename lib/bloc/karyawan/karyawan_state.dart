part of 'karyawan_bloc.dart';

@immutable
abstract class KaryawanState {}

class KaryawanInitialState extends KaryawanState {}

class KaryawanLoadingState extends KaryawanState {}

class KaryawanLoadedState extends KaryawanState {
  final List<Map<String, dynamic>> karyawanList;

  KaryawanLoadedState({required this.karyawanList});
}

class KaryawanSuccessState extends KaryawanState {
  final String successMessage;

  KaryawanSuccessState({required this.successMessage});
}

class KaryawanErrorState extends KaryawanState {
  final String errorMessage;

  KaryawanErrorState({required this.errorMessage});
}


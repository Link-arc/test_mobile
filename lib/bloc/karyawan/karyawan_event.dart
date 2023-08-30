part of 'karyawan_bloc.dart';

@immutable
abstract class KaryawanEvent {}

class FetchKaryawanEvent extends KaryawanEvent {}

class SubmitKaryawanEvent extends KaryawanEvent {
  final int nik;
  final String firstName;
  final String lastName;
  final String address;
  final bool active;

  SubmitKaryawanEvent({
    required this.nik,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.active,
  });
}

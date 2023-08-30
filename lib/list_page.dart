// file: list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/bloc/karyawan/karyawan_bloc.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KaryawanBloc(),
      child: KaryawanListView(),
    );
  }
}

class KaryawanListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final karyawanBloc = BlocProvider.of<KaryawanBloc>(context);
    karyawanBloc.add(FetchKaryawanEvent());

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('List Karyawan'))),
      body: BlocBuilder<KaryawanBloc, KaryawanState>(
        builder: (context, state) {
          if (state is KaryawanLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is KaryawanLoadedState) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('NIK')),
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Aktif')),
                    DataColumn(label: Text('Alamat')),
                  ],
                  rows: state.karyawanList.map<DataRow>((karyawan) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(karyawan['nik'].toString())),
                        DataCell(Text('${karyawan['first_name']} ${karyawan['last_name']}')),
                        DataCell(
                          Container(
                            height: 35,
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: karyawan['aktif'] ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                karyawan['aktif'] ? 'Ya' : 'Tidak',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(karyawan['alamat'])),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          } else if (state is KaryawanErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form'); // Mengarahkan ke halaman Form
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

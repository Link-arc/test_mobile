import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/bloc/karyawan/karyawan_bloc.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final KaryawanBloc _karyawanBloc = KaryawanBloc();
  TextEditingController nikController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isActive = false;
  bool isSubmitting = false;

  @override
  void dispose() {
    _karyawanBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Karyawan')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isSubmitting
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextField(
                        controller: nikController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'NIK')),
                    TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(labelText: 'First Name')),
                    TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(labelText: 'Last Name')),
                    TextField(
                        controller: addressController,
                        decoration: InputDecoration(labelText: 'Address')),
                    CheckboxListTile(
                      title: Text('Active'),
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value ?? false;
                        });
                      },
                    ),
                    ElevatedButton(onPressed: onSubmit, child: buttonSubmit()),
                  ],
                ),
              ),
      ),
    );
  }

  onSubmit() {
    isSubmitting = true;
    final int nik = int.parse(nikController.text);
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String address = addressController.text;
    final bool active = isActive;

    if (nik <= 0 || firstName.isEmpty || lastName.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Semua field harus diisi')));
    } else {
      print('lop');
      final submitEvent = SubmitKaryawanEvent(
        nik: nik,
        firstName: firstName,
        lastName: lastName,
        address: address,
        active: isActive,
      );
      BlocProvider.of<KaryawanBloc>(context).add(submitEvent);
    }
  }

  buttonSubmit() {
    return BlocBuilder<KaryawanBloc, KaryawanState>(
      builder: (context, state) {
        if (state is KaryawanSuccessState) {
          isSubmitting = false;
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/list');
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Berhasil menyimpan data.')));
          });
          Navigator.pop(context);
          return Text('Simpan');
        } else if (state is KaryawanErrorState) {
          isSubmitting = false;
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          });
          return Text('Simpan');
        } else {
          return Text('Simpan');
        }
      },
    );
  }
}

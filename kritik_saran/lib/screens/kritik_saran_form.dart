import 'package:flutter/material.dart';

class KritikSaranForm extends StatefulWidget {
  const KritikSaranForm({Key? key}) : super(key: key);

  @override
  _KritikSaranFormState createState() => _KritikSaranFormState();
}

class _KritikSaranFormState extends State<KritikSaranForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerKritikSaran = TextEditingController();
  String result1 = "";
  String result2 = "";

  void kirimData() {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Nama : ${controllerNama.text}", textAlign: TextAlign.left),
            Text("Kritik dan Saran : ${controllerKritikSaran.text}",
                textAlign: TextAlign.justify),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Kritik dan Saran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masukan Anda sangat bermanfaat bagi kami.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              // TextField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerNama,
                  decoration: InputDecoration(
                    hintText: "Masukkan nama Anda (boleh nama samaran)",
                    labelText: "Nama",
                    icon: const Icon(Icons.people),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String str) {
                    setState(() {
                      result1 = str;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerKritikSaran,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Masukkan kritik dan saran",
                    labelText: "Kritik dan Saran",
                    icon: const Icon(Icons.message),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String str) {
                    setState(() {
                      result2 = str;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kritik dan saran tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    kirimData();
                    controllerNama.clear();
                    controllerKritikSaran.clear();
                  }
                },
              ),
              const SizedBox(height: 8),
              const Text("Penerapan onChanged"),
              Text(result1),
              Text(result2),
            ],
          ),
        ),
      ),
    );
  }
}

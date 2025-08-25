import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfGorev = TextEditingController();
  var tfGorevAciklama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text(
          "Görev Kaydet",
          style: TextStyle(
            color: Color(0xFFF2F2F2),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF435773),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFF2F2F2),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 100,
                ),
                child: TextField(
                  controller: tfGorev,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Görev",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300,
                ),
                child: TextField(
                  controller: tfGorevAciklama,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Görev Açıklama",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF435773),
                  foregroundColor: const Color(0xFFF2F2F2),
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  if (tfGorev.text.isNotEmpty) {
                    context.read<KayitSayfaCubit>().kaydet(
                      tfGorev.text,
                      tfGorevAciklama.text,
                    );
                    tfGorev.clear();
                    tfGorevAciklama.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Görev kaydedildi")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Görev adı boş olamaz")),
                    );
                  }
                },
                child: const Text("KAYDET"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:is_listesi/data/entity/gorevler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  final Gorevler gorev;
  const DetaySayfa({required this.gorev});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfGorev = TextEditingController();
  var tfGorevAciklama = TextEditingController();

  @override
  void initState() {
    super.initState();
    tfGorev.text = widget.gorev.gorev;
    tfGorevAciklama.text = widget.gorev.gorev_aciklama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text(
          "Görev Düzenleme",
          style: TextStyle(
            color: Color(0xFFF2F2F2),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF435773),
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
                  minLines: 1,
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
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Görev açıklaması",
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
                  context.read<DetaySayfaCubit>().guncelle(
                    widget.gorev.gorev_id,
                    tfGorev.text,
                    tfGorevAciklama.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text("KAYDET",),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


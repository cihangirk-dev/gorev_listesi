import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:is_listesi/data/entity/gorevler.dart';
import 'package:is_listesi/ui/cubit/anasayfa_cubit.dart';
import 'package:is_listesi/ui/views/detay_sayfa.dart';
import 'package:is_listesi/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().gorevleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFF435773),
        title: aramaYapiliyorMu
            ? TextField(
                style: const TextStyle(color: Color(0xFFF9F9F9)),
                decoration: const InputDecoration(
                  hintText: "Ara",
                  hintStyle: TextStyle(color: Color(0xFFF9F9F9)),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (aramaSonucu) {
                  context.read<AnasayfaCubit>().ara(aramaSonucu);
                },
              )
            : const Text(
                "Görevler",
                style: TextStyle(
                  color: Color(0xFFF9F9F9),
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                    context.read<AnasayfaCubit>().gorevleriYukle();
                  },
                  icon: Icon(Icons.clear, color: Color(0xFFF9F9F9)),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: Icon(Icons.search, color: Color(0xFFF9F9F9)),
                ),
        ],
        centerTitle: true,
      ),
      body: BlocBuilder<AnasayfaCubit, List<Gorevler>>(
        builder: (context, gorevlerListesi) {
          if (gorevlerListesi.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 70),
              itemCount: gorevlerListesi.length,
              itemBuilder: (context, index) {
                var gorev = gorevlerListesi[index];
                return Slidable(
                  key: ValueKey(gorev.gorev_id),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await context.read<AnasayfaCubit>().sil(
                            gorev.gorev_id,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${gorev.gorev} silindi")),
                          );
                        },
                        backgroundColor: Color(0xFFB71C1C),
                        foregroundColor: Color(0xFFF9F9F9),
                        icon: Icons.delete,
                        label: "Sil",
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetaySayfa(gorev: gorev),
                        ),
                      ).then((value) {
                        context.read<AnasayfaCubit>().gorevleriYukle();
                      });
                    },
                    onLongPressStart: (details) async {
                      final selected = await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                          MediaQuery.of(context).size.width -
                              details.globalPosition.dx,
                          MediaQuery.of(context).size.width -
                              details.globalPosition.dy,
                        ),
                        items: [
                          PopupMenuItem(
                            value: "edit",
                            child: Row(
                              children: const [
                                Icon(Icons.edit, color: Colors.blue),
                                SizedBox(width: 8),
                                Text("Düzenle"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: "delete",
                            child: Row(
                              children: const [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text("Sil"),
                              ],
                            ),
                          ),
                        ],
                      );
                      if (selected == "edit") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetaySayfa(gorev: gorev),
                          ),
                        ).then((value) {
                          context.read<AnasayfaCubit>().gorevleriYukle();
                        });
                      } else if (selected == "delete") {
                        await context.read<AnasayfaCubit>().sil(gorev.gorev_id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${gorev.gorev} silindi")),
                        );
                      }
                    },
                    child: Card(
                      elevation: 4,
                      color: gorev.yapildi_mi == 1
                          ? const Color(0xFF6FBF70)
                          : const Color(0xFFBF7373),
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gorev.gorev,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFF2F2F2),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      gorev.gorev_aciklama,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<AnasayfaCubit>()
                                        .yapildiMiToggla(gorev);
                                  },
                                  icon: Icon(
                                    gorev.yapildi_mi == 1
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: gorev.yapildi_mi == 1
                                        ? Color(0xFFF2F2F2)
                                        : Color(0xFFF2F2F2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: SizedBox(width: 70,height: 70,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF435773),
          child: const Icon(Icons.add, color: Color(0xFFF2F2F2)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KayitSayfa()),
            ).then((value) {
              context.read<AnasayfaCubit>().gorevleriYukle();
            });
          },
        ),
      ),
    );
  }
}

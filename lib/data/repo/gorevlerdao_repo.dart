import 'package:is_listesi/data/entity/gorevler.dart';
import 'package:is_listesi/sqlite/veritabani_yardimcisi.dart';

class GorevlerDaoRepo {
  Future<List<Gorevler>> gorevleriYukle() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM gorevler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Gorevler(gorev_id: satir["gorev_id"],
          gorev: satir["gorev"],
          gorev_aciklama: satir["gorev_aciklama"] ?? "",
        yapildi_mi: satir["yapildi_mi"] ?? 0,
      );
    });
  }
  Future<List<Gorevler>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM gorevler WHERE gorev like '%$aramaKelimesi%'");

    return List.generate(maps.length, (i){
      var satir = maps[i];
      return Gorevler(gorev_id: satir["gorev_id"],
          gorev: satir["gorev"],
          gorev_aciklama: satir["gorev_aciklama"] ?? "",
        yapildi_mi: satir["yapildi_mi"] ?? 0,
      );
    });
  }
  Future<void> kaydet(String gorev, String gorev_aciklama)async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniGorev = Map<String,dynamic>();
    yeniGorev["gorev"] = gorev;
    yeniGorev["gorev_aciklama"] = gorev_aciklama;
    await db.insert("gorevler", yeniGorev);
  }
  Future<void> guncelle(int gorev_id, String gorev, String gorev_aciklama)async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenenGorev = Map<String,dynamic>();
    guncellenenGorev["gorev"] = gorev;
    guncellenenGorev["gorev_aciklama"] = gorev_aciklama;
    await db.update("gorevler", guncellenenGorev,where: "gorev_id = ?",whereArgs: [gorev_id]);
  }
  Future<void> sil(int gorev_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("gorevler",where: "gorev_id = ?",whereArgs: [gorev_id]);
  }
  Future<void> yapildiMiDegistir(int gorev_id, int yeniDeger) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.update(
      "gorevler",
      {"yapildi_mi": yeniDeger},
      where: "gorev_id = ?",
      whereArgs: [gorev_id],
    );
  }
}
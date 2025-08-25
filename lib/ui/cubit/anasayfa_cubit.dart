import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_listesi/data/entity/gorevler.dart';
import 'package:is_listesi/data/repo/gorevlerdao_repo.dart';

class AnasayfaCubit extends Cubit<List<Gorevler>>{
  AnasayfaCubit():super(<Gorevler>[]);

  var krepo = GorevlerDaoRepo();
  Future<void> gorevleriYukle()async{
    var list = await krepo.gorevleriYukle();
    emit(list);
  }

  Future<void> ara(String aramaKelimesi)async{
    var list = await krepo.ara(aramaKelimesi);
    emit(list);
  }
  Future<void> sil(int gorev_id) async {
    await krepo.sil(gorev_id);
    await gorevleriYukle();
  }
  Future<void> yapildiMiToggla(Gorevler gorev) async {
    int yeniDeger = gorev.yapildi_mi == 0 ? 1 : 0;
    await krepo.yapildiMiDegistir(gorev.gorev_id, yeniDeger);
    await gorevleriYukle();
  }
}
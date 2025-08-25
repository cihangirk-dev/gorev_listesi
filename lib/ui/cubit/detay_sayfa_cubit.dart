import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_listesi/data/repo/gorevlerdao_repo.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit():super(0);

  var krepo = GorevlerDaoRepo();

  Future<void> guncelle(int gorev_id, String gorev, String groev_aciklama)async {
    await krepo.guncelle(gorev_id, gorev, groev_aciklama);
  }
}
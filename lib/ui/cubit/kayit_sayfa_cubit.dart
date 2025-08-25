import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_listesi/data/repo/gorevlerdao_repo.dart';


class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit():super(0);

  var krepo = GorevlerDaoRepo();
  Future<void> kaydet(String gorev, String gorev_aciklama)async {
    await krepo.kaydet(gorev, gorev_aciklama);
  }
}
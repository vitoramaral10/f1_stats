import 'dart:developer';

import 'package:f1_stats/domain/entities/season_entity.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxSeasonsPresenter extends GetxController implements SeasonsPresenter {
  final LoadSeasons loadSeasons;

  GetxSeasonsPresenter({required this.loadSeasons});

  final _seasons = Rx<List<SeasonEntity>>(<SeasonEntity>[]);

  @override
  List<SeasonEntity> get seasons => _seasons.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllSeasons();
  }

  @override
  Future<void> getAllSeasons() async {
    try {
      _seasons.value = await loadSeasons.call();
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSeasonsPresenter.getAllSeasons');
      _seasons.value = <SeasonEntity>[];
    }
  }
}

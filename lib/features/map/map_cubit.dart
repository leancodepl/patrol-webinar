import 'package:fts/data/contracts/contracts.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_cubit_utils_cqrs/leancode_cubit_utils_cqrs.dart';
import 'package:logging/logging.dart';

final _logger = Logger('MapCubit');

class MapCubit extends QueryCubit<List<SiteDTO>, MapState> {
  MapCubit(this._cqrs) : super('MapCubit');

  final Cqrs _cqrs;

  @override
  MapState map(List<SiteDTO> data) => MapState(
    sites: data,
    categories: data.map((e) => e.category).toSet().toList(),
  );

  @override
  Future<QueryResult<List<SiteDTO>>> request() async {
    _logger.info('Requesting AllSites...');
    final result = await _cqrs.get(AllSites());
    switch (result) {
      case QuerySuccess(:final data):
        _logger.info(
          'AllSites returned ${data.length} sites: '
          '${data.map((s) => '${s.name} (${s.category})').join(', ')}',
        );
      case QueryFailure(:final error):
        _logger.warning('AllSites failed: $error');
    }
    return result;
  }

  @override
  void emit(RequestState<MapState, QueryError> state) {
    // Prevent state emission if cubit is closed
    if (isClosed) {
      return;
    }
    super.emit(state);
  }
}

final class MapState with EquatableMixin {
  const MapState({required this.sites, required this.categories});

  final List<SiteDTO> sites;
  final List<SiteCategoryDTO> categories;

  @override
  List<Object?> get props => [sites, categories];
}

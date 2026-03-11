import '../../core/constants/app_constants.dart';
import '../models/template_item.dart';
import '../sources/template_local_source.dart';
import '../sources/template_remote_source.dart';

class TemplateRepository {
  final TemplateRemoteSource remoteSource;
  final TemplateLocalSource localSource;

  TemplateRepository({required this.remoteSource, required this.localSource});

  Future<List<TemplateItem>> fetchRemotePage(int offset) {
    return remoteSource.fetchTemplates(offset: offset, limit: AppConstants.pageSize);
  }

  Future<void> cacheTemplates(List<TemplateItem> items) {
    final deduped = {
      for (final item in items) item.id: item,
    }.values.toList();
    return localSource.upsertTemplates(deduped);
  }

  Future<List<TemplateItem>> getLocalPage(int offset) {
    return localSource.getTemplates(offset: offset, limit: AppConstants.pageSize);
  }
}

sealed class TaskFilter {}

class AllTasksFilter extends TaskFilter {}

class CategoryFilter extends TaskFilter {
  final int categoryId;
  final String categoryName;
  final String categoryColor;

  CategoryFilter({
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  });
}

class FolderFilter extends TaskFilter {
  final int folderId;
  final String folderName;

  FolderFilter({
    required this.folderId,
    required this.folderName,
  });
}

class RecentlyDeletedFilter extends TaskFilter {}

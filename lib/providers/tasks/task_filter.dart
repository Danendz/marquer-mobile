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

class RecentlyDeletedFilter extends TaskFilter {}

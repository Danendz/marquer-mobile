class UpsertTaskFolderRequest {
  final String name;

  UpsertTaskFolderRequest({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

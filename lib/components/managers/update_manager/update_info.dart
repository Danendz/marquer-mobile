class UpdateInfo {
  final String downloadUrl;
  final String? changelog;
  final String? versionFull;

  const UpdateInfo({
    required this.downloadUrl,
    this.changelog,
    this.versionFull,
  });
}

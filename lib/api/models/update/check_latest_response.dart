class CheckLatestResponse {
  final String version;
  final String? versionFull;
  final String downloadUrl;
  final String? changelog;

  CheckLatestResponse({
    required this.version,
    this.versionFull,
    required this.downloadUrl,
    this.changelog,
  });

  factory CheckLatestResponse.fromJson(Map<String, dynamic> json) => CheckLatestResponse(
    version: json['version'] as String,
    versionFull: json['version_full'] as String?,
    downloadUrl: json['download_url'] as String,
    changelog: json['changelog'] as String?,
  );
}

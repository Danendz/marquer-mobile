class CheckLatestResponse {
  final String version;
  final String downloadUrl;

  CheckLatestResponse({
    required this.version,
    required this.downloadUrl,
  });

  factory CheckLatestResponse.fromJson(Map<String, dynamic> json) => CheckLatestResponse(
    version: json['version'] as String,
    downloadUrl: json['download_url'] as String,
  );
}

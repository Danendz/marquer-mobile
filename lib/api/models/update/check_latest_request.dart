class CheckLatestRequest {
  final String platform;
  final String channel;

  CheckLatestRequest({
    required this.platform,
    required this.channel,
  });

  Map<String, dynamic> toJson() => {
    'platform': platform,
    'channel': channel,
  };
}

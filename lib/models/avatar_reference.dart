class AvatarReference {
  AvatarReference(this.downloadUrl);
  final String downloadUrl;

  factory AvatarReference.fromMap(Map<String, dynamic> data) {
    String downloadUrl = '';
    if (data.isNotEmpty) {
      downloadUrl = data['downloadUrl'];
      return AvatarReference(downloadUrl);
    }
    return AvatarReference(downloadUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'downloadUrl': downloadUrl,
    };
  }
}

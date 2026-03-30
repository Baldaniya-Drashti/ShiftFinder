class UploadMediaResponse {
  String? media;
  String? thumbnail;

  UploadMediaResponse({this.media, this.thumbnail});

  UploadMediaResponse.fromJson(Map<String, dynamic> json) {
    media = json['media'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media'] = media;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

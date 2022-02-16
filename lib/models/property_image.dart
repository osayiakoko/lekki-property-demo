
class PropertyImage {
  String fieldname;
  String originalname;
  String encoding;
  String mimetype;
  String path;
  int size;
  String filename;

  PropertyImage({
    required this.fieldname,
    required this.originalname,
    required this.encoding,
    required this.mimetype,
    required this.path,
    required this.size,
    required this.filename,
  });

  PropertyImage copyWith({
    String? fieldname,
    String? originalname,
    String? encoding,
    String? mimetype,
    String? path,
    int? size,
    String? filename,
  }) {
    return PropertyImage(
      fieldname: fieldname ?? this.fieldname,
      originalname: originalname ?? this.originalname,
      encoding: encoding ?? this.encoding,
      mimetype: mimetype ?? this.mimetype,
      path: path ?? this.path,
      size: size ?? this.size,
      filename: filename ?? this.filename,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldname': fieldname,
      'originalname': originalname,
      'encoding': encoding,
      'mimetype': mimetype,
      'path': path,
      'size': size,
      'filename': filename,
    };
  }

  factory PropertyImage.fromJson(Map<String, dynamic> json) {
    return PropertyImage(
      fieldname: json['fieldname'] ?? '',
      originalname: json['originalname'] ?? '',
      encoding: json['encoding'] ?? '',
      mimetype: json['mimetype'] ?? '',
      path: json['path'] ?? '',
      size: json['size']?.toInt() ?? 0,
      filename: json['filename'] ?? '',
    );
  }

  @override
  String toString() {
    return originalname;
  }
}

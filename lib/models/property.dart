
import 'package:lekki_proj_demo/models/property_image.dart';
import 'package:lekki_proj_demo/utils/helpers.dart';

class Property {
  String? id;
  String address;
  String type;
  int bedroom;
  int sittingRoom;
  int kitchen;
  int bathroom;
  int toilet;
  String propertyOwner;
  String description;
  DateTime validFrom;
  DateTime validTo;
  List<PropertyImage> images;
  DateTime? createdAt;
  DateTime? updatedAt;

  Property({
    this.id,
    required this.address,
    required this.type,
    required this.bedroom,
    required this.sittingRoom,
    required this.kitchen,
    required this.bathroom,
    required this.toilet,
    required this.propertyOwner,
    required this.description,
    required this.validFrom,
    required this.validTo,
    required this.images,
    this.createdAt,
    this.updatedAt,
  });

  Property copyWith({
    String? id,
    String? address,
    String? type,
    int? bedroom,
    int? sittingRoom,
    int? kitchen,
    int? bathroom,
    int? toilet,
    String? propertyOwner,
    String? description,
    DateTime? validFrom,
    DateTime? validTo,
    List<PropertyImage>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Property(
      id: id ?? this.id,
      address: address ?? this.address,
      type: type ?? this.type,
      bedroom: bedroom ?? this.bedroom,
      sittingRoom: sittingRoom ?? this.sittingRoom,
      kitchen: kitchen ?? this.kitchen,
      bathroom: bathroom ?? this.bathroom,
      toilet: toilet ?? this.toilet,
      propertyOwner: propertyOwner ?? this.propertyOwner,
      description: description ?? this.description,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'type': type,
      'bedroom': bedroom,
      'sittingRoom': sittingRoom,
      'kitchen': kitchen,
      'bathroom': bathroom,
      'toilet': toilet,
      'propertyOwner': propertyOwner,
      'description': description,
      'validFrom': validFrom.toIso8601String(),
      'validTo': validTo.toIso8601String(),
      'images': images.map((x) => x.toJson()).toList(),
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'] ?? '',
      address: json['address'] ?? '',
      type: json['type'] ?? '',
      bedroom: json['bedroom']?.toInt() ?? 0,
      sittingRoom: json['sittingRoom']?.toInt() ?? 0,
      kitchen: json['kitchen']?.toInt() ?? 0,
      bathroom: json['bathroom']?.toInt() ?? 0,
      toilet: json['toilet']?.toInt() ?? 0,
      propertyOwner: json['propertyOwner'] ?? '',
      description: json['description'] ?? '',
      validFrom: parseDynamicDate(json['validFrom']),
      validTo: parseDynamicDate(json['validTo']),
      images: List<PropertyImage>.from(json['images']?.map((x) => PropertyImage.fromJson(x))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'Property(id: $id, type: $type, address: $address, bedroom: $bedroom,  propertyOwner: $propertyOwner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Property &&
      other.id == id;
  }
}

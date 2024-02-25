enum SensorType {
  vibration,
  energy
}

enum Status {
  operating,
  alert
}

class Asset {
  final String name;
  final String id;
  final String? locationId;
  final String? parentId;
  final SensorType? sensorType;
  final Status? status;

  Asset({
    required this.name,
    required this.id,
    required this.locationId,
    required this.parentId,
    required this.sensorType,
    required this.status,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    final sensorType = switch(json['sensorType']) {
      'vibration' => SensorType.vibration,
      'energy' => SensorType.energy,
      _ => null,
    };

    final status = switch(json['status']) {
      'operating' => Status.operating,
      'alert' => Status.alert,
      _ => null,
    };

    return Asset(
      name: json['name'],
      id: json['id'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: sensorType,
      status: status,
    );
  }
}

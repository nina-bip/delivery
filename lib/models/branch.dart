class Branch {
  const Branch({
    required this.id,
    required this.name,
    required this.wilayaId,
    required this.wilayaName,
    required this.cityLabel,
    required this.address,
    required this.hours,
    required this.contactPhone,
  });

  final String id;
  final String name;
  final String wilayaId;
  final String wilayaName;
  final String cityLabel;
  final String address;
  final String hours;
  final String contactPhone;
}

class Wilaya {
  const Wilaya({required this.id, required this.name});

  final String id;
  final String name;
}

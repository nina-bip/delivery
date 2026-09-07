import '../models/branch.dart';

/// Public branch directory only. Branch emails live on the backend.
abstract final class BranchData {
  static const wilayas = <Wilaya>[
    Wilaya(id: 'algiers', name: 'Algiers'),
    Wilaya(id: 'constantine', name: 'Constantine'),
    Wilaya(id: 'oran', name: 'Oran'),
    Wilaya(id: 'annaba', name: 'Annaba'),
  ];

  static const branches = <Branch>[
    Branch(
      id: 'alg-01',
      name: 'Algiers — Hydra',
      wilayaId: 'algiers',
      wilayaName: 'Algiers',
      cityLabel: 'Hydra',
      address: 'Hydra, Algiers',
      hours: '11:00 – 23:00',
      contactPhone: '023 00 00 01',
    ),
    Branch(
      id: 'alg-02',
      name: 'Algiers — Bab Ezzouar',
      wilayaId: 'algiers',
      wilayaName: 'Algiers',
      cityLabel: 'Bab Ezzouar',
      address: 'Bab Ezzouar, Algiers',
      hours: '11:00 – 23:30',
      contactPhone: '023 00 00 02',
    ),
    Branch(
      id: 'cst-01',
      name: 'Constantine Branch',
      wilayaId: 'constantine',
      wilayaName: 'Constantine',
      cityLabel: 'Constantine',
      address: 'Centre-ville, Constantine',
      hours: '11:00 – 23:00',
      contactPhone: '031 00 00 01',
    ),
    Branch(
      id: 'orn-01',
      name: 'Oran Branch',
      wilayaId: 'oran',
      wilayaName: 'Oran',
      cityLabel: 'Oran',
      address: 'Centre-ville, Oran',
      hours: '11:00 – 23:00',
      contactPhone: '041 00 00 01',
    ),
    Branch(
      id: 'anb-01',
      name: 'Annaba Branch',
      wilayaId: 'annaba',
      wilayaName: 'Annaba',
      cityLabel: 'Annaba',
      address: 'Centre-ville, Annaba',
      hours: '11:00 – 23:00',
      contactPhone: '038 00 00 01',
    ),
  ];
}

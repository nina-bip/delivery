import '../data/branch_data.dart';
import '../models/branch.dart';

class BranchService {
  const BranchService();

  List<Wilaya> wilayas() => BranchData.wilayas;

  List<Branch> allBranches() => BranchData.branches;

  List<Branch> branchesForWilaya(String wilayaId) {
    return BranchData.branches.where((b) => b.wilayaId == wilayaId).toList();
  }

  Branch? resolve({required String wilayaId, String? branchId}) {
    final matches = branchesForWilaya(wilayaId);
    if (matches.isEmpty) return null;
    if (matches.length == 1) return matches.first;
    if (branchId == null) return null;
    for (final branch in matches) {
      if (branch.id == branchId) return branch;
    }
    return null;
  }
}

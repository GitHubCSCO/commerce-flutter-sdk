import 'package:optimizely_commerce_api/src/models/models.dart';

extension SessionExtension on Session {
  bool get isRequisitioner {
    if (userRoles != null && userRoles!.isNotEmpty) {
      List<String> roles = userRoles!.split(",");
      return roles.any((role) => role.trim().toLowerCase() == "requisitioner");
    }

    return false;
  }

  bool get isVMIUser {
    if (userRoles != null && userRoles!.isNotEmpty) {
      List<String> roles = userRoles!.split(",");
      return roles.any(
        (role) =>
            role.trim().toLowerCase() == "vmi_admin" ||
            role.trim().toLowerCase() == "vmi_user",
      );
    }

    return false;
  }

  bool get isOrderApprovalApplicableUser {
    if (userRoles != null && userRoles!.isNotEmpty) {
      List<String> roles = userRoles!.split(",");
      return roles.any(
        (role) =>
            role.trim().toLowerCase() == "administrator" ||
            role.trim().toLowerCase() == "buyer1" ||
            role.trim().toLowerCase() == "buyer2" ||
            role.trim().toLowerCase() == "buyer3",
      );
    }

    return false;
  }
}

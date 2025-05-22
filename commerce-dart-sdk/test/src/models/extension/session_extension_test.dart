import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('SessionExtension', () {
    test('isRequisitioner', () {
      // User roles containing "requisitioner"
      final session1 = Session(userRoles: 'requisitioner, buyer');
      expect(session1.isRequisitioner, true);

      // User roles not containing "requisitioner"
      final session2 = Session(userRoles: 'buyer');
      expect(session2.isRequisitioner, false);

      // Null user roles
      final session3 = Session(userRoles: null);
      expect(session3.isRequisitioner, false);
    });

    test('isVMIUser', () {
      // User roles containing "vmi_admin"
      final session1 = Session(userRoles: 'vmi_admin, buyer');
      expect(session1.isVMIUser, true);

      // User roles containing "vmi_user"
      final session2 = Session(userRoles: 'buyer, vmi_user');
      expect(session2.isVMIUser, true);

      // User roles not containing "vmi_admin" or "vmi_user"
      final session3 = Session(userRoles: 'buyer');
      expect(session3.isVMIUser, false);

      // Null user roles
      final session4 = Session(userRoles: null);
      expect(session4.isVMIUser, false);
    });

    test('isOrderApprovalApplicableUser', () {
      // User roles containing "administrator"
      final session1 = Session(userRoles: 'administrator, buyer');
      expect(session1.isOrderApprovalApplicableUser, true);

      // User roles containing "buyer1"
      final session2 = Session(userRoles: 'buyer1, buyer2');
      expect(session2.isOrderApprovalApplicableUser, true);

      // User roles containing "buyer2"
      final session3 = Session(userRoles: 'buyer3, buyer2');
      expect(session3.isOrderApprovalApplicableUser, true);

      // User roles containing "buyer3"
      final session4 = Session(userRoles: 'buyer, buyer3');
      expect(session4.isOrderApprovalApplicableUser, true);

      // User roles not containing applicable roles
      final session5 = Session(userRoles: 'vmi_admin');
      expect(session5.isOrderApprovalApplicableUser, false);

      // Null user roles
      final session6 = Session(userRoles: null);
      expect(session6.isOrderApprovalApplicableUser, false);
    });
  });
}

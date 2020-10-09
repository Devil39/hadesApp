import 'package:auto_route/auto_route_annotations.dart';

import '../screens_new/auth/login_page.dart';
import '../screens_new/auth/signup_page.dart';
import '../screens_new/base_page.dart';
import '../screens_new/event/create_event_page.dart';
import '../screens_new/export/export_option_list_page.dart';
import '../screens_new/export/export_page.dart';
import '../screens_new/initialUserSetup/create_org_page.dart';
import '../screens_new/initialUserSetup/get_organization_page.dart';
import '../screens_new/initialUserSetup/join_org_detail_page.dart';
import '../screens_new/initialUserSetup/join_org_list_page.dart';
import '../screens_new/intermediate_login_page.dart';
import '../screens_new/mailing/mail_page.dart';
import '../screens_new/mailing/mailing_options_list_page.dart';
import '../screens_new/participants_management/attendance/attendance_day_select_page.dart';
import '../screens_new/participants_management/attendance/attendance_option_list_page.dart';
import '../screens_new/participants_management/attendance/attendance_page.dart';
import '../screens_new/participants_management/coupons/coupon_create_page.dart';
import '../screens_new/participants_management/coupons/coupons_list_page.dart';
import '../screens_new/participants_management/coupons/coupons_option_list_page.dart';
import '../screens_new/participants_management/coupons/redeem_coupon_page.dart';
import '../screens_new/participants_management/participant_crud/participant_create_edit_page.dart';
import '../screens_new/participants_management/participant_crud/participant_crud_option_list_page.dart';
import '../screens_new/participants_management/participant_crud/participant_list_page.dart';
import '../screens_new/splash_page.dart';
import '../screens_new/onboarding/onboarding.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashPage splashPage;

  SignUpPage signUpPage;
  LoginPage loginPage;
  JoinOrgListPage joinOrgListPage;
  GetOrganizationPage getOrganizationPage;
  CreateOrgPage createOrgPage;
  BasePage homePage;
  JoinOrgDetailPage orgDetailPage;
  CreateEventPage createEventPage;
  IntermediateLoginPage intermediateOrgLogin;
  MailingOptionsListPage mailingOptionsListPage;
  MailPage mailPage; 
  AttendanceOptionListPage attendanceOptionListPage;
  AttendancePage attendancePage;
  AttendanceDaySelectPage attendanceDaySelectPage;
  CouponListPage couponListPage;
  CouponsOptionListPage couponsOptionListPage;
  CreateCouponPage createCouponPage;
  RedeemCouponPage redeemCouponPage;
  ParticipantListPage participantListPage;
  ParticipantCreateEditPage participantCreateEditPage;
  ParticipantCRUDOptionListPage participantCRUDOptionListPage;
  ExportOptionListPage exportOptionListPage;
  ExportPage exportPage;
  OnBoardingScreen onBoardingScreen;
}

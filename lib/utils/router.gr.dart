// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hades_app/screens_new/splash_page.dart';
import 'package:hades_app/screens_new/auth/signup_page.dart';
import 'package:hades_app/screens_new/auth/login_page.dart';
import 'package:hades_app/screens_new/initialUserSetup/join_org_list_page.dart';
import 'package:hades_app/screens_new/initialUserSetup/get_organization_page.dart';
import 'package:hades_app/screens_new/initialUserSetup/create_org_page.dart';
import 'package:hades_app/screens_new/base_page.dart';
import 'package:hades_app/screens_new/initialUserSetup/join_org_detail_page.dart';
import 'package:hades_app/models/organization.dart';
import 'package:hades_app/screens_new/event/create_event_page.dart';
import 'package:hades_app/screens_new/intermediate_login_page.dart';
import 'package:hades_app/screens_new/mailing/mailing_options_list_page.dart';
import 'package:hades_app/models/event.dart';
import 'package:hades_app/screens_new/mailing/mail_page.dart';
import 'package:hades_app/utils/enums.dart';
import 'package:hades_app/screens_new/participants_management/attendance/attendance_option_list_page.dart';
import 'package:hades_app/screens_new/participants_management/attendance/attendance_page.dart';
import 'package:hades_app/screens_new/participants_management/attendance/attendance_day_select_page.dart';
import 'package:hades_app/screens_new/participants_management/coupons/coupons_list_page.dart';
import 'package:hades_app/screens_new/participants_management/coupons/coupons_option_list_page.dart';
import 'package:hades_app/screens_new/participants_management/coupons/coupon_create_page.dart';
import 'package:hades_app/screens_new/participants_management/coupons/redeem_coupon_page.dart';
import 'package:hades_app/models/read_coupon.dart';
import 'package:hades_app/screens_new/participants_management/participant_crud/participant_list_page.dart';
import 'package:hades_app/screens_new/participants_management/participant_crud/participant_create_edit_page.dart';
import 'package:hades_app/models/read_attendee.dart';
import 'package:hades_app/screens_new/participants_management/participant_crud/participant_crud_option_list_page.dart';
import 'package:hades_app/screens_new/export/export_option_list_page.dart';
import 'package:hades_app/screens_new/export/export_page.dart';
import 'package:hades_app/screens_new/onboarding/onboarding.dart';

abstract class Routes {
  static const splashPage = '/';
  static const signUpPage = '/sign-up-page';
  static const loginPage = '/login-page';
  static const joinOrgListPage = '/join-org-list-page';
  static const getOrganizationPage = '/get-organization-page';
  static const createOrgPage = '/create-org-page';
  static const homePage = '/home-page';
  static const orgDetailPage = '/org-detail-page';
  static const createEventPage = '/create-event-page';
  static const intermediateOrgLogin = '/intermediate-org-login';
  static const mailingOptionsListPage = '/mailing-options-list-page';
  static const mailPage = '/mail-page';
  static const attendanceOptionListPage = '/attendance-option-list-page';
  static const attendancePage = '/attendance-page';
  static const attendanceDaySelectPage = '/attendance-day-select-page';
  static const couponListPage = '/coupon-list-page';
  static const couponsOptionListPage = '/coupons-option-list-page';
  static const createCouponPage = '/create-coupon-page';
  static const redeemCouponPage = '/redeem-coupon-page';
  static const participantListPage = '/participant-list-page';
  static const participantCreateEditPage = '/participant-create-edit-page';
  static const participantCRUDOptionListPage =
      '/participant-cr-ud-option-list-page';
  static const exportOptionListPage = '/export-option-list-page';
  static const exportPage = '/export-page';
  static const onBoardingScreen = '/on-boarding-screen';
  static const all = {
    splashPage,
    signUpPage,
    loginPage,
    joinOrgListPage,
    getOrganizationPage,
    createOrgPage,
    homePage,
    orgDetailPage,
    createEventPage,
    intermediateOrgLogin,
    mailingOptionsListPage,
    mailPage,
    attendanceOptionListPage,
    attendancePage,
    attendanceDaySelectPage,
    couponListPage,
    couponsOptionListPage,
    createCouponPage,
    redeemCouponPage,
    participantListPage,
    participantCreateEditPage,
    participantCRUDOptionListPage,
    exportOptionListPage,
    exportPage,
    onBoardingScreen,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashPage(),
          settings: settings,
        );
      case Routes.signUpPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpPage(),
          settings: settings,
        );
      case Routes.loginPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginPage(),
          settings: settings,
        );
      case Routes.joinOrgListPage:
        if (hasInvalidArgs<JoinOrgListPageArguments>(args)) {
          return misTypedArgsRoute<JoinOrgListPageArguments>(args);
        }
        final typedArgs =
            args as JoinOrgListPageArguments ?? JoinOrgListPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => JoinOrgListPage(from: typedArgs.from),
          settings: settings,
        );
      case Routes.getOrganizationPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => GetOrganizationPage(),
          settings: settings,
        );
      case Routes.createOrgPage:
        if (hasInvalidArgs<CreateOrgPageArguments>(args)) {
          return misTypedArgsRoute<CreateOrgPageArguments>(args);
        }
        final typedArgs =
            args as CreateOrgPageArguments ?? CreateOrgPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateOrgPage(from: typedArgs.from),
          settings: settings,
        );
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BasePage(),
          settings: settings,
        );
      case Routes.orgDetailPage:
        if (hasInvalidArgs<JoinOrgDetailPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<JoinOrgDetailPageArguments>(args);
        }
        final typedArgs = args as JoinOrgDetailPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => JoinOrgDetailPage(org: typedArgs.org),
          settings: settings,
        );
      case Routes.createEventPage:
        if (hasInvalidArgs<CreateEventPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<CreateEventPageArguments>(args);
        }
        final typedArgs = args as CreateEventPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateEventPage(org: typedArgs.org),
          settings: settings,
        );
      case Routes.intermediateOrgLogin:
        if (hasInvalidArgs<IntermediateLoginPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<IntermediateLoginPageArguments>(args);
        }
        final typedArgs = args as IntermediateLoginPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => IntermediateLoginPage(
              orgId: typedArgs.orgId, token: typedArgs.token),
          settings: settings,
        );
      case Routes.mailingOptionsListPage:
        if (hasInvalidArgs<MailingOptionsListPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<MailingOptionsListPageArguments>(args);
        }
        final typedArgs = args as MailingOptionsListPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              MailingOptionsListPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.mailPage:
        if (hasInvalidArgs<MailPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<MailPageArguments>(args);
        }
        final typedArgs = args as MailPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              MailPage(mode: typedArgs.mode, currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.attendanceOptionListPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AttendanceOptionListPage(),
          settings: settings,
        );
      case Routes.attendancePage:
        if (hasInvalidArgs<AttendancePageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AttendancePageArguments>(args);
        }
        final typedArgs = args as AttendancePageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => AttendancePage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.attendanceDaySelectPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AttendanceDaySelectPage(),
          settings: settings,
        );
      case Routes.couponListPage:
        if (hasInvalidArgs<CouponListPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<CouponListPageArguments>(args);
        }
        final typedArgs = args as CouponListPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => CouponListPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.couponsOptionListPage:
        if (hasInvalidArgs<CouponsOptionListPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<CouponsOptionListPageArguments>(args);
        }
        final typedArgs = args as CouponsOptionListPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              CouponsOptionListPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.createCouponPage:
        if (hasInvalidArgs<CreateCouponPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<CreateCouponPageArguments>(args);
        }
        final typedArgs = args as CreateCouponPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              CreateCouponPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.redeemCouponPage:
        if (hasInvalidArgs<RedeemCouponPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<RedeemCouponPageArguments>(args);
        }
        final typedArgs = args as RedeemCouponPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => RedeemCouponPage(
              currEvent: typedArgs.currEvent, coupon: typedArgs.coupon),
          settings: settings,
        );
      case Routes.participantListPage:
        if (hasInvalidArgs<ParticipantListPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<ParticipantListPageArguments>(args);
        }
        final typedArgs = args as ParticipantListPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              ParticipantListPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.participantCreateEditPage:
        if (hasInvalidArgs<ParticipantCreateEditPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<ParticipantCreateEditPageArguments>(args);
        }
        final typedArgs = args as ParticipantCreateEditPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => ParticipantCreateEditPage(
              mode: typedArgs.mode,
              currEvent: typedArgs.currEvent,
              participant: typedArgs.participant),
          settings: settings,
        );
      case Routes.participantCRUDOptionListPage:
        if (hasInvalidArgs<ParticipantCRUDOptionListPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<ParticipantCRUDOptionListPageArguments>(
              args);
        }
        final typedArgs = args as ParticipantCRUDOptionListPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              ParticipantCRUDOptionListPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.exportOptionListPage:
        if (hasInvalidArgs<ExportOptionListPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<ExportOptionListPageArguments>(args);
        }
        final typedArgs = args as ExportOptionListPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              ExportOptionListPage(currEvent: typedArgs.currEvent),
          settings: settings,
        );
      case Routes.exportPage:
        if (hasInvalidArgs<ExportPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<ExportPageArguments>(args);
        }
        final typedArgs = args as ExportPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              ExportPage(currEvent: typedArgs.currEvent, mode: typedArgs.mode),
          settings: settings,
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => OnBoardingScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//JoinOrgListPage arguments holder class
class JoinOrgListPageArguments {
  final String from;
  JoinOrgListPageArguments({this.from = 'login'});
}

//CreateOrgPage arguments holder class
class CreateOrgPageArguments {
  final String from;
  CreateOrgPageArguments({this.from = 'login'});
}

//JoinOrgDetailPage arguments holder class
class JoinOrgDetailPageArguments {
  final Organization org;
  JoinOrgDetailPageArguments({@required this.org});
}

//CreateEventPage arguments holder class
class CreateEventPageArguments {
  final Organization org;
  CreateEventPageArguments({@required this.org});
}

//IntermediateLoginPage arguments holder class
class IntermediateLoginPageArguments {
  final int orgId;
  final String token;
  IntermediateLoginPageArguments({@required this.orgId, @required this.token});
}

//MailingOptionsListPage arguments holder class
class MailingOptionsListPageArguments {
  final Event currEvent;
  MailingOptionsListPageArguments({@required this.currEvent});
}

//MailPage arguments holder class
class MailPageArguments {
  final MailingScreenMode mode;
  final Event currEvent;
  MailPageArguments({@required this.mode, @required this.currEvent});
}

//AttendancePage arguments holder class
class AttendancePageArguments {
  final Event currEvent;
  AttendancePageArguments({@required this.currEvent});
}

//CouponListPage arguments holder class
class CouponListPageArguments {
  final Event currEvent;
  CouponListPageArguments({@required this.currEvent});
}

//CouponsOptionListPage arguments holder class
class CouponsOptionListPageArguments {
  final Event currEvent;
  CouponsOptionListPageArguments({@required this.currEvent});
}

//CreateCouponPage arguments holder class
class CreateCouponPageArguments {
  final Event currEvent;
  CreateCouponPageArguments({@required this.currEvent});
}

//RedeemCouponPage arguments holder class
class RedeemCouponPageArguments {
  final Event currEvent;
  final ReadCoupon coupon;
  RedeemCouponPageArguments({@required this.currEvent, @required this.coupon});
}

//ParticipantListPage arguments holder class
class ParticipantListPageArguments {
  final Event currEvent;
  ParticipantListPageArguments({@required this.currEvent});
}

//ParticipantCreateEditPage arguments holder class
class ParticipantCreateEditPageArguments {
  final ParticipantScreenMode mode;
  final Event currEvent;
  final ReadAttendee participant;
  ParticipantCreateEditPageArguments(
      {@required this.mode,
      @required this.currEvent,
      @required this.participant});
}

//ParticipantCRUDOptionListPage arguments holder class
class ParticipantCRUDOptionListPageArguments {
  final Event currEvent;
  ParticipantCRUDOptionListPageArguments({@required this.currEvent});
}

//ExportOptionListPage arguments holder class
class ExportOptionListPageArguments {
  final Event currEvent;
  ExportOptionListPageArguments({@required this.currEvent});
}

//ExportPage arguments holder class
class ExportPageArguments {
  final Event currEvent;
  final ExportScreenMode mode;
  ExportPageArguments({@required this.currEvent, @required this.mode});
}

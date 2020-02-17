import '../models/organization.dart';
import '../screens/mailingServices/mailingServicesScreen.dart';

const BASE_URL=
  "https://hades.dscvit.com/api/v2";
    //'http://139.59.9.221';
//'http://192.168.43.192';
const URL_READEVENT='$BASE_URL/api/v1/event/read-event';
const URL_CREATEATTENDEE='$BASE_URL/api/v1/participants/create-attendee';
const URL_ALLPARTICIPANTS='$BASE_URL/api/v1/simple-projection/project-all';
const URL_JSONFETCH='$BASE_URL/api/v1/exporter/json';
const URL_EXCELFETCH='$BASE_URL/api/v1/exporter/excel';
const URL_CREATEEVENT='$BASE_URL/api/v1/event/create-event';
const URL_DELETEATTENDEE='$BASE_URL/api/v1/participants/rm-attendee';
const URL_DELETEEVENT='$BASE_URL/api/v1/event/delete-event';
const URL_CREATECOUPON='$BASE_URL/api/v1/coupons/create-schema';
const URL_VIEWCOUPON='$BASE_URL/api/v1/coupons/view-schema';
const URL_REDEEM='$BASE_URL/api/v1/coupons/redeem-coupon';
const URL_DELETECOUPON='$BASE_URL/api/v1/coupons/delete-coupon';
const URL_MARKATTENDENCE='$BASE_URL/api/v1/coupons/mark-present';
const URL_SEARCH='$BASE_URL';
const URL_LOGIN='$BASE_URL/api/v1/org/login';
const URL_SIGNUP='$BASE_URL/api/v1/org/signup';
const URL_CREATEORGANIZATION='$BASE_URL/api/v1/org/create-org';
const URL_SEARCHORG='$BASE_URL/api/v1/org/search?q=';
const URL_SENDREQUEST='$BASE_URL/api/v1/org/join?org=';
const URL_GETORG='$BASE_URL/api/v1/org/';



//MailingServicesScreen
const URL_MAILALL='$BASE_URL/api/v1/sendMail/';
const URL_SPECIFIC_MAIL='$BASE_URL/api/v1/sendMail/';

//Requests
const URL_LOADREQUESTS='$BASE_URL/api/v1/org/view-req?org=';
const URL_ACCEPTREQ='$BASE_URL/api/v1/org/accept';
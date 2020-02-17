import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/scoped_models/userModel.dart';
import 'package:hades_app/models/scoped_models/orgModel.dart';
import 'package:hades_app/models/scoped_models/eventModel.dart';
import 'package:hades_app/models/scoped_models/participantModel.dart';
import 'package:hades_app/models/scoped_models/exportModel.dart';
import 'package:hades_app/models/scoped_models/couponModel.dart';

class MainModel extends Model with UserModel, OrgModel, EventModel, ParticipantModel, ExportModel, CouponModel{

}
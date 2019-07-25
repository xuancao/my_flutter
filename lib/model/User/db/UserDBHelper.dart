import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ybwp_flutter/model/User/UserSPferUtils.dart';
import 'package:ybwp_flutter/model/User/UserEntity.dart';
import 'package:ybwp_flutter/utils/StringUtils.dart';

class UserDBHelper{
  static UserDBHelper _instance;

  static UserDBHelper getInstance() {
    if (_instance == null) {
      _instance = UserDBHelper();
    }
    return _instance;
  }

  final String dbName = 'userDB';
  final int dbVersion = 1;

  final String tableUser = '_userTable';
  final String primaryId = "_id";
  final String id = "id";
  final String phone = "_phone";
  final String email = "_email";
  final String token = "_token";
  final String imgUrl = "_imgUrl";
  final String realName = "_realName";
  final String birthday = "_birthday";
  final String roleType = "_roleType";
  final String sex = "_sex";
  final String createDate = "_createDate";
  final String abCode = "_abCode";
  final String managerMemberId = "_managerMemberId";
  final String managerName = "_managerName";
  final String companyId = "_companyId";
  final String company = "_company";
  final String managerAbcode = "_managerAbcode";


  static Database _db;

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"ybwp_v1.db");
    _db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return _db;
  }

  void _onCreate(Database db,int version) async{
    String sql =  '''create table $tableUser ( $primaryId integer primary key, $id text, $phone text, $email text, $token text,  $imgUrl text, $realName text, $birthday text, $roleType text, $sex text, $createDate text, $abCode text, $managerMemberId text, $managerName text, $companyId text, $company text, $managerAbcode text )''';
    print('sql='+sql);
    await db.execute(sql);
  }

  Future<int> saveUser(UserBeanEntity user) async{
    int res = await _db.insert(tableUser,toMap(user));
    print("res==>"+res.toString());
    if (user != null && user.token != null && user.token.isNotEmpty) {
      UserSpferUtils.saveToken(user.token);
    }
    return res;
  }

  Future<UserBeanEntity> getUser() async{
    List<Map> maps = await _db.query(tableUser);
    if(maps.length > 0){
      return fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteUser() async{
    return await _db.delete(tableUser);
  }

  Future<int> updateUser(UserBeanEntity user) async{
    return await _db.update(tableUser, toMap(user),where: "$id = ?",whereArgs: [user.id]);
  }



  Map<String, dynamic> toMap(UserBeanEntity user) {
    var map = <String, dynamic>{
//      id: user.id,
      id:StringUtils.isNotEmpty(user.id) ? user.id:"NULL",
      phone: StringUtils.isNotEmpty(user.phone) ? user.phone:"NULL",
      email: StringUtils.isNotEmpty(user.email) ? user.email:"NULL",
      token: StringUtils.isNotEmpty(user.token) ? user.token:"NULL",
      imgUrl: StringUtils.isNotEmpty(user.imgUrl) ? user.imgUrl:"NULL",
      realName: StringUtils.isNotEmpty(user.realName) ? user.realName:"NULL",
      birthday: StringUtils.isNotEmpty(user.birthday) ? user.birthday:"NULL",
      roleType: StringUtils.isNotEmpty(user.roleType) ? user.roleType:"NULL",
      sex: StringUtils.isNotEmpty(user.sex) ? user.sex:"NULL",
      createDate: StringUtils.isNotEmpty(user.createDate) ? user.createDate:"NULL",
      abCode: StringUtils.isNotEmpty(user.abCode) ? user.abCode:"NULL",
      managerMemberId: StringUtils.isNotEmpty(user.managerMemberId) ? user.managerMemberId:"NULL",
      managerName: StringUtils.isNotEmpty(user.managerName) ? user.managerName:"NULL",
      companyId:StringUtils.isNotEmpty(user.companyId) ? user.companyId:"NULL",
      company: StringUtils.isNotEmpty(user.company) ? user.company:"NULL",
      managerAbcode: StringUtils.isNotEmpty(user.managerAbcode) ? user.managerAbcode:"NULL",
    };
    return map;
  }

  UserBeanEntity fromMap(Map<String, dynamic> map) {
    UserBeanEntity user = new UserBeanEntity(
      map[birthday],
      map[abCode],
      map[sex],
      map[roleType],
      map[managerName],
      map[managerAbcode],
      map[token],
      map[managerMemberId],
      map[imgUrl],
      map[realName],
      map[phone],
      map[companyId],
      map[company],
      map[id],
      map[email],
      map[createDate],
    );

    return user;
  }
}


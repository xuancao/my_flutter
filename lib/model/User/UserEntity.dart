
class UserBeanEntity {
	int primaryId; //integer primary key,
	String birthday;
	String abCode;
	String sex;
	String roleType;
	String managerName;
	String managerAbcode;
	String token;
	String managerMemberId;
	String imgUrl;
	String realName;
	String companyId;
	String phone;
	String company;
	String id;
	String email;
	String createDate;

	UserBeanEntity(this.birthday, this.abCode, this.sex, this.roleType, this.managerName, this.managerAbcode, this.token, this.managerMemberId, this.imgUrl, this.realName,  this.phone, this.companyId,this.company, this.id, this.email, this.createDate);

	UserBeanEntity.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		abCode = json['abCode'];
		sex = json['sex'];
		roleType = json['roleType'];
		managerName = json['managerName'];
		managerAbcode = json['managerAbcode'];
		token = json['token'];
		managerMemberId = json['managerMemberId'];
		imgUrl = json['imgUrl'];
		realName = json['realName'];
		companyId = json['companyId'];
		phone = json['phone'];
		company = json['company'];
		id = json['id'];
		email = json['email'];
		createDate = json['createDate'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['abCode'] = this.abCode;
		data['sex'] = this.sex;
		data['roleType'] = this.roleType;
		data['managerName'] = this.managerName;
		data['managerAbcode'] = this.managerAbcode;
		data['token'] = this.token;
		data['managerMemberId'] = this.managerMemberId;
		data['imgUrl'] = this.imgUrl;
		data['realName'] = this.realName;
		data['companyId'] = this.companyId;
		data['phone'] = this.phone;
		data['company'] = this.company;
		data['id'] = this.id;
		data['email'] = this.email;
		data['createDate'] = this.createDate;
		return data;
	}
}

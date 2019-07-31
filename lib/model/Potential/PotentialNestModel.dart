class PotentialNestModel {
	int total;
	int pages;
	int pageSize;
	List<PotentialModel> list;
	int pageNum;

	PotentialNestModel({this.total, this.pages, this.pageSize, this.list, this.pageNum});

	PotentialNestModel.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		pages = json['pages'];
		pageSize = json['pageSize'];
		if (json['list'] != null) {
			list = new List<PotentialModel>();
			(json['list'] as List).forEach((v) { list.add(new PotentialModel.fromJson(v)); });
		}
		pageNum = json['pageNum'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['pages'] = this.pages;
		data['pageSize'] = this.pageSize;
		if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
		data['pageNum'] = this.pageNum;
		return data;
	}
}

class PotentialModel {
	String sex;
	String networkName;
	String bankLogo;
	String ageGroup;
	String bankLogoColor;
	String lastTrackingTime;
	String name;
	String networkId;
	String id;
	String tag;
	String age;
	String createDate;
	String referenceName;

	PotentialModel({this.sex, this.networkName, this.bankLogo, this.ageGroup, this.bankLogoColor, this.lastTrackingTime, this.name, this.networkId, this.id, this.tag, this.age, this.createDate, this.referenceName});

	PotentialModel.fromJson(Map<String, dynamic> json) {
		sex = json['sex'];
		networkName = json['networkName'];
		bankLogo = json['bankLogo'];
		ageGroup = json['ageGroup'];
		bankLogoColor = json['bankLogoColor'];
		lastTrackingTime = json['lastTrackingTime'];
		name = json['name'];
		networkId = json['networkId'];
		id = json['id'];
		tag = json['tag'];
		age = json['age'];
		createDate = json['createDate'];
		referenceName = json['referenceName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sex'] = this.sex;
		data['networkName'] = this.networkName;
		data['bankLogo'] = this.bankLogo;
		data['ageGroup'] = this.ageGroup;
		data['bankLogoColor'] = this.bankLogoColor;
		data['lastTrackingTime'] = this.lastTrackingTime;
		data['name'] = this.name;
		data['networkId'] = this.networkId;
		data['id'] = this.id;
		data['tag'] = this.tag;
		data['age'] = this.age;
		data['createDate'] = this.createDate;
		data['referenceName'] = this.referenceName;
		return data;
	}
}

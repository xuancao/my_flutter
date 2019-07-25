class DotNetNestModel {
	List<NetDotModel> content;

	DotNetNestModel({this.content});

	factory DotNetNestModel.fromJson(List<dynamic> parsedJson) {
		List<NetDotModel> list = List<NetDotModel>();
		list = parsedJson.map((i)=>NetDotModel.fromJson(i)).toList();
		return DotNetNestModel(
			content: list,
		);
	}

	static List toJson(List<dynamic>list){
		List jsonList = List();
		list.map((item)=> jsonList.add(item.toJson())).toList();
		return jsonList;
	}

}

class NetDotModel {
	String visitTime;
	String color;
	String name;
	String logo;
	String startTime;
	String bankName;
	String id;
	String shortName;

	NetDotModel({this.visitTime, this.color, this.name, this.logo, this.startTime, this.bankName, this.id, this.shortName});

	NetDotModel.fromJson(Map<String, dynamic> json) {
		visitTime = json['visitTime'];
		color = json['color'];
		name = json['name'];
		logo = json['logo'];
		startTime = json['startTime'];
		bankName = json['bankName'];
		id = json['id'];
		shortName = json['shortName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visitTime'] = this.visitTime;
		data['color'] = this.color;
		data['name'] = this.name;
		data['logo'] = this.logo;
		data['startTime'] = this.startTime;
		data['bankName'] = this.bankName;
		data['id'] = this.id;
		data['shortName'] = this.shortName;
		return data;
	}
}

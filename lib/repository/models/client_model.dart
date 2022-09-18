class ClientProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? sex;
  String? location;
  String? company;
  double? experience;
  String? photo;
  int? contribution;
  bool? isVerified;

  ClientProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.sex,
    this.location,
    this.company,
    this.experience,
    this.photo,
    this.contribution,
    this.isVerified
  });

  ClientProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    sex = json['sex'];
    location = json['location'];
    company = json['company'];
    experience = json['experience'];
    photo = json['photo'];
    contribution = json['contribution'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['sex'] = sex;
    data['location'] = location;
    data['company'] = company;
    data['experience'] = experience;
    data['photo'] = photo;
    data['contribution'] = contribution;
    data['is_verified'] = isVerified;
    return data;
  }
}

class FreelancerSkill {
  int? skillId;
  String? skill;

  FreelancerSkill({this.skillId, this.skill});

  FreelancerSkill.fromJson(Map<String, dynamic> json) {
    skillId = json['skill_Id'];
    skill = json['skill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['skill_Id'] = skillId;
    data['skill'] = skill;
    return data;
  }
}

class FreelancerSkillAdd {
  List<String>? skill;

  FreelancerSkillAdd({this.skill});

  FreelancerSkillAdd.fromJson(Map<String, dynamic> json) {
    skill = json['skill'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['skill'] = skill;
    return data;
  }
}


class FreelancerClientModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? sex;
  String? location;
  String? company;
  double? experience;
  String? photo;
  int? contribution;
  bool? isVerified;

  FreelancerClientModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.sex,
    this.location,
    this.company,
    this.experience,
    this.photo,
    this.contribution,
    this.isVerified
  });

  FreelancerClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    sex = json['sex'];
    location = json['location'];
    company = json['company'];
    experience = json['experience'];
    photo = json['photo'];
    contribution = json['contribution'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['sex'] = sex;
    data['location'] = location;
    data['company'] = company;
    data['experience'] = experience;
    data['photo'] = photo;
    data['contribution'] = contribution;
    data['is_verified'] = isVerified;
    return data;
  }
}

class ClientCurrentJob {
  int? contractId;
  int? jobId;
  String? title;
  String? description;
  String? postDate;
  int? duration;
  double? maxPay;
  String? freelancer;
  String? email;
  String? phone;
  int? selectedBid;
  String? startDate;
  String? deadline;

  ClientCurrentJob(
      {this.contractId,
      this.jobId,
      this.title,
      this.description,
      this.postDate,
      this.duration,
      this.maxPay,
      this.freelancer,
      this.email,
      this.phone,
      this.selectedBid,
      this.startDate,
      this.deadline});

  ClientCurrentJob.fromJson(Map<String, dynamic> json) {
    contractId = json['contract_id'];
    jobId = json['job_id'];
    title = json['title'];
    description = json['description'];
    postDate = json['post_date'];
    duration = json['duration'];
    maxPay = json['max_pay'];
    freelancer = json['freelancer'];
    email = json['email'];
    phone = json['phone'];
    selectedBid = json['selected_bid'];
    startDate = json['start_date'];
    deadline = json['deadline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contract_id'] = contractId;
    data['job_id'] = jobId;
    data['title'] = title;
    data['description'] = description;
    data['post_date'] = postDate;
    data['duration'] = duration;
    data['max_pay'] = maxPay;
    data['freelancer'] = freelancer;
    data['email'] = email;
    data['phone'] = phone;
    data['selected_bid'] = selectedBid;
    data['start_date'] = startDate;
    data['deadline'] = deadline;
    return data;
  }
}

class ClientPendingRequests {
  int? jobId;
  int? bidId;
  int? fid;
  String? title;
  String? description;
  String? postDate;
  int? duration;
  double? maxPay;
  String? freelancer;
  int? amount;
  String? about;
  String? bidDate;

  ClientPendingRequests(
    {this.jobId,
    this.bidId,
    this.fid,
    this.title,
    this.description,
    this.postDate,
    this.duration,
    this.maxPay,
    this.freelancer,
    this.amount,
    this.about,
    this.bidDate});

  ClientPendingRequests.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    bidId = json['bid_id'];
    fid = json['fid'];
    title = json['title'];
    description = json['description'];
    postDate = json['post_date'];
    duration = json['duration'];
    maxPay = json['max_pay'];
    freelancer = json['freelancer'];
    amount = json['amount'];
    about = json['about'];
    bidDate = json['bid_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = jobId;
    data['bid_id'] = bidId;
    data['fid'] = fid;
    data['title'] = title;
    data['description'] = description;
    data['post_date'] = postDate;
    data['duration'] = duration;
    data['max_pay'] = maxPay;
    data['freelancer'] = freelancer;
    data['amount'] = amount;
    data['about'] = about;
    data['bid_date'] = bidDate;
    return data;
  }
}

class ClientJobHistory {
  int? jobId;
  String? title;
  String? description;
  String? postDate;
  String? startDate;
  String? endDate;
  String? freelancer;
  int? bid;
  String? review;

  ClientJobHistory(
      {this.jobId,
      this.title,
      this.description,
      this.postDate,
      this.startDate,
      this.endDate,
      this.freelancer,
      this.bid,
      this.review});

  ClientJobHistory.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    title = json['title'];
    description = json['description'];
    postDate = json['post_date'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    freelancer = json['freelancer'];
    bid = json['bid'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = jobId;
    data['title'] = title;
    data['description'] = description;
    data['post_date'] = postDate;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['freelancer'] = freelancer;
    data['bid'] = bid;
    data['review'] = review;
    return data;
  }
}

class JobGet {
  int? id;
  String? postdate;
  String? title;
  String? description;
  int? duration;
  double? maxPay;

  JobGet(
      {this.id,
      this.postdate,
      this.title,
      this.description,
      this.duration,
      this.maxPay
    });

  JobGet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postdate = json['post_date'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    maxPay = json['max_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['post_date'] = postdate;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['max_pay'] = maxPay;
    return data;
  }
}

class ClientRecommend {
  String? freelancer;
  int? fid;
  String? tag;
  String? email;
  int? contribution;
  double? experience;
  bool? isVerified;

  ClientRecommend(
    {this.freelancer,
    this.fid,
    this.tag,
    this.email,
    this.contribution,
    this.experience,
    this.isVerified});

  ClientRecommend.fromJson(Map<String, dynamic> json) {
    freelancer = json['freelancer'];
    fid = json['fid'];
    tag = json['tag'];
    email = json['email'];
    contribution = json['contribution'];
    experience = json['experience'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['freelancer'] = freelancer;
    data['fid'] = fid;
    data['tag'] = tag;
    data['email'] = email;
    data['contribution'] = contribution;
    data['experience'] = experience;
    data['is_verified'] = isVerified;
    return data;
  }
}

class ClientSearch {
  String? freelancer;
  int? fid;
  String? tag;
  String? email;
  int? contribution;
  double? experience;
  bool? isVerified;

  ClientSearch(
    {this.freelancer,
    this.fid,
    this.tag,
    this.email,
    this.contribution,
    this.experience,
    this.isVerified});

  ClientSearch.fromJson(Map<String, dynamic> json) {
    freelancer = json['freelancer'];
    fid = json['fid'];
    tag = json['tag'];
    email = json['email'];
    contribution = json['contribution'];
    experience = json['experience'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['freelancer'] = freelancer;
    data['fid'] = fid;
    data['tag'] = tag;
    data['email'] = email;
    data['contribution'] = contribution;
    data['experience'] = experience;
    data['is_verified'] = isVerified;
    return data;
  }
}

class JobList {
  int? id;
  String? postDate;
  String? title;
  String? description;
  int? duration;
  int? maxPay;
  String? client;
  bool? isVerified;

  JobList(
      {this.id,
      this.postDate,
      this.title,
      this.description,
      this.duration,
      this.maxPay,
      this.client,
      this.isVerified});

  JobList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postDate = json['post_date'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    maxPay = json['max_pay'];
    client = json['client'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_date'] = this.postDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['max_pay'] = this.maxPay;
    data['client'] = this.client;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
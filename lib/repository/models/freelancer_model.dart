class FreelancerProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? tag;
  String? sex;
  String? dob;
  String? location;
  String? qualification;
  double? experience;
  String? photo;
  int? contribution;
  bool? isVerified;
  int? ratings;

  FreelancerProfile(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.tag,
      this.sex,
      this.dob,
      this.location,
      this.qualification,
      this.experience,
      this.photo,
      this.contribution,
      this.isVerified,
      this.ratings,});

  FreelancerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    tag = json['tag'];
    sex = json['sex'];
    dob = json['dob'];
    location = json['location'];
    qualification = json['qualification'];
    experience = json['experience'];
    photo = json['photo'];
    contribution = json['contribution'];
    isVerified = json['is_verified'];
    ratings = json['ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['tag'] = this.tag;
    data['sex'] = this.sex;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['qualification'] = this.qualification;
    data['experience'] = this.experience;
    data['photo'] = this.photo;
    data['contribution'] = this.contribution;
    data['is_verified'] = this.isVerified;
    data['ratings'] = this.ratings;
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
    data['skill_Id'] = this.skillId;
    data['skill'] = this.skill;
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
    data['skill'] = this.skill;
    return data;
  }
}

class FreelancerCurrentJob {
  int? jobId;
  String? title;
  String? description;
  int? duration;
  double? maxPay;
  String? postDate;
  String? client;
  String? email;
  String? phone;
  int? amount;
  String? startDate;
  String? deadline;

  FreelancerCurrentJob(
      {this.jobId,
      this.title,
      this.description,
      this.duration,
      this.maxPay,
      this.postDate,
      this.client,
      this.email,
      this.phone,
      this.amount,
      this.startDate,
      this.deadline});

  FreelancerCurrentJob.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    maxPay = json['max_pay'];
    postDate = json['post_date'];
    client = json['client'];
    email = json['email'];
    phone = json['phone'];
    amount = json['amount'];
    startDate = json['start_date'];
    deadline = json['deadline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['max_pay'] = this.maxPay;
    data['post_date'] = this.postDate;
    data['client'] = this.client;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['start_date'] = this.startDate;
    data['deadline'] = this.deadline;
    return data;
  }
}

class FreelancerAppliedBids {
  int? jobId;
  int? bids;
  String? title;
  String? description;
  int? duration;
  double? maxPay;
  String? postDate;
  String? client;
  String? email;
  int? bidId;
  int? amount;
  String? about;
  String? bidDate;

  FreelancerAppliedBids(
      {this.jobId,
      this.bids,
      this.title,
      this.description,
      this.duration,
      this.maxPay,
      this.postDate,
      this.client,
      this.email,
      this.bidId,
      this.amount,
      this.about,
      this.bidDate});

  FreelancerAppliedBids.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    bids = json['bids'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    maxPay = json['max_pay'];
    postDate = json['post_date'];
    client = json['client'];
    email = json['email'];
    bidId = json['bid_id'];
    amount = json['amount'];
    about = json['about'];
    bidDate = json['bid_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['bids'] = this.bids;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['max_pay'] = this.maxPay;
    data['post_date'] = this.postDate;
    data['client'] = this.client;
    data['email'] = this.email;
    data['bid_id'] = this.bidId;
    data['amount'] = this.amount;
    data['about'] = this.about;
    data['bid_date'] = this.bidDate;
    return data;
  }
}

class FreelancerFavourites {
  int? jobId;
  int? bids;
  String? title;
  String? description;
  int? duration;
  double? maxPay;
  String? postDate;
  String? client;
  String? email;
  int? favId;
  List<String>? skillList;

  FreelancerFavourites(
      {this.jobId,
      this.bids,
      this.title,
      this.description,
      this.duration,
      this.maxPay,
      this.postDate,
      this.client,
      this.email,
      this.favId,
      this.skillList});

  FreelancerFavourites.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    bids = json['bids'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    maxPay = json['max_pay'];
    postDate = json['post_date'];
    client = json['client'];
    email = json['email'];
    favId = json['fav_id'];
    skillList = json['skill_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['bids'] = this.bids;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['max_pay'] = this.maxPay;
    data['post_date'] = this.postDate;
    data['client'] = this.client;
    data['email'] = this.email;
    data['fav_id'] = this.favId;
    data['skill_list'] = this.skillList;
    return data;
  }
}

class FreelancerHistory {
  int? jobId;
  String? title;
  String? description;
  String? postDate;
  String? submitDate;
  String? client;
  int? bid;
  String? review;

  FreelancerHistory(
      {this.jobId,
      this.title,
      this.description,
      this.postDate,
      this.submitDate,
      this.client,
      this.bid,
      this.review});

  FreelancerHistory.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    title = json['title'];
    description = json['description'];
    postDate = json['post_date'];
    submitDate = json['submit_date'];
    client = json['client'];
    bid = json['bid'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['post_date'] = this.postDate;
    data['submit_date'] = this.submitDate;
    data['client'] = this.client;
    data['bid'] = this.bid;
    data['review'] = this.review;
    return data;
  }
}

class FreelancerRecommend {
  String? title;
  int? jobId;
  int? bids;
  String? description;
  String? postDate;
  String? client;
  bool? verified;
  double? maxPay;
  int? duration;
  bool? isFavourite;
  int? fId;

  FreelancerRecommend(
      {this.title,
      this.jobId,
      this.bids,
      this.description,
      this.postDate,
      this.client,
      this.verified,
      this.maxPay,
      this.duration,
      this.isFavourite,
      this.fId});

  FreelancerRecommend.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    jobId = json['job_id'];
    bids = json['bids'];
    description = json['description'];
    postDate = json['post_date'];
    client = json['client'];
    verified = json['verified'];
    maxPay = json['max_pay'];
    duration = json['duration'];
    isFavourite = json['is_favourite'];
    fId = json['f_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['job_id'] = this.jobId;
    data['bids'] = this.bids;
    data['description'] = this.description;
    data['post_date'] = this.postDate;
    data['client'] = this.client;
    data['verified'] = this.verified;
    data['max_pay'] = this.maxPay;
    data['duration'] = this.duration;
    data['is_favourite'] = this.isFavourite;
    data['f_id'] = this.fId;
    return data;
  }
}

class FreelancerSearch {
  int? id;
  String? job;
  String? postDate;
  double? maxPay;
  int? duration;
  String? client;
  bool? isVerified;
  int? bids;
  String? description;
  bool? isFavourite;
  int? fId;

  FreelancerSearch(
      {this.id,
      this.job,
      this.postDate,
      this.maxPay,
      this.duration,
      this.client,
      this.isVerified,
      this.bids,
      this.description,
      this.isFavourite,
      this.fId});

  FreelancerSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'];
    postDate = json['post_date'];
    maxPay = json['max_pay'];
    duration = json['duration'];
    client = json['client'];
    isVerified = json['is_verified'];
    bids = json['bids'];
    description = json['description'];
    isFavourite = json['is_favourite'];
    fId = json['f_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job'] = this.job;
    data['post_date'] = this.postDate;
    data['max_pay'] = this.maxPay;
    data['duration'] = this.duration;
    data['client'] = this.client;
    data['is_verified'] = this.isVerified;
    data['bids'] = this.bids;
    data['description'] = this.description;
    data['is_favourite'] = this.isFavourite;
    data['f_id'] = this.fId;
    return data;
  }
}
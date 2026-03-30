class MessageResponse {
  List<MessageData>? data;
  Meta? meta;
  AdditionalInfo? additionalInfo;

  MessageResponse({this.data, this.meta, this.additionalInfo});

  MessageResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MessageData>[];
      json['data'].forEach((v) {
        data!.add(MessageData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    additionalInfo = json['additional_info'] != null
        ? AdditionalInfo.fromJson(json['additional_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (additionalInfo != null) {
      data['additional_info'] = additionalInfo!.toJson();
    }
    return data;
  }
}

class MessageData {
  int? id;
  int? senderId;
  int? receiverId;
  String? message;
  String? thumbnail;
  int? type;
  int? createdAt;
  String? mediaName;

  MessageData(
      {this.id,
      this.senderId,
      this.receiverId,
      this.message,
      this.thumbnail,
      this.type,
      this.createdAt,
      this.mediaName});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    createdAt = json['created_at'] * 1000;
    mediaName = json['media_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['thumbnail'] = thumbnail;
    data['media_name'] = mediaName;

    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class AdditionalInfo {
  int? id;
  String? serviceRoles;
  String? name;
  String? companyName;
  String? profile;
  String? email;
  String? roleListName;
  String? location;
  bool? status;

  AdditionalInfo(
      {this.id,
      this.serviceRoles,
      this.name,
      this.companyName,
      this.profile,
      this.email,
      this.roleListName,
      this.location,
      this.status});

  AdditionalInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceRoles = json['service_roles'];
    name = json['name'];
    companyName = json['company_name'];
    profile = json['profile'];
    email = json['email'];
    roleListName = json['role_list_name'];
    location = json['location'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_roles'] = serviceRoles;
    data['name'] = name;
    data['company_name'] = companyName;
    data['profile'] = profile;
    data['email'] = email;
    data['role_list_name'] = roleListName;
    data['location'] = location;
    data['status'] = status;
    return data;
  }
}

class ChatUserInfo {
  int? id;
  String? serviceRoles;
  String? name;
  String? companyName;
  String? profile;
  String? email;
  String? roleListName;
  String? location;
  bool? status;

  ChatUserInfo(
      {this.id,
      this.serviceRoles,
      this.name,
      this.companyName,
      this.profile,
      this.email,
      this.roleListName,
      this.location,
      this.status});

  ChatUserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceRoles = json['service_roles'];
    name = json['name'];
    companyName = json['company_name'];
    profile = json['profile'];
    email = json['email'];
    roleListName = json['role_list_name'];
    location = json['location'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_roles'] = serviceRoles;
    data['name'] = name;
    data['company_name'] = companyName;
    data['profile'] = profile;
    data['email'] = email;
    data['role_list_name'] = roleListName;
    data['location'] = location;
    data['status'] = status;
    return data;
  }
}

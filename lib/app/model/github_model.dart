class TopicModel {
  bool? success;
  List<Result>? result;

  TopicModel({this.success, this.result});

  TopicModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepoModel {
  bool? success;
  Result? result;

  RepoModel({this.success, this.result});

  RepoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class RepoReadmeModel {
  bool? success;
  Result? result;

  RepoReadmeModel({this.success, this.result});

  RepoReadmeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? url;
  String? owner;
  String? repo;
  Details? details;
  Readme? readme;

  Result({this.url, this.owner, this.repo, this.details, this.readme});

  Result.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    owner = json['owner'];
    repo = json['repo'];
    details = json['details'] != null ? new Details.fromJson(json['details']) : null;
    readme = json['readme'] != null ? new Readme.fromJson(json['readme']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['owner'] = this.owner;
    data['repo'] = this.repo;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    if (this.readme != null) {
      data['readme'] = this.readme!.toJson();
    }
    return data;
  }
}

class Details {
  String? description;
  String? createdAt;
  String? updatedAt;
  int? stargazersCount;
  int? forksCount;
  int? subscribersCount;
  String? gitUrl;
  String? homepage;
  License? license;
  List<String>? topics;

  Details(
      {this.description,
      this.createdAt,
      this.updatedAt,
      this.stargazersCount,
      this.forksCount,
      this.subscribersCount,
      this.gitUrl,
      this.homepage,
      this.license,
      this.topics});

  Details.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stargazersCount = json['stargazers_count'];
    forksCount = json['forks_count'];
    subscribersCount = json['subscribers_count'];
    gitUrl = json['git_url'];
    homepage = json['homepage'];
    license = json['license'] != null ? new License.fromJson(json['license']) : null;
    topics = json['topics'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stargazers_count'] = this.stargazersCount;
    data['forks_count'] = this.forksCount;
    data['subscribers_count'] = this.subscribersCount;
    data['git_url'] = this.gitUrl;
    data['homepage'] = this.homepage;
    if (this.license != null) {
      data['license'] = this.license!.toJson();
    }
    data['topics'] = this.topics;
    return data;
  }
}

class License {
  String? key;
  String? name;
  String? spdxId;
  String? url;
  String? nodeId;

  License({this.key, this.name, this.spdxId, this.url, this.nodeId});

  License.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    spdxId = json['spdx_id'];
    url = json['url'];
    nodeId = json['node_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['spdx_id'] = this.spdxId;
    data['url'] = this.url;
    data['node_id'] = this.nodeId;
    return data;
  }
}

class Readme {
  String? url;
  String? downloadUrl;
  String? content;

  Readme({this.url, this.downloadUrl, this.content});

  Readme.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    downloadUrl = json['download_url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    data['content'] = this.content;
    return data;
  }
}

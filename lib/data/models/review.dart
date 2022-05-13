class Review {
  num? id;
  num? page;
  List<Results>? results;
  num? totalPages;
  num? totalResults;

  Review(
      {this.id, this.page, this.results, this.totalPages, this.totalResults});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'page': page,
      'results': results?.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }
}

class Results {
  String? author;
  AuthorDetails? authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;

  Results(
      {this.author,
      this.authorDetails,
      this.content,
      this.createdAt,
      this.id,
      this.updatedAt,
      this.url});

  Results.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    authorDetails = json['author_details'] != null
        ? AuthorDetails.fromJson(json['author_details'])
        : null;
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    if (authorDetails != null) {
      data['author_details'] = authorDetails!.toJson();
    }
    data['content'] = content;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['url'] = url;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      // 'authorDetails': authorDetails?.toMap(),
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'url': url,
    };
  }
}

class AuthorDetails {
  String? name;
  String? username;
  String? avatarPath;
  num? rating;

  AuthorDetails({this.name, this.username, this.avatarPath, this.rating});

  AuthorDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    avatarPath = json['avatar_path'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['avatar_path'] = avatarPath;
    data['rating'] = rating;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'avatarPath': avatarPath,
      'rating': rating,
    };
  }
}

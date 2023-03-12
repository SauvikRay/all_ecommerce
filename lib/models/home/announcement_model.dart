class AnnouncementModel {
  int? id;
  String? postTitle;
  String? postSlug;
  String? postContent;
  String? postExcerpt;
  String? postStatus;
  String? scheduleTime;
  String? postType;
  String? postFormat;
  String? postThumb;
  String? thumbDirectory;
  int? thumbStatus;
  String? commentsStatus;
  String? attachmentStatus;
  String? optionStatus;
  int? revisionBy;
  int? updateBy;
  int? userId;
  int? readCount;
  int? commentCount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AnnouncementModel({
    this.id,
    this.postTitle,
    this.postSlug,
    this.postContent,
    this.postExcerpt,
    this.postStatus,
    this.scheduleTime,
    this.postType,
    this.postFormat,
    this.postThumb,
    this.thumbDirectory,
    this.thumbStatus,
    this.commentsStatus,
    this.attachmentStatus,
    this.optionStatus,
    this.revisionBy,
    this.updateBy,
    this.userId,
    this.readCount,
    this.commentCount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postTitle = json['post_title'];
    postSlug = json['post_slug'];
    postContent = json['post_content'];
    postExcerpt = json['post_excerpt'];
    postStatus = json['post_status'];
    scheduleTime = json['schedule_time'];
    postType = json['post_type'];
    postFormat = json['post_format'];
    postThumb = json['post_thumb'];
    thumbDirectory = json['thumb_directory'];
    thumbStatus = json['thumb_status'];
    commentsStatus = json['comments_status'];
    attachmentStatus = json['attachment_status'];
    optionStatus = json['option_status'];
    revisionBy = json['revision_by'];
    updateBy = json['update_by'];
    userId = json['user_id'];
    readCount = json['read_count'];
    commentCount = json['comment_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['post_title'] = this.postTitle;
    data['post_slug'] = this.postSlug;
    data['post_content'] = this.postContent;
    data['post_excerpt'] = this.postExcerpt;
    data['post_status'] = this.postStatus;
    data['schedule_time'] = this.scheduleTime;
    data['post_type'] = this.postType;
    data['post_format'] = this.postFormat;
    data['post_thumb'] = this.postThumb;
    data['thumb_directory'] = this.thumbDirectory;
    data['thumb_status'] = this.thumbStatus;
    data['comments_status'] = this.commentsStatus;
    data['attachment_status'] = this.attachmentStatus;
    data['option_status'] = this.optionStatus;
    data['revision_by'] = this.revisionBy;
    data['update_by'] = this.updateBy;
    data['user_id'] = this.userId;
    data['read_count'] = this.readCount;
    data['comment_count'] = this.commentCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
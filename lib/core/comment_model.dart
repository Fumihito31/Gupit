import 'dart:convert';

/// CommentModel class contains individual comment object model (a comment is a review or statement provided by consumers to a store)
/// Contains 4 fields: 
/// - commentorName: name of the consumer who wrote the comment, 
/// - photo: profile photo of the consumer, 
/// - time: the time at which the comment was published, 
/// - comment: the actual comment.
class CommentModel {
  CommentModel({
    required this.commentorName,
    required this.photo,
    required this.time,
    required this.comment,
  });

  String commentorName;
  dynamic photo;
  String time;
  String comment;

  /// Factory to convert a raw JSON string to CommentModel elements
  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  /// Method to convert the model into a raw JSON string
  String toRawJson() => json.encode(toJson());

  /// Factory for converting individual JSON object into CommentModel object
  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentorName: json["CommentorName"] ?? '',
        photo: json["Photo"],
        time: json["Time"] ?? '',
        comment: json["Comment"] ?? '',
      );

  /// Converting individual CommentModel object to a JSON object
  Map<String, dynamic> toJson() => {
        "CommentorName": commentorName,
        "Photo": photo,
        "Time": time,
        "Comment": comment,
      };
}

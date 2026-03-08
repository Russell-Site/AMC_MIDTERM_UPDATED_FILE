// feed/post_model.dart

class Post {
  final int id;
  final String username;
  final String userAvatar;
  final String imageUrl;
  final String? videoUrl;
  final String caption;
  final int likes;

  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.imageUrl,
    this.videoUrl,
    required this.caption,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    return Post(
      id: id,
      username: "buzzer_$id",
      userAvatar: "https://i.pravatar.cc/150?u=hive$id",
      imageUrl: "https://picsum.photos/seed/${id + 50}/600/600",
      videoUrl: id % 4 == 0
          ? "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
          : null,
      caption: json['body']?.toString().split('\n').first ?? '',
      likes: (id * 37) % 890 + 120,
    );
  }
}
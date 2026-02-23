class Post {
  final int id;
  final String username;
  final String userAvatar;
  final String imageUrl;
  final String? videoUrl;

  Post({required this.id, required this.username, required this.userAvatar, required this.imageUrl, this.videoUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    return Post(
      id: id,
      username: "username_$id",
      userAvatar: "https://i.pravatar.cc/150?u=$id",
      imageUrl: "https://picsum.photos/seed/${id + 50}/600/400",
      videoUrl: id % 4 == 0 ? "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4" : null,
    );
  }
}
  class ChatModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;
 
  ChatModel(
      {required this.avatarUrl,
      required this.name,
      required this.datetime,
      required this.message});
 
  static final List<ChatModel> dummyData = [
    ChatModel(
      avatarUrl: "https://picsum.photos/seed/345/600",
      name: "moyo june",
      datetime: "20:18",
      message: "How about meeting tomorrow for the book?",
    ),
    ChatModel(
      avatarUrl: "https://picsum.photos/seed/716/600",
      name: "john thuo",
      datetime: "19:22",
      message: "I love that book. It was a great read!",
    ),
    ChatModel(
      avatarUrl: "https://picsum.photos/seed/1234/600",
      name: "claire atkins",
      datetime: "14:34",
      message: "I wasn't aware of that. Let me check",
    ),
    ChatModel(
      avatarUrl: "https://picsum.photos/seed/181920/600",
      name: "Leticia",
      datetime: "11:05",
      message: "When can I get the book?",
    ),
    ChatModel(
      avatarUrl: "https://picsum.photos/seed/91011/600",
      name: "Mark",
      datetime: "09:46",
      message: "Do you have any other book to recommend?",
    ),
    ChatModel(
      avatarUrl: "https://picsum.photos/seed/151617/600",
      name: "jacob thuo",
      datetime: "09:46",
      message: "Just got your book. Let's talk",
    ),
        ChatModel(
      avatarUrl: "https://picsum.photos/seed/91011/600",
      name: "Moses Anthony",
      datetime: "09:46",
      message: "Beautiful read.Do you have more?",
    ),
        ChatModel(
      avatarUrl: "https://picsum.photos/seed/678/600",
      name: "Marie Paul",
      datetime: "09:46",
      message: "Do you have any other book to recommend?",
    ),
  ];
}
 

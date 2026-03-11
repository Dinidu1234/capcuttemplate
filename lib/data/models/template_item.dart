class TemplateItem {
  final String id;
  final String title;
  final String tUrl;
  final String vUrl;

  const TemplateItem({
    required this.id,
    required this.title,
    required this.tUrl,
    required this.vUrl,
  });

  factory TemplateItem.fromJson(Map<String, dynamic> json) {
    return TemplateItem(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled Template').toString(),
      tUrl: (json['Turl'] ?? '').toString(),
      vUrl: (json['Vurl'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tUrl': tUrl,
      'vUrl': vUrl,
    };
  }

  factory TemplateItem.fromMap(Map<String, dynamic> map) {
    return TemplateItem(
      id: (map['id'] ?? '').toString(),
      title: (map['title'] ?? 'Untitled Template').toString(),
      tUrl: (map['tUrl'] ?? '').toString(),
      vUrl: (map['vUrl'] ?? '').toString(),
    );
  }
}

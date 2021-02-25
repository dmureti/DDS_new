class DeliveryReportStatus {
  String description;
  String groupId;
  String groupName;
  String id;
  String name;
  String permanent;

  DeliveryReportStatus(
      {this.description,
      this.groupId,
      this.groupName,
      this.id,
      this.name,
      this.permanent});

  factory DeliveryReportStatus.fromMap(Map<String, dynamic> data) {
    return DeliveryReportStatus(
        description: data['description'] ?? "",
        groupId: data['groupId'] ?? "",
        groupName: data['groupName'] ?? "",
        id: data['id'] ?? "",
        name: data['name'] ?? "",
        permanent: data['permanent'] ?? "");
  }

  toJson() {
    return {
      "description": description,
      "groupId": groupId,
      "groupName": groupName,
      "id": id,
      "name": name,
      "permanent": permanent
    };
  }
}

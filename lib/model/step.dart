class Step {
    int id;
    int userId;
    DateTime tanggal;
    String step;
    DateTime createdAt;
    DateTime updatedAt;

    Step({
        required this.id,
        required this.userId,
        required this.tanggal,
        required this.step,
        required this.createdAt,
        required this.updatedAt,
    });

    Step.fromMap(Map<String, dynamic> item): 
    id=item["id"] ?? '', 
    userId=item["userId"] ?? '', 
    step=item["step"] ?? '', 
    tanggal=item["tanggal"] ?? '', 
    createdAt= item["createdAt"] ?? '',
    updatedAt= item["updatedAt"] ?? '';
  
  Map<String, Object> toMap(){
    return {
      'id':id,
      'userId':userId,
      'step':step,
      'tanggal':tanggal,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

}

class member{
  final int m_id;
  final String m_name;
  final String m_batch;

  member({required this.m_id, required this.m_name, required this.m_batch});

  factory member.fromJson(Map<String,dynamic> json){
    return member(
      m_id:json["m_id"] as int,
      m_name:json["m_name"] as String,
      m_batch:json['m_batch'] as String
    );
  }

  int getID(){
    return m_id;
  }

  @override
  String toString(){
    return 'member{id: $m_id, name: $m_name, batch :$m_batch }';
  }
}
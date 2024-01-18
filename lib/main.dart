import 'package:flutter/material.dart';
import 'package:flutter_restfull/api_service.dart';
import 'package:flutter_restfull/member.dart';

main()=> runApp(MemberApp());

class MemberApp extends StatelessWidget {
  const MemberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MembersApp(),
    );
  }
}

class MembersApp extends StatefulWidget {
  const MembersApp({super.key});

  @override
  State<MembersApp> createState() => _MembersAppState();
}

class _MembersAppState extends State<MembersApp> {

  final ApiService service = ApiService();
  late Future<List<member>> memberList;
  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _batchCont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    memberList = service.getMember();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member List'),backgroundColor:Colors.blue,),
      body: Center(
        child: FutureBuilder<List<member>>(
          future: memberList,
          builder: (BuildContext context,AsyncSnapshot snapshot){
           if(!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                var data = snapshot.data[index] as member;
                return Card(
                  child: ListTile(
                    title: Text(data.toString()),
                  ),
                );
              }
              );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayDialog,
        child: const Icon(Icons.add),
      ),
    );
  }


  Future<void> _displayDialog() async{
    return showDialog<void>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add a member'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(color: Colors.pink, thickness: 3.0,),
                TextField(
                  controller: _nameCont,
                  decoration: const InputDecoration(
                    hintText: 'Enter member name'
                  ),
                ),
                TextField(
                  controller: _batchCont,
                  decoration: const InputDecoration(
                    hintText: 'Enter member batch'
                  ),
                ),
              ],
            ),
          
          ),
        actions: <Widget>[
          TextButton(onPressed: (){
            String name = _nameCont.text;
            String batch = _batchCont.text;
            int id = 0;
            var _member = member(m_id: 0,m_name: name,m_batch: batch);
            service.createMember(_member);
            setState(() {
              memberList = service.getMember();
            });
            Navigator.of(context).pop();
            ClearContent();
          }, child: const Text('Add a record')),
          TextButton(onPressed: (){
            ClearContent();
            Navigator.of(context).pop();
          }, child: const Text('Cancel'))
        ],
        );
      }
      
      );
  }

  void ClearContent(){
    _nameCont.clear();
    _batchCont.clear();
  }

}
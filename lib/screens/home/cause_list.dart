import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cause_card.dart';
import 'package:pyde/models/cause.dart';

class CauseList extends StatefulWidget {
  @override
  _CauseListState createState() => _CauseListState();
}

class _CauseListState extends State<CauseList> {
  @override
  Widget build(BuildContext context) {
    final causes = Provider.of<List<Cause>>(context) ?? [];
    return ListView.builder(
        itemCount: causes.length,
        itemBuilder: (context, index) {
          if (causes[index].access == 'public') {
            return CauseCard(cause: causes[index]);
          } else {
            return Text('');
          }
        });
  }
}

import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  const ContactPage({Key key, this.contact}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

mixin Contact {}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

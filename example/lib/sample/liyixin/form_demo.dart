import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class FormDemo extends StatefulWidget {
  const FormDemo({Key? key}) : super(key: key);

  @override
  State<FormDemo> createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final _nameKey = GlobalKey();
  final _pwdKey = GlobalKey();
  String? _name;
  String? _pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Form',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'input number',
                  errorText: 'error啦',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusColor: Colors.orange),
              keyboardType: TextInputType.number,
              onSaved: (value) {},
              onChanged: (value) {
                print(value);
              },
              validator: (value) {
                if (value == null) return 'empty';
                return value.length > 2 ? null : 'at least 2 char';
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            Divider(),
            TextFormField(
              key: _nameKey,
              decoration: InputDecoration(hintText: '请输入账号'),
              onSaved: (value) {
                _name = value;
              },
              validator: (value) {
                if (value == null) '请输入';
                return value!.length >= 6 ? null : '账号至少6个字符';
              },
            ),
            TextFormField(
                key: _pwdKey,
                decoration: InputDecoration(hintText: '请输入密码'),
                obscureText: true,
                onSaved: (value) {
                  _pwd = value;
                },
                validator: (value) {
                  if (value == null) '请输入';
                  return value!.length >= 6 ? null : '密码至少6个字符';
                }),
            ElevatedButton(
              onPressed: () {
                (_nameKey.currentState as FormFieldState).save();
                (_pwdKey.currentState as FormFieldState).save();
                _login(); //回调onSave
              },
              child: Text('登录'),
            ),
            AbsorbPointer(
              child: ElevatedButton(
                  onPressed: () {
                    BrnToast.show('clicked', context);
                  },
                  child: Text('套一层AbsorbPointer后禁止点击\n适用统一处理多个组件的场景')),
            )
          ],
        ),
      ),
    );
  }

  _login() {
    BrnToast.show('name:${_name}, pwd:${_pwd}', context);
  }
}

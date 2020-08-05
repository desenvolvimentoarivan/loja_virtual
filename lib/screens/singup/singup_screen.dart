import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome Completo',
                  ),
                  validator: (name) {
                    if (name.isEmpty)
                      return 'Campo obrigatório';
                    else if (name.trim().split(' ').length <= 1)
                      return 'Preencha seu Nome Completo';
                    else
                      return null;
                  },
                  onSaved: (name) => user.name = name,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email.isEmpty)
                      return 'Campo obrigatório';
                    else if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                  onSaved: (email) => user.email = email,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      return 'Campo obrigatório';
                    else if (pass.length < 6)
                      return 'Preencha senha com 6 caracteres';
                    else
                      return null;
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Repita Senha',
                  ),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      return 'Campo obrigatório';
                    else if (pass.length < 6)
                      return 'Preencha senha com 6 caracteres';
                    else
                      return null;
                  },
                  onSaved: (pass) => user.confirmPass = pass,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        formkey.currentState.save();
                      }

                      if (user.password != user.confirmPass) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Senhas diferentes'),
                          backgroundColor: Colors.redAccent,
                        ));
                        return;
                      }
                      context.read<UserManager>().signUp(
                          user: user,
                          onSucess: () {
                            debugPrint('sucesso');
                          },
                          onFail: (e) {
                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Falha ao Cadastrar: $e'),
                              backgroundColor: Colors.redAccent,
                            ));
                          });
                    },
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    child: Text('Criar Conta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

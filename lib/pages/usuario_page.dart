// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/usuario.dart';
import '../repository/usuario_repository.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key? key}) : super(key: key);

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent.shade700,
      ),
      backgroundColor: Colors.blueGrey.shade100,
      body: Padding(
        padding: EdgeInsets.all(10),
        //
        // APRESENTAÇÃO DOS RESULTADOS
        //
        child: FutureBuilder<List<Usuario>>(
          //Requisição da API
          future: UsuarioRepository().getUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              //Erro
              return Center(
                child: Text('Ocorreu um erro'),
              );
            } else if (snapshot.hasData) {
              //Sucesso
              var dados = snapshot.data;
              return GridView.builder(
              //Número de colunas
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
				//Número de colunas
				crossAxisCount: 2,
              ),
              // TOTAL DE ITENS
              itemCount: dados!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(5),
                  color: Colors.deepPurple.shade100,
                  shadowColor: Colors.blueGrey,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            dados[index].foto,
                          ),
                        ),
                        Text(
                          dados[index].nome,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.heebo(fontSize: 24),
                        ),
                        Text(
                          dados[index].email,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                        Text(
                          dados[index].telefone,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            } else {
              //Processando
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

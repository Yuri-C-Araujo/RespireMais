import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: EdgeInsets.all(12),
              decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 6,
              offset: Offset(1, 3),
            ),
          ],
        ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              heightFactor: 0.5,
              child: Image.asset(
                'assets/Respire.png',
                height: 280,
              ),
            ),
            Text(
              'OLÁ, JOÃO',
              style: TextStyle(
                fontSize: 28,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
                height: 2,
              ),
            ),
            Column(
              children: [
                Container(
                  width: 450,
                  height:95,
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 5)
                      ),
                    ],
                  ),

                  child:Column(
                  children: [
                  Center(
                      child: Text('13/04 - Dor 5/10 | Fadiga: Moderada |Efeito Colateral: Tosse',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                      ),
                  ),
                  ],
                  ),
                ),
                Container(
                  width: 450,
                  height:95,
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 6,
                          offset: Offset(2, 5)
                      ),
                    ],
                  ),

                  child:Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('12/04 - Dor 3/10 | Fadiga: leve',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  height:95,
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 6,
                          offset: Offset(2, 5)
                      ),
                    ],
                  ),

                  child:Column(
                    children: [
                      Center(
                        child: Text('11/04 - Dor 8/10 | Fadiga Intensa |Efeito Colateral: Náusea',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  height:95,
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 6,
                          offset: Offset(2, 5)
                      ),
                    ],
                  ),

                  child:Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('10/04 - Dor 0/10 | Fadiga: Leve',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 100),
              ElevatedButton(
                  onPressed: (){},
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                   foregroundColor: Colors.white,
                   elevation: 6,
                   maximumSize: Size(450, 80),
                   padding: EdgeInsets.all(18),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),

                   ),
                 ),
                child:
                Text('Gerar PDF / Compartilhar com médico',

                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.w900,
                   ),
                 ),
               ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}
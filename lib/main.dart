import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinacontroller = TextEditingController();
  String _resultado = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculaCombustivelIdeal() {
    double vEtanol = double.parse(etanolController.text.replaceAll(",", "."));
    double vGasolina =
        double.parse(gasolinacontroller.text.replaceAll(",", "."));
    double proporcao = vEtanol / vGasolina;

    // if(proporcao < 0.7) {
    //   _resultado = "Abasteça com Etanol";
    // } else {
    //   _resultado = "Abasteça com Gasolina";
    // }

    //o bloco acima é o mesmo que:
    setState(() {
      _resultado = "Abasteça com ";
      _resultado += (proporcao < 0.7) ? "Etanol" : "Gasolina";
    });
  }

  void _reset() {
    gasolinacontroller.text = "";
    etanolController.text = "";
    setState(() {
      _resultado = "Informe os dados";  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Etanol ou Gasolina?",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _reset();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                TextFormField(
                  controller: etanolController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe corretamente o valor do Etanol";
                    } else {
                      if (double.parse(value.toString().replaceAll(",", ".")) <= 0) {
                        return "O valor do Etanol precisa ser positivo!";
                      }
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.lightBlue[900], fontSize: 26),
                  decoration: InputDecoration(
                      labelText: "Valor do Etanol",
                      labelStyle: TextStyle(color: Colors.lightBlue[900])),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: gasolinacontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe corretamente o valor do Gasolina";
                    } else {
                      if (double.parse(value.toString().replaceAll(",", ".")) <= 0) {
                        return "O valor do Gasolina precisa ser positivo!";
                      }
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.lightBlue[900], fontSize: 26),
                  decoration: InputDecoration(
                      labelText: "Valor da gasolina",
                      labelStyle: TextStyle(color: Colors.lightBlue[900])),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          _calculaCombustivelIdeal();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[900]),
                      child:
                          const Text("confirmar", style: TextStyle(fontSize: 25)),
                    ),
                  ),
                ),
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightBlue[900], fontSize: 26),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
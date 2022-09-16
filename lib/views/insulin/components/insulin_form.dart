import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../api/providers/insulin_provider.dart';
import '../../../components/my_dialog_box.dart';
import '../../../utils/helpers.dart';

class InsulinFormComponent extends StatefulWidget {
  const InsulinFormComponent({Key? key}) : super(key: key);

  @override
  State<InsulinFormComponent> createState() => _InsulinFormComponentState();
}

class _InsulinFormComponentState extends State<InsulinFormComponent> {
  int hour = 0, glycemia = 0;
  bool isLoading = false;
  String typeInsulin = "", mark = "";

  List<DropdownMenuItem<int>> get insulinHourItems {
    return [for (var i = 0; i < 24; i++) i]
        .map<DropdownMenuItem<int>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text("${e}h"),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<String>> get insulinTypeItems {
    return const [
      DropdownMenuItem(
        value: "oral",
        child: Text("Voie orale"),
      ),
      DropdownMenuItem(
        value: "injection",
        child: Text("Par injection"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        // color: Colors.deepOrange,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // vertical: 8.0,
          horizontal: 15,
        ),
        child: Form(
          child: Column(
            children: [
              //Titre du formulaire
              Container(
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Ajouter une prise d\'insuline'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //Type d'inuline
              DropdownButtonFormField(
                hint: const Text('Type d\'insuline'),
                isExpanded: true,
                elevation: 5,
                items: insulinTypeItems,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    typeInsulin = newValue ?? "";
                  });
                },
              ),
              const SizedBox(height: 20),
              //Marque
              TextFormField(
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Marque de l\'insuline',
                  // hintText: 'Example : 100',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {
                    mark = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              //Heure de prise
              DropdownButtonFormField(
                hint: const Text('Heure de prise'),
                isExpanded: true,
                elevation: 5,
                // value: sleepEnd,
                items: insulinHourItems,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    hour = newValue ?? 0;
                  });
                },
              ),
              const SizedBox(height: 20),
              //Glycémie
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(signed: false),
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Glycémie (en mg/dL) ',
                  hintText: 'Example : 100',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {
                    glycemia = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              //Bouton de soumission
              Container(
                constraints: BoxConstraints(
                  minWidth: screenSize.width,
                  minHeight: 50.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(10, 10),
                  ),
                ),
                child: !isLoading
                    // ignore: deprecated_member_use
                    ? RaisedButton(
                        onPressed: () {
                          savingInsulin();
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(10, 10),
                          ),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: screenSize.width,
                              minHeight: 50.0,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Enregistrer",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.deepOrange,
                          strokeWidth: 5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savingInsulin() {
    setState(() {
      isLoading = true;
    });

    InsulinProvider insulinProvider =
        Provider.of<InsulinProvider>(context, listen: false);

    insulinProvider.saveInsulin({
      "type": typeInsulin,
      "mark": mark,
      "hour": hour,
      "glycemia": glycemia,
    }).then((Map<String, dynamic> data) {
      setState(() {
        isLoading = false;
      });
      //if bad token, redirect automatically on login view without come back possibility
      if (data['unauthorized']) {
        Navigator.pushReplacementNamed(context, "/login");
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title:
                data['result'] ? "Succès".toUpperCase() : "Echec".toUpperCase(),
            description: data['message'],
          );
        },
      );
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });

      print("Erreuuuur :=> " + error.toString());

      showSnackbar(context,
          "Quelque chose s'est mal passé : veuilez réessayer ! \nSi le problème persiste, contactez le service support",
          duration: 5000);
    });
  }

  //
}

import 'package:bgm/components/button_widget.dart';
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
  int? hour, glycemia;
  bool isLoading = false;
  String? typeInsulin, mark;

  TextEditingController markController = TextEditingController();
  TextEditingController glycemiaController = TextEditingController();

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
  void dispose() {
    super.dispose();
    markController.dispose();
    glycemiaController.dispose();
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
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  //Titre du formulaire
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Ajouter une prise d\'insuline'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: screenSize.width < 460 ? 20 : 30,
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
                    value: typeInsulin,
                    items: insulinTypeItems,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: !isLoading
                        ? (String? newValue) {
                            setState(() {
                              typeInsulin = newValue ?? "";
                            });
                          }
                        : null,
                  ),
                  const SizedBox(height: 20),
                  //Marque
                  TextFormField(
                    controller: markController,
                    enabled: !isLoading,
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
                    value: hour,
                    items: insulinHourItems,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: !isLoading
                        ? (int? newValue) {
                            setState(() {
                              hour = newValue ?? 0;
                            });
                          }
                        : null,
                  ),
                  const SizedBox(height: 20),
                  //Glycémie
                  TextFormField(
                    enabled: !isLoading,
                    controller: glycemiaController,
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
                  ButtonWidget(
                      isLoading: isLoading,
                      onPressed: () {
                        savingInsulin();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savingInsulin() {
    FocusManager.instance.primaryFocus?.unfocus();
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
      reinitializeForm();
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
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          );
        },
      );
    }).onError((error, stackTrace) {
      reinitializeForm();
      setState(() {
        isLoading = false;
      });

      print("Erreuuuur :=> " + error.toString());

      showSnackbar(context,
          "Quelque chose s'est mal passé : veuilez réessayer ! \nSi le problème persiste, contactez le service support",
          duration: 5000);
    });
  }

  reinitializeForm() {
    setState(() {
      typeInsulin = null;
      mark = null;
      hour = null;
      glycemia = null; 
      markController.text = ' ';
      glycemiaController.text = ' ';
    });
  }

  //
}

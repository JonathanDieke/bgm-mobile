import 'package:bgm/components/button_widget.dart';
import 'package:bgm/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../api/providers/sleep_provider..dart';
import '../../../components/my_dialog_box.dart';
import '../../../utils/helpers.dart';

class SleepForm extends StatefulWidget {
  SleepForm({Key? key}) : super(key: key);

  @override
  State<SleepForm> createState() => _SleepFormState();
}

class _SleepFormState extends State<SleepForm> {
  int? startHour, endHour, glycemiaBefore, glycemiaAfter;
  bool isLoading = false;

  TextEditingController startHourController = TextEditingController();
  TextEditingController endHourController = TextEditingController();
  TextEditingController glycemiaBeforeController = TextEditingController();
  TextEditingController glycemiaAfterController = TextEditingController();

  List<DropdownMenuItem<int>> get sleepHourItems {
    return [for (var i = 0; i < 24; i++) i]
        .map<DropdownMenuItem<int>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text("${e}h"),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    glycemiaBeforeController.dispose();
    glycemiaAfterController.dispose();
    endHourController.dispose();
    startHourController.dispose();
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
                      'Ajouter un temps de sommeil'.toUpperCase(),
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
                  //Heure de début
                  DropdownButtonFormField(
                    hint: const Text('Heure de début'),
                    isExpanded: true,
                    elevation: 5,
                    value: startHour,
                    items: sleepHourItems,
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
                              startHour = newValue ?? 0;
                            });
                          }
                        : null,
                  ),
                  const SizedBox(height: 20),
                  //Heure de fin
                  DropdownButtonFormField(
                    hint: const Text('Heure de fin'),
                    isExpanded: true,
                    elevation: 5,
                    value: endHour,
                    items: sleepHourItems,
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
                              endHour = newValue ?? 0;
                            });
                          }
                        : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: !isLoading,
                    controller: glycemiaBeforeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: false),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Glycémie avant le sommeil (en mg/dL) ',
                      hintText: 'Example : 100',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        glycemiaBefore = int.parse(value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: !isLoading,
                    controller: glycemiaAfterController,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: false),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Glycémie après le sommeil (en mg/dL) ',
                      hintText: 'Example : 100',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        glycemiaAfter = int.parse(value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  //Bouton de soumission
                  ButtonWidget(
                    isLoading: isLoading,
                    onPressed: () {
                      savingSleep();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savingSleep() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isLoading = true;
    });

    SleepProvider sleepProvider =
        Provider.of<SleepProvider>(context, listen: false);

    sleepProvider.saveSleep({
      "start_hour": startHour,
      "end_hour": endHour,
      "glycemia_before": glycemiaBefore,
      "glycemia_after": glycemiaAfter
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
          duration: Constants.durationShowSnackbar);
    });
  }

  reinitializeForm() {
    setState(() {
      startHour = null;
      endHour = null;
      glycemiaBefore = null;
      glycemiaAfter = null;
      startHourController.text = ' ';
      endHourController.text = ' ';
      glycemiaBeforeController.text = ' ';
      glycemiaAfterController.text = ' ';
    });
  }

  //fin - Make with Love by JonathanDieke
}

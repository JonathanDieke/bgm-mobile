import 'package:bgm/api/models/daily_data.dart';
import 'package:bgm/api/providers/daily_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';

import '../../../components/my_dialog_box.dart';
import '../../../utils/helpers.dart';

class DailyDataForm extends StatefulWidget {
  DailyDataForm({Key? key}) : super(key: key);

  @override
  State<DailyDataForm> createState() => _DailyDataFormState();
}

class _DailyDataFormState extends State<DailyDataForm> {
  final hyperglycemieController = TextEditingController();
  final hypoglycemieController = TextEditingController();
  var isSickController = TextEditingController();

  var tooltipController = JustTheController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // print(DateTime.now().toString().split(" ")[0] != null);

    return Consumer<DailyDataProvider>(
      builder: (context, dailyDataProvider, child) {
        print('daily data form notifié');
        dailyDataProvider.getDailyData().then((value) {
          // print("getDailyData :=> ${dailyDataProvider.toString()}");
          hyperglycemieController.text =
              dailyDataProvider.dailyData.nbHyperglycemia.toString();
          hypoglycemieController.text =
              dailyDataProvider.dailyData.nbHypoglycemia.toString();
          isSickController = TextEditingController(
              text: "${dailyDataProvider.dailyData.isSick}");
        });
        return Card(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Titre
                const Text(
                  "Données quotidiennes",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          // Hyperglycémie
                          Expanded(
                            // child: Column(
                            //   children: [
                            //     const Text("Nombre d'hyperglycémie :"),
                            //     NumberInputPrefabbed
                            //         .roundedEdgeButtons(
                            //       controller:
                            //           TextEditingController(),
                            //       incDecBgColor: Colors.deepOrange
                            //           .withOpacity(0.75),
                            //       min: 0,
                            //     ),
                            //   ],
                            // ),
                            child: TextFormField(
                              controller: hyperglycemieController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false),
                              decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                labelText: "Nombre d'hyperglycémie :",
                                hintText: 'Depuis le début de la journée',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // Hypoglycémie
                          Expanded(
                            child: TextFormField(
                              controller: hypoglycemieController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false),
                              decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                labelText: "Nombre d'hypoglycémie :",
                                hintText: 'Depuis le début de la journée',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Is Sick ?
                      Row(
                        children: [
                          Expanded(
                            child: SelectFormField(
                              controller: isSickController,
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              labelText: 'Êtes-vous souffrant(e) ?',
                              items: const [
                                {
                                  'value': 0,
                                  'label': 'Non',
                                  "enable": true,
                                  'icon': null,
                                  'textStyle': null
                                },
                                {
                                  'value': 1,
                                  'label': 'Oui',
                                }
                              ],
                              onChanged: (val) {
                                isSickController.text = val;
                                print(isSickController.text);
                              },

                              onSaved: (val) {},
                            ),
                          ),
                          JustTheTooltip(
                            controller: tooltipController,
                            isModal: true, // to show modal when clicking
                            onShow: () {},
                            content: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Êtes-vous souffrant(e) d\'une maladie quelconque autre que le diabète ? (Ex.: Toux, rhume, paludisme, grippe, etc)',
                              ),
                            ),
                            child: const Material(
                              color: Colors.white,
                              shape: CircleBorder(),
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.info,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          dailyDataProvider.clearSP();
                        },
                        child: Text("clear SP"),
                      ),
                      //bouton de soumission
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
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
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  savingDailyData();
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
                                    child: Text(
                                      dailyDataProvider.isForCurrentDay()
                                          ? "Mettre à jour"
                                          : "Créer",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
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
              ],
            ),
          ),
        );
      },
    );

    //
  }

  void savingDailyData() {
    // print('daily saving..');
    // print('daily saving.. ${hyperglycemieController.text}');
    setState(() {
      isLoading = true;
    });

    DailyDataProvider dailyDataProvider =
        Provider.of<DailyDataProvider>(context, listen: false);

    dailyDataProvider
        .saveDailyData(
            int.parse(hyperglycemieController.text),
            int.parse(hypoglycemieController.text),
            int.parse(isSickController.text))
        .then((Map<String, dynamic> data) {
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
            title: data['result'] ? "Succès" : "Echec",
            description: data['message'],
          );
        },
      );
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });

      showSnackbar(context,
          "Quelque chose s'est mal passé : veuilez réessayer ! \nSi le problème persiste, contactez le service support",
          duration: 5000);
    });
  }
//
}

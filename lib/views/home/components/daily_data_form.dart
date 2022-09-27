import 'package:bgm/api/models/daily_data.dart';
import 'package:bgm/api/providers/daily_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';

import '../../../components/button_widget.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    DailyDataProvider.getDailyData().then((dailyData) {
      hyperglycemieController.text = dailyData.nbHyperglycemia.toString();
      hypoglycemieController.text = dailyData.nbHypoglycemia.toString();
      setState(() {
        isSickController = TextEditingController(text: "${dailyData.isSick}");
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Consumer<DailyDataProvider>(
      builder: (context, dailyDataProvider, child) {
        // DailyDataProvider.getDailyData().then((dailyData) {
        //   hyperglycemieController.text = dailyData.nbHyperglycemia.toString();
        //   hypoglycemieController.text = dailyData.nbHypoglycemia.toString();
        //   setState(() {
        //     isSickController =
        //         TextEditingController(text: "${dailyData.isSick}");
        //   });
        //   print("is sick ? : ${dailyData.isSick}");
        // });
        return Card(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Titre
                const Text(
                  "Mon état physique quotidien",
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
                            child: TextFormField(
                              enabled: !isLoading,
                              controller: hyperglycemieController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: false,
                              ),
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
                              enabled: !isLoading,
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
                              enabled: !isLoading,
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
                      const SizedBox(
                        height: 24,
                      ),
                      //bouton de soumission
                      ButtonWidget(
                        isLoading: isLoading,
                        onPressed: () {
                          savingDailyData();
                        },
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
    FocusManager.instance.primaryFocus?.unfocus();
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

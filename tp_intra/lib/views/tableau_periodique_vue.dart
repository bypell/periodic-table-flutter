import 'package:flutter/material.dart';
import 'package:tp_intra/models/element_data.dart';
import 'package:tp_intra/data/PeriodicTableJSON.json.dart';
import 'package:tp_intra/utils/constants.dart';
import 'package:tp_intra/widgets/tableau_periodique.dart';

import "dart:convert";

class TableauPeriodiqueVue extends StatefulWidget {
  const TableauPeriodiqueVue({super.key});

  @override
  State<TableauPeriodiqueVue> createState() => _TableauPeriodiqueVueState();
}

class _TableauPeriodiqueVueState extends State<TableauPeriodiqueVue> {
  late final List<ElementData> listeElements;
  late final List<List<ElementData?>> tableauGridData;
  RegleDeCouleur regleDeCouleurs = RegleDeCouleur.element;
  num valeurRegleDeCouleursMin = 0;
  num valeurRegleDeCouleursMax = 0;

  void _loadElements() async {
    // Pour faire la conversion du JSON dans une map
    final Map<String, dynamic> tableauEnJson = jsonDecode(jsonTablePer);

    // Consume la liste
    listeElements = (tableauEnJson["elements"] as List<dynamic>)
        .map((e) => ElementData.fromJson(e))
        .toList();

    // recherche des valeurs maximales de xpos et ypos pour connaitre les dimensions du tableau
    int maxXPos = listeElements
        .map((element) => element.xPos)
        .reduce((value, element) => value > element ? value : element);
    int maxYPos = listeElements
        .map((element) => element.yPos)
        .reduce((value, element) => value > element ? value : element);

    // création d'une liste de colonnes d'éléments en utilisant les propriétés "xPos" et "yPos" pour les positionner dedant
    tableauGridData = List.generate(maxXPos, (i) => List.filled(maxYPos, null));
    for (var element in listeElements) {
      var xIndex = element.xPos - 1;
      var yIndex = element.yPos - 1;

      tableauGridData[xIndex][yIndex] = element;
    }
  }

  // applelée pour ajuster les valeurs (températures) min et max de la métrique voulue à appliquer au tableau
  // regarde la règle de couleur et va chercher les valeurs min et max de boil ou melt de tous les éléments
  void _ajusterRegleDeCouleursValeursMinMax() async {
    void setMinMaxAvecPropriete(Function(ElementData) propriete) {
      valeurRegleDeCouleursMin = listeElements
          .map(propriete)
          .reduce((value, element) => value < element ? value : element);
      valeurRegleDeCouleursMax = listeElements
          .map(propriete)
          .reduce((value, element) => value > element ? value : element);
    }

    if (regleDeCouleurs == RegleDeCouleur.element) {
      valeurRegleDeCouleursMin = 0;
      valeurRegleDeCouleursMax = 0;
    } else if (regleDeCouleurs == RegleDeCouleur.ebulition) {
      setMinMaxAvecPropriete((element) => element.boil);
    } else if (regleDeCouleurs == RegleDeCouleur.fusion) {
      setMinMaxAvecPropriete((element) => element.melt);
    }
    //print("min: $valeurRegleDeCouleursMin");
    //print("max: $valeurRegleDeCouleursMax");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // au début, il faut charger les éléments et ajuster les valeurs min et max
      _loadElements();
      _ajusterRegleDeCouleursValeursMinMax();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAL tableau périodique'),
      ),
      body: TableauPeriodique(
        gridData: tableauGridData,
        regleDeCouleurs: regleDeCouleurs,
        valeurRegleDeCouleursMin: valeurRegleDeCouleursMin,
        valeurRegleDeCouleursMax: valeurRegleDeCouleursMax,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Configuration'),
            ),
            Center(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: RegleDeCouleur.element,
                    child: Text('Élément'),
                  ),
                  DropdownMenuItem(
                    value: RegleDeCouleur.ebulition,
                    child: Text('Ébulition'),
                  ),
                  DropdownMenuItem(
                    value: RegleDeCouleur.fusion,
                    child: Text('Fusion'),
                  ),
                ],
                value: regleDeCouleurs,
                onChanged: (RegleDeCouleur? value) {
                  setState(() {
                    regleDeCouleurs = value!;
                    _ajusterRegleDeCouleursValeursMinMax();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

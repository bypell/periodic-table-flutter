import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tp_intra/models/element_data.dart';
import 'package:tp_intra/utils/constants.dart';
import 'package:tp_intra/widgets/cellule_types.dart';

class TableauPeriodique extends StatefulWidget {
  final List<List<ElementData?>> gridData;
  final RegleDeCouleur regleDeCouleurs;
  final num valeurRegleDeCouleursMin;
  final num valeurRegleDeCouleursMax;

  const TableauPeriodique({
    super.key,
    required this.gridData,
    required this.regleDeCouleurs,
    required this.valeurRegleDeCouleursMin,
    required this.valeurRegleDeCouleursMax,
  });

  @override
  State<TableauPeriodique> createState() => _TableauPeriodiqueState();
}

class _TableauPeriodiqueState extends State<TableauPeriodique> {
  double _valeurRegleDeCouleurs = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool affichageSimplifie = widget.gridData.isNotEmpty &&
          constraints.maxHeight < (widget.gridData[0].length * 42);
      return OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                Expanded(
                  child: _buildListViewTable(affichageSimplifie),
                ),
                if (widget.regleDeCouleurs != RegleDeCouleur.element)
                  _buildRegleDeCouleursSlider(vertical: false),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: _buildListViewTable(affichageSimplifie),
                ),
                if (widget.regleDeCouleurs != RegleDeCouleur.element)
                  _buildRegleDeCouleursSlider(vertical: true),
              ],
            );
          }
        },
      );
    });
  }

  Widget _buildListViewTable(bool affichageSimplifie) {
    return ListView.builder(
      itemCount: widget
          .gridData.length, // nombre d'éléments sera le nombre de colonnes
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          // génération d'une liste de cellules pleines et vides pour chaque colonne en utilisant les données du tableau
          children: List.generate(
            widget.gridData[index].length,
            (i) {
              if (widget.gridData[index][i] == null) {
                return const CelluleVide();
              } else {
                return CelluleElement(
                  element: widget.gridData[index][i]!,
                  celluleSimplifiee: affichageSimplifie,
                  regleDeCouleurs: widget.regleDeCouleurs,
                  valeurRegleDeCouleurs: _valeurRegleDeCouleurs,
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildRegleDeCouleursSlider({bool vertical = false}) {
    // au cas si la valeur est en dehors des limites...
    _valeurRegleDeCouleurs = clampDouble(
        _valeurRegleDeCouleurs,
        widget.valeurRegleDeCouleursMin.toDouble(),
        widget.valeurRegleDeCouleursMax.toDouble());

    return RotatedBox(
      quarterTurns: vertical ? 3 : 0,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: RotatedBox(
                  quarterTurns: vertical ? -3 : 0,
                  child:
                      Text(widget.regleDeCouleurs.toString().split('.').last))),
          Expanded(
            child: Slider(
                value: _valeurRegleDeCouleurs,
                min: widget.valeurRegleDeCouleursMin.toDouble(),
                max: widget.valeurRegleDeCouleursMax.toDouble(),
                label: '${_valeurRegleDeCouleurs.round()} K',
                onChanged: (double valeur) {
                  setState(() {
                    _valeurRegleDeCouleurs = valeur;
                    //print(_valeurRegleDeCouleurs.round());
                  });
                }),
          ),
        ],
      ),
    );
  }
}

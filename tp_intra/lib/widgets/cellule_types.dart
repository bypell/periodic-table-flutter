import 'package:flutter/material.dart';
import 'package:tp_intra/models/element_data.dart';
import 'package:tp_intra/utils/cellule_decoration_helper.dart';
import 'package:tp_intra/utils/constants.dart';
import 'package:tp_intra/widgets/element_info_dialog.dart';

class CelluleVide extends StatelessWidget {
  static const double distanceEntreCellules = 1.0;
  const CelluleVide({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          margin: const EdgeInsets.all(distanceEntreCellules),
        ),
      ),
    );
  }
}

class CelluleElement extends StatelessWidget {
  static const double distanceEntreCellules = 1.0;
  final ElementData element;
  final bool celluleSimplifiee;
  final RegleDeCouleur regleDeCouleurs;
  final num valeurRegleDeCouleurs;

  const CelluleElement(
      {super.key,
      required this.element,
      required this.celluleSimplifiee,
      required this.regleDeCouleurs,
      required this.valeurRegleDeCouleurs});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0, // pour s'assurer que les cellules sont carrées
        child: Padding(
          padding: const EdgeInsets.all(distanceEntreCellules),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ElementInfoDialog(
                      element: element,
                      regleDeCouleurs: regleDeCouleurs,
                      valeurRegleDeCouleurs: valeurRegleDeCouleurs);
                },
              );
            },
            child: Ink(
              // boxdecoration qui dépend de si l'élément a une couleur ou non (soit la couleur, soit un gradient bleu à rouge)
              decoration: getElementBoxDecoration(
                  element: element,
                  regleDeCouleurs: regleDeCouleurs,
                  valeurRegleDeCouleurs: valeurRegleDeCouleurs),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  // Symbole
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      element.symbol,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: celluleSimplifiee ? 18.0 : 28.0,
                      ),
                    ),
                  ),
                  // si la cellule n'est pas simplifiée, on ajoute les autres informations sur l'élément
                  if (!celluleSimplifiee) ...[
                    // Numéro atomique
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        '${element.number}',
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Masse atomique
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        element.atomicMass.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Nom de l'élément
                    Positioned(
                      bottom: 0,
                      child: Text(
                        element.name,
                        style: const TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

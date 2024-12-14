//import 'molecule.dart';

class ElementData implements Comparable<ElementData> {
  // Attributs d'un element
  late final String name;
  late final num atomicMass;
  late final String discoveredBy;
  late final num melt;
  late final String symbol;
  late final List<num> shells;
  late final int xPos;
  late final int yPos;
  late final int number;
  late final String cpkHex;
  late final String category;

  late final num boil;
  late final String phase;
  late final String summary;
  late final String source;

  ElementData(
      this.name,
      this.atomicMass,
      this.discoveredBy,
      this.melt,
      this.symbol,
      this.shells,
      this.xPos,
      this.yPos,
      this.number,
      this.cpkHex,
      this.category,
      this.boil,
      this.phase,
      this.summary,
      this.source);

  ElementData.old(Map<String, dynamic> elementJson) {
    // Recoit l'element a creer
    name = elementJson['name'];
    atomicMass = elementJson['atomic_mass'] ?? 0;
    discoveredBy = elementJson['discovered_by'] ?? '';
    melt = elementJson['melt'] ?? 0;
    symbol = elementJson['symbol'];
    shells = (elementJson['shells'] as List<dynamic>).cast();
    xPos = elementJson['xpos'];
    yPos = elementJson['ypos'];
    number = elementJson['number'];
    cpkHex = elementJson['cpk-hex'] ?? '';
    category = elementJson['category'];
    boil = elementJson['boil'] ?? 0;
    phase = elementJson['phase'] ?? '';
    summary = elementJson['summary'] ?? '';
    source = elementJson['source'] ?? '';
  }

  factory ElementData.fromJson(Map<String, dynamic> elementJson) {
    if (elementJson
        case {
          "name": final String name,
          "atomic_mass": final num
              atomicMass, // DIDIER num car parfois c'est un int
          "discovered_by": final String?
              discoveredBy, // DIDIER avec ? car parfois c'est un null
          "melt": final num? melt, // Parfois int double ou null
          "symbol": final String symbol,
          "shells": final List<dynamic> shells,
          "xpos": final int xPos,
          "ypos": final int yPos,
          "number": final int number,
          "cpk-hex": final String? cpkHex,
          "category": final String category,
          "boil": final num? boil,
          "phase": final String? phase,
          "summary": final String? summary,
          "source": final String? source,
        }) {
      return ElementData(
        name,
        elementJson["atomic_mass"] ?? 0,
        elementJson["discovered_by"] ?? '',
        elementJson["melt"] ?? 0,
        symbol,
        shells.cast(),
        elementJson["xpos"] ?? 0,
        elementJson["ypos"] ?? 0,
        elementJson["number"] ?? 0,
        elementJson["cpk-hex"] ?? '',
        elementJson["category"] ?? '',
        elementJson["boil"] ?? 0,
        elementJson["phase"] ?? '',
        elementJson["summary"] ?? '',
        elementJson["source"] ?? '',
      );
    } else {
      print(elementJson["name"].runtimeType);
      print(elementJson["atomic_mass"].runtimeType);
      print(elementJson["discovered_by"].runtimeType);
      print(elementJson["melt"].runtimeType);
      print(elementJson["symbol"].runtimeType);
      print(elementJson["shells"].runtimeType);
      print(elementJson["xpos"].runtimeType);
      print(elementJson["ypos"].runtimeType);
      print(elementJson["number"].runtimeType);
      print(elementJson["cpk-hex"].runtimeType);
      print(elementJson["category"].runtimeType);
      print(elementJson["boil"].runtimeType);
      print(elementJson["phase"].runtimeType);
      print(elementJson["summary"].runtimeType);
      print(elementJson["source"].runtimeType);
      throw Exception("Element inconnu $elementJson");
    }
  }

  @override
  int compareTo(ElementData autre) {
    return symbol.compareTo(autre.symbol);
  }

  @override
  String toString() {
    return name;
  }
}

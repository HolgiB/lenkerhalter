# Kugelgelenk-Set fuer Fahrradlenker — Ringadapter, Lampenhalter, Lenkererweiterung

Halter, die nicht fest auf einen Lenkerdurchmesser gebaut sind: ein
Kugelsegment-Ring (Ringadapter) wird auf den Lenker gesetzt, der Halter hat
statt der zylindrischen Bohrung einen Kugelsitz. Dadurch laesst sich die Lampe
oder die Erweiterung vor dem Festziehen in ZWEI Achsen ausrichten — noetig bei
geschwungenen Lenkern, Rennlenkern oder wenn die Klemmung schraeg auf einem
gebogenen Abschnitt aufliegt. Ein zylindrischer Ring kann das nicht.

Der Clou: **ein Halter fuer alle Lenker**. Angepasst wird nur der Ringadapter,
und alle Ringadapter sind untereinander austauschbar, weil die Kugel immer
44 mm gross ist.

Entworfen von HolgiB. Nachbauten und Remixe willkommen.

## Dateien

    ringadapter.scad           Kugelsegment-Ring, alle Lenkerdurchmesser
    lampenhalter.scad          wie das Grundmodell, zusaetzlich aufnahme = "kugel"
    lenkererweiterung.scad     wie das Grundmodell, zusaetzlich aufnahme = "kugel"

    STL/Ringadapter_22mm.stl       STL/Lampenhalter_Kugel.stl
    STL/Ringadapter_25-4mm.stl     STL/Lenkererweiterung_Kugel.stl
    STL/Ringadapter_318mm.stl
    STL/Ringadapter_35mm.stl

Von den Haltern gibt es bewusst nur EIN STL je Sorte — sie sind fuer jeden
Lenkerdurchmesser identisch.

## Paarung

    Lenker     Ringadapter        Ringwand    Halter
    22,0 mm    43,94 x 18,00 mm   10,88 mm    identisch
    25,4 mm    43,94 x 18,00 mm    9,18 mm    identisch
    31,8 mm    43,94 x 18,00 mm    5,97 mm    identisch
    35,0 mm    43,94 x 18,00 mm    4,38 mm    identisch

Alle Ringadapter haben aussen dieselben 44 mm und passen damit in jeden Halter
dieses Sets. Nur die Bohrung unterscheidet sich.

## Parameter

    kugel_d   = 44;      // in ALLEN DREI Dateien gleich! Sonst passt die Paarung nicht
    aufnahme  = "kugel"; // im Lampenhalter und in der Lenkererweiterung
    rohr_lenker = 31.8;  // im Ringadapter: der Lenkerdurchmesser (22 bis 35)
    ring_breite = 18;    // Breite der Kugelflaeche
    schlitze    = 2;     // Schlitz, ueber den die Kugel den Lenker klemmt

Alle uebrigen Parameter (Arm, Ausleger, Nasen, Mutterntasche) sind dieselben wie
in den Grundmodellen und dort beschrieben.

**Wichtig:** im Kugelmodus ist der Lenkerdurchmesser fuer die Halter ohne
Bedeutung. Sie werden fuer 22 bis 35 mm identisch — nachgemessen: gleiche
Bounding Box, gleiches Gewicht, gleiche Koerperzahl.

## Wie das Klemmen funktioniert

Ein einziges Schraubenpaar erledigt beides:

1. Der Kugelsitz des Halters wird auf die Kugel gepresst.
2. Die Kugel hat einen Schlitz und gibt den Druck an den Lenker weiter.

Vor dem Festziehen lässt sich der Halter auf der Kugel frei ausrichten, danach
sitzen Lampe und Erweiterung fest. Zum Nachjustieren die beiden M4 loesen,
ausrichten, wieder anziehen.

## Drucken

* PETG, 0,2 mm Schichthoehe, 4 Perimeter, 40 % Infill
* **Keine Stuetzen noetig** — auch beim Ringadapter nicht: seine Wand ist eine
  Kugelzone und weicht ueber die ganze Hoehe nur rund 24 Grad von der Senkrechten
  ab, das druckt jeder FDM-Drucker ohne Stuetzmaterial.
* Ringadapter liegend drucken, Schlitz nach oben.

## Nacharbeit aus der Praxis

* Bohrungen mit dem passenden Bohrer oder leichtem Uebermass nachziehen.
* Muttern mit dem Heissluftfoen einpressen, der knappe Sitz ist gewollt.
* Oberflaechen mit feinem Schleifpapier oder der Metallfeile glaetten.
* Spaltmasse muessen nicht auf den Zehntelmillimeter stimmen.

## Geprueft

Nachgemessen am gerenderten STL:

* Halter in Kugelfassung fuer 22,0 / 25,4 / 31,8 / 35,0 mm identisch
* Lampenhalter: 34,00 x 76,00 x 75,00 mm, 2 Koerper, ~26,9 g
* Lenkererweiterung: 18,00 x 76,00 x 103,00 mm, 3 Koerper, ~45,3 g
* Ringadapter: aussen immer 43,94 x 43,99 x 18,00 mm, 10,2 bis 23,0 g
* Alle warnungsfrei, kein Minkowski
* Die zylindrischen Grundfassungen bleiben unveraendert und wurden
  gegengeprueft (Lenkererweiterung ~54 / ~59,5 / ~61,3 g fuer 22 / 31,8 / 35)

## Grenzen

Die feste Kugel von 44 mm deckt Lenker von 22 bis 35 mm ab. Fuer Lenker ueber
35 mm muesste die Kugel mitwachsen — dann ist der Ring nicht mehr mit den
Haltern dieses Sets austauschbar. Die `assert`s in den Dateien melden das
jeweils mit Ist- und Sollwert, statt still ein zu duennes Teil zu bauen.

## Lizenz

Bitte beim Hochladen waehlen. Vorschlag: CC BY-NC-SA 4.0 fuer private Nachbauten,
kommerzielle Nutzung ausgeschlossen.

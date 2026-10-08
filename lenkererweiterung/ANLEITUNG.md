# Lenkererweiterung — parametrischer Halter fuer Fahrradlenker

Ein durchgehender, lastoptimiert verjuengter Arm, der zwei Schellen verbindet:
aussen eine Schelle fuer den Lenker (22 / 31,8 / 35 mm), innen eine feste
22-mm-Schelle fuer die eigentliche Erweiterung. Typischer Einsatz: zweiter
Lenker, Zusatzrohr, Abstandshalter, Tacho- oder Zubehoertraeger.

Entworfen von HolgiB. Nachbauten und Remixe willkommen.

## Dateien

    lenkererweiterung.scad     das Modell, alle Varianten in einer Datei
    STL/Lenkererweiterung_<d>mm.stl   fertige Netze fuer 22 / 31,8 / 35 mm

## Die drei Lenker-Varianten

Einfach `rohr_lenker` setzen, der Rest rechnet sich mit.
Die Laenge kommt ueber `arm_laenge` (Achsabstand), sinnvoll sind 40 bis 85 mm:

    Lenker    Aussen-D   Nasenmitte   Nasen aussen   Arm unten   Arm oben
    22,0 mm    38,00      25,10        34,10          25,08       15,05
    31,8 mm    47,80      28,90        37,90          31,55       18,93
    35,0 mm    51,00      30,50        39,50          33,66       20,20

Gemessene Bauhoehen (31,8 mm): 18,00 x 75,80 x 102,90 mm
Die 22-mm-Schelle fuer die Erweiterung ist fest und wird per `assert` geprueft.


## Uebliche Lenkerdurchmesser

    d        Bezeichnung     Verbreitung
    22,2 mm  (7/8 Zoll)      BMX, aeltere Mountainbikes
    25,4 mm  (1 Zoll)        ISO-Standardmass, nahezu alle MTB- und Trekkinglenker
    25,8 mm                  noch stark verbreitet bei Rennlenkern
    26,0 mm                  oft bei Rennlenkern
    31,8 mm  (1 1/4 Zoll)    "Oversize", MTB, Rennrad, Downhill
    35,0 mm                  MTB oversized, eher selten

Fuer Rennlenker (25,8 / 26,0) lohnt es, den Wert direkt am Rad zu messen: die
Klemmung sitzt dort oft auf einem gebogenen Abschnitt, wo ein zylindrischer Ring
nicht mehr parallel aufliegt. Fuer solche Faelle gibt es den Kugeladapter.

## Parameter

    rohr_lenker      = 31.8;   // 22 / 31.8 / 35
    rohr_erw         = 22;     // immer 22
    spiel            = 0.25;   // Bohrungsspiel der Rohrbohrung
    wand             = 8;      // Wandstaerke des Schellenzylinders
    schellen_breite  = 18;     // Breite entlang des Rohres
    nase_d           = 0;      // 0 = Nasenbreite = Schellenbreite
    nase_h           = 11;     // Hoehe der Nasenzylinder
    schraube         = 4.1;    // M4 = 4,1 | M3 = 3,44
    trennfuge        = 2;      // Dicke des Schlitzes
    arm_laenge       = 60;     // Abstand der Rohrachsen (Laenge)
    arm_y_rel        = 0.66;   // Armbreite an der Schelle, relativ zum Aussendurchmesser
    arm_verjuengung  = 0.60;   // Restbreite am anderen Ende
    nase_regel       = "formel";       // "formel" | "geometrisch"
    nase_ueberstand  = 12;             // gilt fuer "geometrisch"
    unterlegscheibe_d = 9;             // Aussen-Ø der Unterlegscheibe (M4 = 9)

Das Wichtigste:

* **rohr_lenker** — der Lenkerdurchmesser. 22, 31,8 und 35 mm sind die gaengigen
  Masse. Alles andere skaliert automatisch mit.
* **arm_laenge** — der Achsabstand, also wie weit die Erweiterung vom Lenker weg
  sitzt. Frei waehlbar, 40 bis 80 mm sind praktikabel.
* **arm_y_rel / arm_verjuengung** — Form des Arms. 0,66 an der Schelle (skaliert
  mit dem Lenker), 0,60 am anderen Ende. Verjuengung nur in einer Achse, damit
  die Breite entlang des Rohres der Schellenbreite entspricht.
* **nase_regel** — Position der Nasen. `"formel"` ist die gewachsene Formel
  0,32*(d+4) + Breite - 2. `"geometrisch"` setzt die Nase immer gleich weit
  ueber die Schelle hinaus (`nase_ueberstand`), unabhaengig vom Durchmesser.
  Bei 35 mm ergeben beide praktisch denselben Wert.
* **unterlegscheibe_d** — sorgt dafuer, dass zwischen Schraubenloch und
  Schellenoberflaeche genug Platz fuer eine Unterlegscheibe ist. M4/DIN 125 = 9,
  M5 = 10, M6 = 12. Wird groesser gestellt, wandern die Nasen automatisch nach
  aussen und werden laenger.
* **spiel** — 0,25 mm Bohrungsspiel. Bei klemmendem Sitz zuerst Temperatur und
  Flow pruefen, dann das Spiel erhoehen; nachbohren geht immer.

## Schrauben

Die beiden Schellenhaelften werden ueber vier Nasen mit zwei Schrauben
zusammengezogen. Vorgesehen ist M4 (`schraube = 4.1`), M3 geht mit 3,44.
Unterlegscheiben passen durch die automatische Nasenpositionierung.

## Drucken

* PETG, 0,2 mm Schichthoehe, 4 Perimeter, 40 % Infill
* **Keine Stuetzen noetig.** Die Nasen sind so breit wie die Schelle, damit sie
  ohne Stuetzmaterial sauber ausdrucken.
* Hoher `$fn` (120) ist Absicht — er kostet nur Rechenzeit, nicht Druckqualitaet.

## Montage

1. Untere Schellenhaeften an den Lenker bzw. an das 22-mm-Rohr legen.
2. Obere Haelften aufsetzen, Arm dazwischen.
3. Zwei M4 von oben durch die Nasenpaare, Muttern von unten.
4. Erst gleichmaessig handfest anziehen, dann fest — sonst verkanntet der Arm.

## Nacharbeit aus der Praxis

Die Toleranzen sind bewusst so, dass sie sich nacharbeiten lassen:

* Bohrungen mit dem passenden Bohrer oder leichtem Uebermass nachziehen.
* Muttern mit dem Heissluftfoen einpressen — der knappe Sitz ist gewollt.
* Raue Oberflaechen mit feinem Schleifpapier oder der Metallfeile glaetten.
* Ob 0,1 oder 0,12 mm Spaltmass, spielt bei einem Ender 3 keine grosse Rolle.
  Schrumpfverhalten des Filaments und Ueberextrusion sind die groesseren Effekte.

## Geprueft

Nachgemessen am gerenderten STL (31,8 mm):

* Breite entlang des Rohres: 18,00 mm exakt in allen drei Varianten
* Drei getrennte Koerper je Variante: Hauptteil mit Arm und zwei Kappen
  (Klemmung funktioniert, der Arm ueberbrueckt keine Trennfuge)
* Abstand Schraubenlochmitte zur Schellenoberflaeche: 5,32 / 5,00 / 5,00 mm.
  Eine M4-Unterlegscheibe (DIN 125, Ø9) braucht 4,5 mm — passt mit 0,5 mm Luft.
  Ohne die Untergrenze in `lochpos` waeren es bei 31,8 und 35 mm nur 3,56 bzw.
  2,98 mm, die Scheibe wuerde anstossen.
* Volumen 46865 mm3, entspricht etwa 60 g PETG
* Nasenposition mit Holgis aktuellem Faktor 0,35; bei 31,8 und 35 mm greift die
  Untergrenze fuer die Unterlegscheibe
* Laengenvarianten gemessen: arm_laenge 40 -> 82,90 mm Bauhoehe, ~48 g
  arm_laenge 85 -> 127,90 mm Bauhoehe, ~73 g
* Rendert warnungsfrei, kein Minkowski (schnell und robust)

## Lizenz

Bitte beim Hochladen waehlen. Vorschlag: CC BY-NC-SA 4.0 fuer private Nachbauten,
kommerzielle Nutzung ausgeschlossen.

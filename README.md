# Lenkerhalter fuer Fahrraeder (OpenSCAD)

Parametrische Halter, die aus Holgis gewachsenem OpenSCAD-Bestand
weiterentwickelt wurden. Alles PETG-druckbar ohne Stuetzmaterial, kein
Minkowski, hoher `$fn` als Absicht.

## Inhalt

    lenkererweiterung/   zwei Schellen mit durchgehendem, lastoptimiert
                         verjuengtem Arm. Aussen 22 / 31,8 / 35 mm Lenker,
                         innen fest 22 mm fuer die Erweiterung.
    lampenhalter/        Schelle plus Arm und liegendem Zylinder in der
                         Lenkerachse, an dem der Scheinwerfer mit zwei
                         Unterlegscheiben geklemmt wird. Drei Kugeln mit
                         Huellflaeche stuetzen gegen Flattern.

    kugelgelenk/         Kugeladapter plus beide Halter mit Kugelsitz. Damit
                         laesst sich die Lampe vor dem Festziehen in zwei
                         Achsen ausrichten - fuer geschwungene Lenker und
                         Rennlenker. Ein Halter passt fuer jeden
                         Lenkerdurchmesser, angepasst wird nur der Adapter.

Jeder Ordner enthaelt die `.scad`, eine `ANLEITUNG.md` mit Parametertabelle,
Druck- und Montagehinweisen sowie fertige STL unter `STL/`.

## Kurz zu den Parametern

Alle Teile haben einen Parameterblock am Dateianfang; im Kugelgelenk muss
`kugel_d` in allen drei Dateien gleich sein, sonst passt die Paarung nicht.
Die Dateien pruefen das mit `assert` und brechen mit Meldung ab, statt still
ein zu duennes Teil zu erzeugen.

    rohr_lenker   Lenkerdurchmesser (22 / 25,4 / 31,8 / 35)
    wand          Wandstaerke, 2 mm entspricht 4-5 Perimetern
    nase_regel    Position der Schellennasen
    unterlegscheibe_d  Aussen-Ø der Unterlegscheibe, M4 = 9
    kopf_d        Durchmesser Ausleger und Lampenaufnahme
    aufnahme      "lenker" zylindrisch | "kugel" mit Kugelsitz

## Drucken

PETG, 0,2 mm Schichthoehe, 4 Perimeter, 40 % Infill, kein Stuetzmaterial.
Bohrungen lassen sich mit dem passenden Bohrer nachziehen, Muttern mit dem
Heissluftfoen einpressen - der knappe Sitz ist gewollt.

## Stand

Nachgemessen am gerenderten STL, alle Varianten warnungsfrei:

    Lampenhalter      22 / 31,8 / 35 mm:  ~35 / ~40 / ~41 g
    Lenkererweiterung 22 / 31,8 / 35 mm:  ~54 / ~60 / ~61 g
    Kugelgelenk       beide Halter je einmal ~27 g und ~47 g,
                      Ringadapter 22 bis 35 mm ~10 bis ~23 g

## Lizenz

Noch festzulegen. Vorschlag: CC BY-NC-SA 4.0 fuer private Nachbauten,
kommerzielle Nutzung ausgeschlossen.

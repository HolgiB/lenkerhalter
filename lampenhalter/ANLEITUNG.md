# Lampenhalter — parametrischer Scheinwerferhalter fuer Fahrradlenker

Schelle fuer den Lenker (22 / 31,8 / 35 mm), ein Arm und ein horizontaler
Zylinder parallel zur Lenkerachse, an dem der Scheinwerfer mit zwei
Unterlegscheiben geklemmt wird. Die Laenge dieses Zylinders ist der Offset, den
die Lampe gegenueber der Schelle hat. Eine dreieckige Verstrebung aus drei
Kugeln mit Huellflaeche stuetzt den Ausleger gegen Flattern bei Vibration.

Entworfen von HolgiB. Nachbauten und Remixe willkommen.

## Dateien

    lampenhalter.scad          das Modell
    STL/Lampenhalter_<d>mm.stl   fertige Netze fuer 22 / 31,8 / 35 mm

## Die drei Lenker-Varianten

    Lenker    Bauhoehe
    22,0 mm   34.00 x 68.20 x 70.00 mm   (X -9.0..25.0  Y -34.1..34.1  Z -19.0..51.0)
    31,8 mm   34.00 x 75.80 x 74.90 mm   (X -9.0..25.0  Y -37.9..37.9  Z -23.9..51.0)
    35,0 mm   34.00 x 79.00 x 76.50 mm   (X -9.0..25.0  Y -39.5..39.5  Z -25.5..51.0)

In X immer -9,0 bis +25,0 mm: der Zielzylinder schliesst rechts buendig mit
Arm und Schelle ab, der Ausleger laeuft nach aussen weg.


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

Zusatz fuer gebogene Lenker: ein Kugeladapter (Kugelsegment-Ring, aussen d=40,
18 mm breit, mit Bohrung fuer den Lenker) wird zwischen Lenker und Halter
gesetzt. Der Halter bekommt dazu statt der zylindrischen Aufnahme einen
Kugelsitz (d=38.1). Damit laesst sich die Lampe vor dem Festziehen in zwei
Achsen ausrichten, was bei geschwungenen Lenkern oder schraegem Auflagepunkt
noetig ist.

    rohr_lenker     = 31.8;   // 22 / 31.8 / 35
    spiel           = 0.25;   // Bohrungsspiel der Lenkerschelle
    wand            = 8;      // Wandstaerke der Schelle
    schellen_breite = 18;     // Breite entlang des Rohres
    schraube        = 4.1;    // M4 (Schellenschrauben)
    nase_d          = 0;      // 0 = Nasenbreite = Schellenbreite
    nase_h          = 11;
    trennfuge       = 2;
    nase_regel      = "formel";
    unterlegscheibe_d = 9;    // M4 = 9 | M5 = 10 | M6 = 12

    arm_laenge      = 45;     // Arm bis Kopfmitte (Hoehe)
    arm_y_rel       = 0.66;   // Armbreite an der Schelle
    arm_verjuengung = 0.60;   // Restbreite kurz vor dem Kopf
    arm_eintauchtiefe = 6;    // wie tief der Arm im Korpus sitzt

    kopf_d          = 12;     // Ø Zielzylinder UND Ausleger
    kopf_len_x      = 18;     // Laenge des Zielzylinders = Schellenbreite
    offset_laenge   = 25;     // Laenge des Auslegers = Offset der Lampe
    kopf_bohrung    = 5.1;    // M5 = 5.1 | M6 = 6.1
    mutter_weite    = 8.3;    // M5 = 8.3 | M6 = 10.3
    mutter_tiefe    = 5.5;    // M5 = 4.7+Spiel | M6 = 5.2+Spiel
    fase            = 0.6;    // hexagonale Fase am Taschenmund
    min_wand        = 1.0;    // Mindestwand um die Mutterntasche

    strebe_d        = 6;      // Durchmesser der Kugeln der Verstrebung
    strebe_x2       = 8;      // Kugel 2 unter dem Ausleger, innen
    strebe_x3       = 0;      // 0 = automatisch kurz vor dem Auslegerende
    strebe_end_abstand = 3;   // Luft zwischen Kugel 3 und Auslegerende

Das Wichtigste:

* **kopf_d** — Durchmesser von Zielzylinder und Ausleger. Er muss die
  Mutterntasche mit genug Wand aufnehmen. Der Code prueft das selbst:
  M5 braucht mindestens Ø11,88, M6 mindestens Ø14,19 (bei 1,0 mm Wand).
  Voreinstellung 12 fuer M5, 16 fuer M6.
* **offset_laenge** — wie weit die Lampe seitlich vom Lenker weg sitzt.
* **arm_laenge** — Hoehe des Arms ueber der Lenkerachse.
* **strebe_d / strebe_x2 / strebe_x3** — die Verstrebung. Kugel 1 sitzt an der
  Armbasis, Kugeln 2 und 3 an der Auslegerunterkante. Bei liegend gedrucktem
  Teil ergibt das Material mit grosser Layerhaftung gegen Flattern der Lampe.
* **arm_eintauchtiefe** — wie tief der Arm im Korpus sitzt. Die Huellflaeche
  startet auf einem massiven Block innen statt auf einer duennen Platte an der
  Oberflaeche. Das Lenkerloch wird danach gebohrt und nimmt das Material im Rohr
  wieder weg — dadurch laufen die Uebergaenge glatt aus.

## Schrauben

* Schelle: zwei M4 durch die Nasenpaare, Muttern von unten.
* Lampe: eine M5 (oder M6) axial durch den Ausleger. Die Mutter sitzt in einer
  vertieften Tasche am inneren Ende und wird von der Schellenseite eingelegt,
  die Schraube kommt von der Lampenseite. So zieht die Mutter gegen den Bund.

## Drucken

* PETG, 0,2 mm Schichthoehe, 4 Perimeter, 40 % Infill
* **Keine Stuetzen noetig.** Nasen sind so breit wie die Schelle, der Ausleger
  liegt flach.
* Liegend drucken, sodass der Ausleger flach aufliegt — die Verstrebung wirkt
  dann als Material mit guter Layerhaftung in Zugrichtung.
* Hoher `$fn` (120) ist Absicht.

## Montage

1. Untere Schellenhuelle an den Lenker, obere mit dem Arm aufsetzen.
2. Zwei M4 von oben durch die Nasen, Muttern von unten, handfest anziehen.
3. M5-Mutter mit dem Heissluftfoen in die Tasche einpressen.
4. Lampe mit zwei Unterlegscheiben am Auslegerende ansetzen, M5 von vorne
   durchstecken, festziehen.
5. Zum Schluss die Schellenschrauben endgueltig anziehen.

## Nacharbeit aus der Praxis

* Bohrungen mit dem passenden Bohrer oder leichtem Uebermass nachziehen.
* Muttern mit dem Heissluftfoen einpressen, der knappe Sitz ist gewollt.
* Oberflaechen mit feinem Schleifpapier oder der Metallfeile glaetten.
* Spaltmasse muessen nicht auf den Zehntelmillimeter stimmen: Schrumpfung des
  Filaments und Ueberextrusion durch zu hohe Drucktemperatur sind die
  groesseren Effekte.

## Geprueft

Nachgemessen am gerenderten STL (31,8 mm):

* Bauhoehe 34,00 x 75,80 x 75,90 mm, X von -9,0 bis +25,0
* Zwei getrennte Koerper (Klemmung funktioniert, Arm ueberbrueckt den Schlitz nicht)
* Volumen 32074 mm3, entspricht etwa 41 g PETG
* Mutterntasche und Nennbohrung sind freigestellt; die Wandstaerke um die Tasche
  wird per `assert` geprueft und bricht den Build mit Meldung ab, wenn
  Durchmesser und Mutterweite nicht zusammenpassen.
* Rendert warnungsfrei, kein Minkowski.

## Lizenz

Bitte beim Hochladen waehlen. Vorschlag: CC BY-NC-SA 4.0 fuer private Nachbauten,
kommerzielle Nutzung ausgeschlossen.

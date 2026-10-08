// lampenhalter.scad — parametrisierter Lampenhalter fuer Fahrradlenker
//
// Gleiche Schelle wie lenkererweiterung.scad (ein Zylinder + Nasen als Huellflaeche
// zweier um 90 Grad gedrehter Zylinder, kein minkowski). Statt der zweiten Schelle
// endet der Arm in einem Zylinder:
//   * Zielzylinder Ø kopf_d, Laenge = Schellenbreite, Achse parallel zum Lenker
//   * Lampenausleger gleichen Durchmessers, wird angesetzt, Laenge = Offset
//   * Bohrung AXIAL entlang der Lenkerachse, Mutterntasche mit hexagonaler Fase
//   * die Lampe wird mit zwei U-Scheiben am Auslegerende geklemmt
//
// Werte aus Holgis Vorlagen: Bohrdurchmesser 5.1 fuer M5, Mutterweite 8.3 (8.0+0.3),
// Armbreite = Schellenbreite, Arm verjuengt sich zum Kopfzylinder.
fn = 120;  $fn = fn;

// --- Parameter ------------------------------------------------------------
rohr_lenker   = 31.8;   // 22 / 25.4 / 31.8 / 35
// "lenker" = zylindrische Bohrung auf dem Lenker (wie bisher)
// "kugel"  = Kugelsitz fuer den Ringadapter, Lampe/Erweiterung ausrichtbar
aufnahme      = "lenker";
kugel_d       = 0;      // 0 = automatisch (mindestens Aussendurchmesser des Halters)
spiel         = 0.25;   // Bohrungsspiel der Lenkerschelle
wand          = 8;      // Wandstaerke der Schelle
schellen_breite = 18;   // Armbreite in X
nase_d        = 0;      // 0 = Nasenbreite = Schellenbreite
nase_h        = 11;
schraube      = 4.1;    // M4
trennfuge     = 2;
nase_regel    = "formel";

arm_laenge      = 45;   // Laenge des Arms (Achsabstand Schelle -> Kopfmitte)
arm_mitte_z     = 0;    // 0 = automatisch: Armunterseite knapp ueber der
                        // Trennfuge, damit er die Klemmung nicht ueberbrueckt
arm_y_rel       = 0.66; // Armbreite in Y an der Schelle, bezogen auf Schellen-Aussendurchmesser
arm_verjuengung = 0.60; // Restbreite kurz vor dem Kopf

kopf_d          = 12;   // Durchmesser Zielzylinder UND Lampenausleger.
                        // Holgis IQ-X-E-Halter faehrt d=12 mit der Mutterntasche
                        // im Ausleger (Wand rund 1,1 mm an den Ecken, mit dem
                        // Heissluftfoen eingepresst). M6 braucht d=16.
kopf_len_x      = 18;   // Laenge des Zielzylinders = nur Schellenbreite
offset_laenge   = 25;   // = displayhalter_breite: seitlicher Zylinder, definiert
                        //   den horizontalen Offset des Scheinwerfers
kopf_bohrung    = 5.1;  // M5 = 5.1 | M6 = 6.1
mutter_weite    = 8.3;  // M5 = 8.3 (8.0+0.3) | M6 = 10.3 (10.0+0.3)
mutter_tiefe    = 5.5;  // M5 = 4.7+Spiel | M6 = 5.2+Spiel
fase            = 0.6;

// --- Verstrebung ("Schraege") --------------------------------------------
// Drei Kugeln mit Huellflaeche: knapp ueber der Schelle am Armansatz, unter
// dem Ausleger innen und unter dem Ausleger aussen. Bei liegend gedrucktem
// Teil ergibt das Material mit grosser Layerhaftung gegen Flattern der Lampe.
strebe_d        = 6;                     // Durchmesser der Kugeln (Holgi: d=6)
strebe_z1       = 0;                     // 0 = automatisch: knapp ueber der Schelle
strebe_x2       = 8;                     // Kugel 2 unter dem Ausleger, innen
strebe_x3       = 0;                     // 0 = automatisch: knapp vor dem Ende
strebe_end_abstand = 3;                  // Luft zwischen Kugel und Auslegerende
min_wand        = 1.0;  // Mindestwand um die Mutterntasche (Holgis Praxis:
                        // 1,1 mm an den Ecken reichen zum Einpressen)
// Umkreis der Mutterntasche: Schluesselweite / cos(30) + Spiel
mutter_ecke     = mutter_weite / cos(30) + 0.3;

unterlegscheibe_d = 9;   // Aussen-Ø der Unterlegscheibe (M4/DIN 125 = 9)
                        // Abstand Lochmitte -> Schellenoberflaeche, damit die
                        // Scheibe unter Kopf und Mutter passt
nase_abstand    = unterlegscheibe_d/2 + 0.5;

function lochpos(d) = (aufnahme == "kugel")
                      ? (aussen_d(d)/2 + nase_abstand)
                      : max(
                      (nase_regel == "geometrisch")
                      ? ((d + 2*wand)/2 + 12 - ((nase_d > 0) ? nase_d : schellen_breite)/2)
                      : (0.35*(d + 2*2) + schellen_breite - 2),
                      (d + 2*wand)/2 + nase_abstand);
// Im Kugelmodus ist der Lenkerdurchmesser irrelevant: der Halter sitzt auf der
// Kugel (kugel_d) und ist damit fuer alle Lenker derselbe. Den Durchmesser
// stellt der Ringadapter her. aussen_d_roh ist die zylindrische Fassung.
function aussen_d_roh(d) = d + 2*wand;
function aussen_d(d) = (aufnahme == "kugel") ? (kugel_d_eff(d) + 4) : aussen_d_roh(d);
// Kugeladapter: mindestens so gross wie der Halter, damit der Sitz greift
function kugel_d_eff(d) = (kugel_d > 0) ? kugel_d : (aussen_d_roh(d) - 4);
// Bezugsdurchmesser fuer alle abgeleiteten Werte. Im Kugelmodus ist der
// Lenkerdurchmesser bewusst ohne Einfluss, damit EIN Halter ueberall passt.
function basis_d(d) = (aufnahme == "kugel") ? kugel_d_eff(d) : d;
function nase_d_eff() = (nase_d > 0) ? nase_d : schellen_breite;

strebe_r    = strebe_d/2;
strebe_z_unten = 0;   // wird unten aus kopf_z abgeleitet

arm_y_start = arm_y_rel * aussen_d(rohr_lenker);   // im Kugelmodus = Kugel + 4
arm_y0      = basis_d(rohr_lenker)/2 + spiel + 1.5;
// Der Arm taucht als Bestandteil der Schelle tief in den Korpus ein. Die Huelle
// beginnt dann auf einem massiven Block innen, nicht auf einer duennen Platte
// an der Oberflaeche — das gibt glatte Uebergaenge statt einer sichtbaren Naht.
// Das Lenkerloch wird DANACH gebohrt und nimmt das Material im Rohr wieder weg.
arm_eintauchtiefe = 6;
arm_basis_z = basis_d(rohr_lenker)/2 + spiel - arm_eintauchtiefe;
arm_z_mitte = (arm_mitte_z > 0) ? arm_mitte_z : (rohr_lenker/2 + spiel + 1.5);
kopf_z      = arm_laenge;                    // Kopfmitte ueber der Rohrachse



assert(lochpos(rohr_lenker) >= aussen_d(rohr_lenker)/2 + nase_abstand,
       str("Zu wenig Platz fuer die Unterlegscheibe: Abstand Lochmitte zur Aussenflaeche ",
           lochpos(rohr_lenker) - aussen_d(rohr_lenker)/2, " mm, noetig ", nase_abstand, " mm"));
assert(strebe_d < kopf_z - arm_y0, "Kugeln groesser als der Abstand Arm/Ausleger");
assert(((strebe_x3 > 0) ? strebe_x3 : (offset_laenge - strebe_r - 1)) + strebe_r <= offset_laenge + 0.01,
       "Kugel 3 steht ueber das Auslegerende hinaus");
assert(aufnahme == "lenker" || aufnahme == "kugel", "aufnahme: lenker oder kugel");
assert(aufnahme == "lenker" || kugel_d_eff(rohr_lenker) <= aussen_d(rohr_lenker) - 2,
       str("Kugel zu gross fuer den Halter: ", kugel_d_eff(rohr_lenker), " mm, Hoechstmass ",
           aussen_d(rohr_lenker) - 2, " mm"));
assert(arm_basis_z > trennfuge/2, "Arm-Basis ragt in die Trennfuge — Klemmung blockiert");
assert(arm_eintauchtiefe < rohr_lenker/2, "Arm taucht bis durch die Rohrmitte");
assert(abs(kopf_len_x - schellen_breite) < 0.01, "Zielzylinder = Schellenbreite lang");
assert(kopf_len_x <= schellen_breite + 0.01, "Kopfzylinder darf nicht ueber die Schelle stehen");
assert(kopf_len_x >= mutter_tiefe + 1.5, "Kopfzylinder zu kurz fuer die Mutterntasche");

assert(kopf_d <= 2*wand + rohr_lenker, "Kopfzylinder groesser als die Schelle");
assert(kopf_bohrung < kopf_d, "Bohrung groesser als der Kopf");
assert(kopf_len_x/2 >= mutter_tiefe, "Tasche laenger als der halbe Zielzylinder");
// Hinweis: bei kopf_d = 10 bleiben um die M5-Mutter (8,3) nur 0,85 mm Wand.
// Fuer eine satte Tasche entweder kopf_d 12 oder die Tasche in den Armansatz legen.
assert(kopf_d >= mutter_ecke + 2*min_wand,
       str("Zylinder zu duenn fuer die Mutterntasche: ", kopf_d, " mm, noetig ",
           mutter_ecke + 2*min_wand, " mm fuer ", min_wand, " mm Wand"));

module schelle_roh(d)
{
    lp = lochpos(d);
    rotate([0, 90, 0]) cylinder(d = aussen_d(d), h = schellen_breite, center = true);
    hull()
    {
        translate([0,  lp, 0]) cylinder(d = nase_d_eff(), h = nase_h, center = true);
        translate([0, -lp, 0]) cylinder(d = nase_d_eff(), h = nase_h, center = true);
    }
}

// Nur die Nuten der Schelle: Schraubenloecher und Trennfuge.
module schelle_nuten(d)
{
    lp = lochpos(d);
    translate([0,  lp, 0]) cylinder(d = schraube, h = 80, center = true);
    translate([0, -lp, 0]) cylinder(d = schraube, h = 80, center = true);
    cube([200, 200, trennfuge], center = true);
}

module hex2d(sw) { intersection() { square([sw, sw], center = true); rotate(45) square([sw, sw], center = true); } }

// Arm: breit an der Schelle, verjuengt, laeuft in den Kopfzylinder
module arm()
{
    // Arm radial nach oben, geht in den liegenden Zylinder ueber.
    // Nach Holgis Displayhalter: r = 0.5*Schellenbreite, h = Schellenbreite.
    x  = schellen_breite - 0.3;
    y0 = arm_y_start;
    hull()
    {
        // massiver Block tief in der Schelle statt duenner Platte
        translate([0, 0, arm_basis_z + 2]) cube([x, y0, 4], center = true);
        // Zielzylinder der Arm-Huellflaeche: gleicher Durchmesser wie der
        // Ausleger, aber nur Schellenbreite lang. Das IST der Zylinder, in den
        // der Arm uebergeht — kein Rechteck.
        translate([0, 0, kopf_z]) rotate([0, 90, 0]) cylinder(h = schellen_breite, d = kopf_d, center = true);
    }
}

// Zweiter Zylinder, gleicher Durchmesser, gleiche Hoehe, horizontal seitlich
// raus. Seine Laenge ist der Offset des Scheinwerfers gegenueber der Schelle.
// Der Ausleger wird an den Zielzylinder ANGESETZT, nicht als Huellflaeche
// benutzt. Gleicher Durchmesser, Laenge = Offset des Scheinwerfers.
module lampenausleger()
{
    translate([0, 0, kopf_z]) rotate([0, 90, 0])
        cylinder(d = kopf_d, h = offset_laenge, center = false);
}

module verstrebung()
{
    z1 = (strebe_z1 > 0) ? strebe_z1 : (arm_basis_z + 6);
    z2 = kopf_z - kopf_d/2 + strebe_r*0.4;
    x3 = (strebe_x3 > 0) ? strebe_x3 : (offset_laenge - strebe_r - strebe_end_abstand);
    hull()
    {
        translate([0, 0, z1])  sphere(d = strebe_d);
        translate([strebe_x2, 0, z2]) sphere(d = strebe_d);
        translate([x3, 0, z2]) sphere(d = strebe_d);
    }
}

module halter()
{
    difference()
    {
        union()
        {
            difference() { schelle_roh(rohr_lenker); schelle_nuten(rohr_lenker); }
            arm();
            lampenausleger();
            verstrebung();
        }
        // Axiale Bohrung durch den Kopf
        // Lenkerloch: in der AEUSSEREN Difference, damit es auch den Arm und die
        // Verstrebung durchbohrt und nicht nur die Schelle. Reihenfolge wie bei
        // Holgi: erst alles aufbauen, dann das Lenkerloch bohren.
        if (aufnahme == "kugel")
            sphere(d = kugel_d_eff(rohr_lenker) + spiel);
        else
            rotate([0, 90, 0]) cylinder(d = rohr_lenker + spiel, h = 200, center = true);
        // Axiale Bohrung entlang der Lenkerachse, vom Lampenende bis in den Kopf
        translate([-kopf_len_x/2 - mutter_tiefe - 1, 0, kopf_z]) rotate([0, 90, 0])
            cylinder(d = kopf_bohrung, h = kopf_len_x + offset_laenge + mutter_tiefe + 2, center = false);
        // Mutterntasche am inneren Ende (flush-Seite), oeffnet nach -X
        translate([-kopf_len_x/2, 0, kopf_z]) rotate([0, 90, 0])
            linear_extrude(height = mutter_tiefe) hex2d(mutter_weite);
        translate([-kopf_len_x/2, 0, kopf_z]) rotate([0, 90, 0])
            hull()
            {
                linear_extrude(0.01) offset(delta = fase) hex2d(mutter_weite);
                translate([0, 0, fase]) linear_extrude(0.01) hex2d(mutter_weite);
            }
    }
}

halter();

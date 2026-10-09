// lenkererweiterung.scad — Halter fuer eine Lenkererweiterung
//
// Lenkerseite: 22 / 31.8 / 35 mm (Fahrradlenker). Erweiterungsseite: FIX 22 mm.
//
// Aufbau der Schelle nach Holgis Rezept (bewusst OHNE minkowski):
//   1. Basisschelle  = EIN Zylinder entlang des Rohres
//   2. Nasen         = Huellflaeche zweier um 90 Grad gedrehter Zylinder,
//                      nach aussen versetzt (Achse quer zum Rohr, rechts/links)
//   3. Schnitte      = Lenkerloch, zwei Schraubenloecher, Rechteck fuer den Schlitz
//
// Warum kein minkowski: verrundete Huellkoerper sind in CGAL bruchanfaellig.
// Mit minkowski verschwanden im Zusammenbau die Nasen komplett (nur +-9,0 statt
// +-33,3 mm X-Ausdehnung) — einzeln ging jeder Schnitt, in Kombination nicht.
// Mit schlichten Zylindern ist es stabil.
//
// Die Verbindung zwischen den Schellen laeuft senkrecht zur Trennebene (radial,
// Z), ist in Rohrrichtung (X) genau so breit wie die Schelle und nur in der
// anderen Achse (Y) breiter, dort zur Erweiterungsseite hin verjuengt.
fn = 120;  $fn = fn;

// --- Parameter ------------------------------------------------------------
rohr_lenker      = 31.8;
// "lenker" = zylindrische Bohrung auf dem Lenker (wie bisher)
// "kugel"  = Kugelsitz fuer den Ringadapter, Ausrichtung frei waehlbar
aufnahme         = "lenker";
kugel_d          = 0;   // 0 = automatisch
rohr_erw         = 22;     // immer 22
spiel            = 0.25;   // Bohrungsspiel der Rohrbohrung
wand             = 8;      // Wandstaerke des Schellenzylinders
schellen_breite  = 18;     // Breite entlang des Rohres
nase_d           = 0;      // 0 = Nasenbreite in X = Schellenbreite. Schmalere Nasen
                           // stehen seitlich ueber und brauchen Stuetzmaterial.
nase_h           = 11;     // Hoehe der Nasenzylinder (in Z)
schraube         = 4.1;    // Durchgangsbohrung: M4 = 4,1 | M3 = 3,44
trennfuge        = 2;      // Dicke des Schlitzes
arm_laenge       = 60;     // Abstand der Rohrachsen (radial)
arm_y_rel        = 0.66;   // Armbreite in Y an der Lenkerseite, bezogen auf den
                           // Aussendurchmesser der Lenkerschelle. 0,66 * 38 = 25 mm
                           // beim 22er Lenker — skaliert also mit dem Lenkerdurchmesser.
arm_y_ende       = 0.60;   // Restbreite in Y am Erweiterungsende

assert(rohr_erw == 22, "Erweiterungsseite ist auf 22 mm fixiert");

// Position der Nasenmitte. Zwei Regeln:
//   "formel"       Holgis gewachsene Formel. Waechst mit 0,32*d, waehrend der
//                  Schellenradius mit 0,50*d waechst -> der Ueberstand schrumpft
//                  mit dickeren Lenkern (14,3 mm bei 22, 12,0 bei 35, 9,3 bei 50).
//   "geometrisch"  Nase steht immer gleich weit ueber die Schelle hinaus
//                  (nase_ueberstand), unabhaengig vom Durchmesser. Bei 35 mm
//                  ergibt beides praktisch denselben Wert (28,48 vs 28,50).
nase_regel    = "formel";
// Damit Unterlegscheiben unter Kopf und Mutter passen: Abstand Lochmitte zur
// Schellenoberflaeche >= Scheibenradius + Luft
nase_ueberstand  = 12;

unterlegscheibe_d = 9;   // Aussen-Ø der Unterlegscheibe (M4/DIN 125 = 9)
nase_abstand    = unterlegscheibe_d/2 + 0.5;

function lochpos(d, kugelseite = false) = (aufnahme == "kugel" && kugelseite)
                      ? (aufnahme_d(d, true)/2 + nase_abstand)
                      : max(
                      (nase_regel == "geometrisch")
                      ? ((d + 2*wand)/2 + 12 - nase_d_eff()/2)
                      : (0.35*(d + 2*2) + schellen_breite - 2),
                      (d + 2*wand)/2 + nase_abstand);
function aussen_d_roh(d) = d + 2*wand;
function kugel_d_eff(d) = (kugel_d > 0) ? kugel_d : (aussen_d_roh(d) - 4);
// Bezugsdurchmesser: im Kugelmodus die Kugel, sonst der Lenker. Gilt nur fuer
// die Lenkerseite, die 22-mm-Seite bleibt zylindrisch.
function basis_d(d) = (aufnahme == "kugel") ? kugel_d_eff(d) : d;
function aufnahme_d(d, kugelseite) = (aufnahme == "kugel" && kugelseite)
                                     ? (kugel_d_eff(d) + 4) : aussen_d_roh(d);
function aussen_d(d) = aussen_d_roh(d);   // zylindrische Fassung
function nase_d_eff() = (nase_d > 0) ? nase_d : schellen_breite;
arm_y_start = arm_y_rel * aufnahme_d(rohr_lenker, true);

// Armenden: in der Ringwand der jeweiligen Schelle
arm_eintauchtiefe = 6;   // wie tief der Arm in beide Schellen eintaucht
arm_z0 = basis_d(rohr_lenker)/2 + spiel - arm_eintauchtiefe;
arm_z1 = arm_laenge - rohr_erw/2 - spiel + arm_eintauchtiefe*0.7;
assert(arm_z0 > trennfuge/2, "Arm ragt in die untere Trennfuge");
assert(arm_z1 < arm_laenge - trennfuge/2, "Arm ragt in die obere Trennfuge");
assert(arm_z1 > arm_z0, "Arm zu kurz fuer diesen Achsabstand");
assert(aufnahme == "lenker" || aufnahme == "kugel", "aufnahme: lenker oder kugel");
// Kugel muss auf den Lenker passen (Ringadapter-Regel), nicht in die zylindrische Schelle
assert(aufnahme == "lenker" || kugel_d_eff(rohr_lenker) >= rohr_lenker + 4,
       str("Kugel zu klein fuer diesen Lenker: ", rohr_lenker, " mm braucht mindestens ",
           rohr_lenker + 4, " mm"));
assert(lochpos(rohr_lenker, true) >= aufnahme_d(rohr_lenker, true)/2 + nase_abstand,
       str("Zu wenig Platz fuer die Unterlegscheibe: ", lochpos(rohr_lenker, true) - aufnahme_d(rohr_lenker, true)/2,
           " mm, noetig ", nase_abstand, " mm"));
assert(arm_y_start >= schellen_breite, "Verbindung soll in Y breiter sein als die Schelle in X");
assert(nase_d_eff() >= schellen_breite - 0.001, "Nasen muessen so breit sein wie die Schelle");
assert(lochpos(rohr_lenker) >= aussen_d(rohr_lenker)/2 + nase_abstand,
       str("Zu wenig Platz fuer die Unterlegscheibe: Abstand Lochmitte zur Schelle ",
           lochpos(rohr_lenker) - (rohr_lenker + 2*wand)/2, " mm, noetig ", nase_abstand, " mm"));

// --- Basisschelle mit Nasen ------------------------------------------------
module schelle_roh(d, kugelseite = false)
{
    lp = lochpos(d, kugelseite);
    // 1. ein Zylinder entlang des Rohres
    rotate([0, 90, 0]) cylinder(d = aufnahme_d(d, kugelseite), h = schellen_breite, center = true);
    // 2. Huellflaeche zweier um 90 Grad gedrehter Zylinder, nach aussen versetzt.
    //    "Aussen" heisst SENKRECHT zur Rohrachse (Y), nicht laengs! Lagen die Nasen
    //    in X, sitzen sie im Lenkerloch und werden von der Rohrbohrung entfernt.
    hull()
    {
        translate([0,  lp, 0]) cylinder(d = nase_d_eff(), h = nase_h, center = true);
        translate([0, -lp, 0]) cylinder(d = nase_d_eff(), h = nase_h, center = true);
    }
}

// --- Schnitte: Lenkerloch, zwei Schraubenloecher, Schlitzrechteck ----------
module schelle_schnitte(d, kugelseite = false)
{
    lp = lochpos(d, kugelseite);
    translate([0,  lp, 0]) cylinder(d = schraube, h = 80, center = true);  // Schraube rechts
    translate([0, -lp, 0]) cylinder(d = schraube, h = 80, center = true);  // Schraube links
    cube([200, 200, trennfuge], center = true);                            // Schlitz
}

module arm()
{
    y0 = arm_y_start;
    y1 = arm_y_start * arm_y_ende;
    // Arm exakt so breit wie die Schelle: kein Absatz, buendige Aussenflaechen
    x  = schellen_breite;
    hull()
    {
        // massive Bloecke statt duenner Platten: die Huellflaeche waechst tief
        // aus beiden Schellen heraus, die Bohrungen nehmen den Rest weg
        translate([0, 0, arm_z0 + 2]) cube([x, y0, 4], center = true);
        translate([0, 0, arm_z1 - 2]) cube([x, y1, 4], center = true);
    }
}

module halter()
{
    difference()
    {
        union()
        {
            difference() { schelle_roh(rohr_lenker, true);  schelle_schnitte(rohr_lenker, true); }
            translate([0, 0, arm_laenge])
                difference() { schelle_roh(rohr_erw, false); schelle_schnitte(rohr_erw, false); }
            arm();
        }
        // Beide Aufnahmen in der AEUSSEREN Difference: erst alles aufbauen,
        // dann bohren. So werden auch Arm und Uebergaenge sauber ausgenommen.
        if (aufnahme == "kugel")
            sphere(d = kugel_d_eff(rohr_lenker) + spiel);                    // Kugelsitz
        else
            rotate([0, 90, 0]) cylinder(d = rohr_lenker + spiel, h = 200, center = true);
        translate([0, 0, arm_laenge])
            rotate([0, 90, 0]) cylinder(d = rohr_erw + spiel, h = 200, center = true);
    }
}

halter();

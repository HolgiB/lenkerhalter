// lenkerrohr.scad — Erweiterungsrohr zum Selbstdrucken
//
// Das Gegenstueck zur Lenkererweiterung: das Rohr, das in die feste
// 22-mm-Aufnahme gesteckt wird. Bewusst als liegender Zylinder mit
// Abflachung nach unten konstruiert, damit es ohne Stuetzmaterial und mit
// satter Auflageflaeche druckt.
fn = 120;  $fn = fn;

d_rohr     = 22;    // Aussendurchmesser, passt in die 22-mm-Aufnahme
laenge     = 130;   // 120 bis 140 sind praktikabel
// Vollbauteil. Bei FDM kommt die Steifigkeit aus Perimeterwaenden und
// geometrischem Infill, nicht aus einer modellierten Rohrwand - eine innere
// Wand waere nur Material und Druckzeit ohne Gewinn. Der Slicer macht das
// besser als das Modell: 4 Perimeter, 30 % Cubic oder Gyroid.
auflage    = 7;     // Breite der Auflageflaeche in mm (6 bis 8 sind sinnvoll)
fase       = 1;     // Fase an beiden Enden

// Aus der gewuenschten Auflagebreite den noetigen Abtrag rechnen: der Kreis
// gibt bei flachem Schnitt viel Breite fuer wenig Tiefe her.
function abtrag()   = d_rohr/2 - sqrt(pow(d_rohr/2, 2) - pow(auflage/2, 2));
function tiefe()    = abtrag();

assert(d_rohr > 4, "Durchmesser zu klein");
assert(auflage > 0 && auflage < d_rohr, "Auflagebreite muss zwischen 0 und dem Durchmesser liegen");
assert(tiefe() < d_rohr/4, str("Auflage zu breit: ", auflage, " mm ergibt ", tiefe(), " mm Abtrag"));
assert(laenge >= 40, "Laenge zu kurz fuer eine Erweiterung");

module lenkerrohr()
{
    difference()
    {
        union()
        {
            // liegend, damit die Abflachung beim Drucken unten liegt
            rotate([0, 90, 0]) cylinder(d = d_rohr, h = laenge, center = true);
            if (fase > 0) for (s = [-1, 1])
                translate([s*(laenge/2 - fase), 0, 0]) rotate([0, s*90, 0])
                    cylinder(d1 = d_rohr, d2 = d_rohr - 2*fase, h = fase, center = false);
        }
        // Abflachung von unten
        translate([0, 0, -d_rohr/2 + tiefe() - 50])
            cube([laenge + 4, d_rohr + 4, 100], center = true);
    }
}

lenkerrohr();

// --- Ausgabe -------------------------------------------------------------
echo(str("Aussendurchmesser: ", d_rohr, " mm | Laenge: ", laenge, " mm"));
echo(str("Auflageflaeche: ", auflage, " mm breit, dafuer ", tiefe(), " mm Abtrag"));
echo(str("Vollmaterial im Modell: ", laenge*(pow(d_rohr/2,2)*acos(1-2*tiefe()/d_rohr) - (d_rohr/2 - tiefe())*sqrt(d_rohr*tiefe() - pow(tiefe(),2))), " mm3"));

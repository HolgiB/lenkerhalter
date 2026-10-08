// ringadapter.scad — Kugelsegment-Ring als Zwischenstueck fuer Kugelgelenke
//
// Wird auf den Lenker gesetzt und bietet aussen eine Kugelflaeche. Der Halter
// (Lampenhalter oder Lenkererweiterung mit aufnahme = "kugel") hat statt der
// zylindrischen Lenkerbohrung einen Kugelsitz und kann dadurch vor dem
// Festziehen in zwei Achsen ausgerichtet werden. Das braucht man bei
// geschwungenen Lenkern, Rennlenkern oder wenn die Klemmung schraeg auf einem
// gebogenen Abschnitt aufliegt.
//
// Ein Schraubenpaar erledigt beides: es presst den Kugelsitz auf die Kugel und
// die Kugel ueber ihren Schlitz auf den Lenker.
fn = 180;  $fn = fn;

rohr_lenker  = 31.8;   // 22 / 22.2 / 25.4 / 25.8 / 26 / 31.8 / 34 / 35
spiel        = 0.25;   // Bohrungsspiel auf dem Lenker
ring_breite  = 18;     // Breite des Segments (auch Breite der Kugelflaeche)
schlitze     = 2;      // Schlitz zum Klemmen

// Die Kugel muss mindestens so gross sein wie der Aussendurchmesser des
// Halters, sonst kann der Sitz sie nicht umfassen (Schelle ist d + 16).
// Feste Kugelgroesse: EIN Ringsegment passt zu Lampenhalter und
// Lenkererweiterung in der Kugelfassung, alle Ringadapter sind untereinander
// austauschbar. Angepasst wird nur die Bohrung (Lenkerdurchmesser).
// 44 mm deckt 22 bis 35 mm mit mindestens 4 mm Ringwand ab.
kugel_d = 44;

assert(rohr_lenker >= 22 && rohr_lenker <= 35,
       "Ringadapter gibt es fuer 22 bis 35 mm Lenkerdurchmesser");
assert(kugel_d >= rohr_lenker + 4,
       str("Kugel zu klein fuer diesen Lenker: ", rohr_lenker, " mm braucht mindestens ",
           rohr_lenker + 4, " mm"));
assert(ring_breite <= kugel_d, "Segment breiter als die Kugel");

module base_ring()
{
    intersection()
    {
        sphere(d = kugel_d);
        cube([kugel_d + 4, kugel_d + 4, ring_breite], center = true);
    }
}

module ringadapter()
{
    difference()
    {
        base_ring();
        cylinder(d = rohr_lenker + spiel, h = 200, center = true);
        cube([kugel_d + 6, schlitze, kugel_d + 6], center = true);
    }
}

ringadapter();

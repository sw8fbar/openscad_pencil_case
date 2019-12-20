    
module box(color, length, width, height) {
color(color)
    linear_extrude(height = height)
        square([length, width], center = true);
}

module pipe(color, length, width, height, thickness) {
    difference() {
        box(color, length, width, height);
        box(color, length - thickness, width - thickness, height);
    }
}

module case_bottom(color, length, width, thickness, overlap_thickness, baseheight, overlapheight) {
    pipe(color, length - thickness + overlap_thickness , width -thickness + overlap_thickness, baseheight + overlapheight, thickness - overlap_thickness);
    difference() {
        translate([0,0,0])
            box("turquoise", length, width, baseheight);
           
        translate([0, 0, thickness ])
           box("blue", length - thickness , width - thickness, baseheight);
    }
}

module case_lid(color, length, width, thickness, overlap_thickness, lidheight, overlapheight) {
    pipe(color, length , width, lidheight + overlapheight, overlap_thickness);
    difference() {
        translate([0,0,0])
            box("green", length, width, lidheight);
        translate([0, 0, thickness ])
            box("red", length - thickness , width - thickness, lidheight);
    }
}

module pencil_case(color, length, width, thickness, overlap_thickness, baseheight, overlapheight) {
    minkowski() {
        sphere(1);
        case_bottom(color, length, width, thickness, overlap_thickness, baseheight, overlapheight);
    }
    translate([0,-100,0])
        minkowski() {
            sphere(1);
            case_lid(color, length, width, thickness, overlap_thickness, lidheight, overlapheight);
        }
}

thickness = 3;
length = 100;
$fn=100;
width = 80;
overlapheight = 30;
baseheight = 140;
lidheight = 60;
overlap_thickness = 1.5;

//pencil_case("red", length, width, thickness, overlap_thickness, baseheight, overlapheight);

//minkowski() {
//    sphere(1);
//    case_bottom(color, length, width, thickness, overlap_thickness, baseheight, overlapheight);
//}

//translate([0,-100,0])
//minkowski() {
//    sphere(1);
//}

case_bottom(color, length, width, thickness, overlap_thickness, baseheight, overlapheight);
translate([0,-100,0])
    case_lid(color, length, width, thickness, overlap_thickness, lidheight, overlapheight);
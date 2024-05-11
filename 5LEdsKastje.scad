// Zonnepaneelmonitor
$fn=120;

Box=0;

Front_Panel=1;
Front_Letters=1;

if(Box) translate([-5,-5,-50]) {
 difference() {
  Cube(136+4+6,50+4+6,40,0.6);
  translate([3,3,2])Cube(136+4,50+4,40,0.6);
  
  // USB 10x7
  translate([-10,12,4])cube([40,7,10]);
 }
 translate([7,7,2])Pilaar(9,32); //cylinder(d=9,h=32);
 translate([136+4+6-7,7,2])Pilaar(9,32); //cylinder(d=9,h=32);
 translate([136+4+6-7,50+4+6-7,2])Pilaar(9,32); //cylinder(d=9,h=32);
 translate([7,50+4+6-7,2])Pilaar(9,32); //cylinder(d=9,h=32);
 
 // Olifantepootjes
 cylinder(d=14,h=0.2);
 translate([136+4+6,0,0])cylinder(d=14,h=0.2);
 translate([136+4+6,60,0])cylinder(d=14,h=0.2);
 translate([0,60,0])cylinder(d=14,h=0.2);
}

if(Front_Panel || Front_Letters) {
 if(true) {
  difference() {
   union() { 
    if(Front_Panel) {
     Cube(136,50,2.4,0.6);
     translate([-2,-2,0])Cube(136+4,50+4,2.4,0.6);
    }
    if(Front_Letters) {
     translate([4,44,1.6]) color("black")
     linear_extrude(height=1)
      text("MARCELV",size=4,font="Gill Sans:style=Bold",valign="center",halign="left");
                    
      translate([132,44,1.6]) color("black")
      linear_extrude(height=1)
       text("Zonnepaneelmonitor",size=5,font="Arial:style=Vet Cursief",valign="center",halign="right");       
     }
   }  
   
   translate([1.8,1.8,-1])cylinder(d=2.6,h=10);
   translate([136-1.8,1.8,-1])cylinder(d=2.6,h=10);
   translate([136-1.8,50-1.8,-1])cylinder(d=2.6,h=10);
   translate([1.8,50-1.8,-1])cylinder(d=2.6,h=10);
   
   translate([1.8,1.8,1.4])cylinder(d=4.4,h=10);
   translate([136-1.8,1.8,1.4])cylinder(d=4.4,h=10);
   translate([136-1.8,50-1.8,1.4])cylinder(d=4.4,h=10);
   translate([1.8,50-1.8,1.4])cylinder(d=4.4,h=10);
   
   translate([20,20,-1])cylinder(d=5,h=10);
   translate([40,20,-1])cylinder(d=5,h=10);
   translate([60,20,-1])cylinder(d=5,h=10);
   translate([80,20,-1])cylinder(d=5,h=10);
   
   translate([117,20,-1])cylinder(d=5,h=10);    
   
  }//diff
 if(Front_Letters) {
  translate([4,4,1.8])color("black")Ribbel(94,30);
  translate([102,4,1.8])color("black")Ribbel(30,30);
  
  translate([20,13,1.6]) color("black")
   linear_extrude(height=1)
    text("100W",size=4,font="Arial:style=Vet",valign="center",halign="center");
  translate([40,13,1.6]) color("black")
   linear_extrude(height=1)
    text("500W",size=4,font="Arial:style=Vet",valign="center",halign="center");   
  translate([60,13,1.6]) color("black")
   linear_extrude(height=1)
    text("1kW",size=4,font="Arial:style=Vet",valign="center",halign="center");   
  translate([80,13,1.6]) color("black")
   linear_extrude(height=1)
    text("5kW",size=4,font="Arial:style=Vet",valign="center",halign="center");      
  translate([117,13,1.6]) color("black")
   linear_extrude(height=1)
    text("Verbr.",size=4,font="Arial:style=Vet",valign="center",halign="center");   
  }
 }
}

module Ribbel(W,H) {
 difference() {
  Cube(W,H,1);
  translate([1.4,1.4,-1])Cube(W-2.8,H-2.8,10);
 }
}


module Cube(xdim ,ydim ,zdim,rdim=1) {
 hull(){
  translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
  translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
  translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
  translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
 }
}

module Pilaar(W=10,H=40) {
 difference() {
  cylinder(d=W,h=H);
  translate([0,0,H-4]) cylinder(d=3.2,h=15);
 }
}
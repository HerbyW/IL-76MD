#
#  DE L'HAMAIDE Clément for Douglas DC-3 C47
#  modified by HerbyW 01/2015 and D-LEON
#
#  Copyright (C) Herbert Wagner 2016
#  see Read-Me.txt for all copyrights in the base folder of this aircraft
###################################################################################

var jumper = aircraft.light.new("/controls/paratroopers/trigger", [0.5,0.5], "/controls/paratroopers/jump-signal");

var listener_id = setlistener("/sim/weight[2]/weight-lb" , func {setprop("/controls/paratroopers/paratroopers", getprop("/sim/weight[2]/weight-lb") / 120)},  0, 0);

setlistener("/controls/paratroopers/trigger/state", func(state){
  if(state.getValue()){
    if( (getprop("/sim/model/door-positions/cargo/position-norm") < 0.75) or (getprop("/sim/model/door-positions/crewL/position-norm") < 0.75) or (getprop("/sim/model/door-positions/crewR/position-norm") < 0.75) )
    {
      jumper.switch(0);
      setprop("/controls/paratroopers/trigger/state", 0);
      setprop("/sim/messages/copilot", "Paratroopers doors are closed! Open cargo, left and right doors. Paratroopers can't jump");
    }else{
      var nb_para = getprop("/controls/paratroopers/paratroopers") - 4;
      setprop("/controls/paratroopers/paratroopers", nb_para);
      var weight = getprop("/sim/weight[2]/weight-lb") - 480;
      setprop("/sim/weight[2]/weight-lb", weight);
      if(getprop("/controls/paratroopers/paratroopers") > 0){
        setprop("/sim/messages/copilot", getprop("/controls/paratroopers/paratroopers")~" Paratroopers remaining");
      }else{
        jumper.switch(0);
        setprop("/sim/messages/copilot", "There are no Paratroopers inside");
      }
    }
  }
});

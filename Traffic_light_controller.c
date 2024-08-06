#define wait delay_ms(1000)
#define start porta.b0
#define convert porta.b1
#define manual porta.b2
#define red_west portd.b0
#define yellow_west portd.b1
#define green_west portd.b2
#define red_south portd.b3
#define yellow_south portd.b4
#define green_south portd.b5

int counter = 0;
char flags = 0;
void to_BCD(){
     // convert two digits of counter to BCD
     // Then assignment them in portb
     portb = (counter % 10) + (counter / 10) * (1<<4);
     // (1<<4) = 16
}
void manual_mode(){
    while(!convert){
        portb = 0;
        if(!manual){
            flags.B0 = ! flags.B0;
            if(red_west){
              red_west = 1, green_west = 0, yellow_west = 0;
              red_south = 0, green_south = 0, yellow_south = 1;
            }else{
                red_west = 0, green_west = 0, yellow_west = 1;
                red_south = 1, green_south = 0, yellow_south = 0;
            }
            for(counter = 3 ; counter > 0 ; counter--){
                to_BCD();
                wait;
            }
        }
        if(flags.B0){
            red_west = 1, green_west = 0, yellow_west = 0;
            red_south = 0, green_south = 1, yellow_south = 0;
        }else{
            red_west = 0, green_west = 1, yellow_west = 0;
            red_south = 1, green_south = 0, yellow_south = 0;
        }
    }
}
void stop_west(){
    red_west = 1, green_west = 0, yellow_west = 0;
    red_south = 0, green_south = 1, yellow_south = 0;
    for(counter = 15 ; counter > 0 ; counter--){
        if(!convert){
            return;
        }
        to_BCD();
        if(counter == 3){
            yellow_south = 1, green_south = 0;
        }
        wait;
    }
}
void stop_south(){
      red_west = 0, green_west = 1, yellow_west = 0;
      red_south = 1, green_south = 0, yellow_south = 0;
      for(counter = 23 ; counter > 0 ; counter--) {
          if(!convert){
              return;
          }
          to_BCD();
          if(counter == 3){
              green_west = 0, yellow_west = 1;
          }
          wait;
      }
}
void main() {
    adcon1 = 7;
    // Input
    trisa = 1;
    porta = 0b111111;
    ////////////////////
    // Outputs
    trisb = 0;
    trisc = 0;
    trisd = 0;
    portb = 0;
    portc = 0xff;
    portd = 0;
    ////////////////////
    flags.B0 = 1;
    while(start){;}
    while(1){
        manual_mode();
        if(flags.B0){
            stop_west();
            stop_south();
        }else{
            stop_south();
            stop_west();
        }
    }
}
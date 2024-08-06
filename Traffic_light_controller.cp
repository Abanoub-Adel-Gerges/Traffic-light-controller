#line 1 "A:/Programs/mikroC/Projects/Traffic light controller/Traffic_light_controller.c"
#line 12 "A:/Programs/mikroC/Projects/Traffic light controller/Traffic_light_controller.c"
int counter = 0;
char flags = 0;
void to_BCD(){


 portb = (counter % 10) + (counter / 10) * (1<<4);

}
void manual_mode(){
 while(! porta.b1 ){
 portb = 0;
 if(! porta.b2 ){
 flags.B0 = ! flags.B0;
 if( portd.b0 ){
  portd.b0  = 1,  portd.b2  = 0,  portd.b1  = 0;
  portd.b3  = 0,  portd.b5  = 0,  portd.b4  = 1;
 }else{
  portd.b0  = 0,  portd.b2  = 0,  portd.b1  = 1;
  portd.b3  = 1,  portd.b5  = 0,  portd.b4  = 0;
 }
 for(counter = 3 ; counter > 0 ; counter--){
 to_BCD();
  delay_ms(1000) ;
 }
 }
 if(flags.B0){
  portd.b0  = 1,  portd.b2  = 0,  portd.b1  = 0;
  portd.b3  = 0,  portd.b5  = 1,  portd.b4  = 0;
 }else{
  portd.b0  = 0,  portd.b2  = 1,  portd.b1  = 0;
  portd.b3  = 1,  portd.b5  = 0,  portd.b4  = 0;
 }
 }
}
void stop_west(){
  portd.b0  = 1,  portd.b2  = 0,  portd.b1  = 0;
  portd.b3  = 0,  portd.b5  = 1,  portd.b4  = 0;
 for(counter = 15 ; counter > 0 ; counter--){
 if(! porta.b1 ){
 return;
 }
 to_BCD();
 if(counter == 3){
  portd.b4  = 1,  portd.b5  = 0;
 }
  delay_ms(1000) ;
 }
}
void stop_south(){
  portd.b0  = 0,  portd.b2  = 1,  portd.b1  = 0;
  portd.b3  = 1,  portd.b5  = 0,  portd.b4  = 0;
 for(counter = 23 ; counter > 0 ; counter--) {
 if(! porta.b1 ){
 return;
 }
 to_BCD();
 if(counter == 3){
  portd.b2  = 0,  portd.b1  = 1;
 }
  delay_ms(1000) ;
 }
}
void main() {
 adcon1 = 7;

 trisa = 1;
 porta = 0b111111;


 trisb = 0;
 trisc = 0;
 trisd = 0;
 portb = 0;
 portc = 0xff;
 portd = 0;

 flags.B0 = 1;
 while( porta.b0 ){;}
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

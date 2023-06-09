// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x40; //make a pointer to access the PIO block
	volatile unsigned int *SW = (unsigned int*)0x60;
	volatile unsigned int *KEY = (unsigned int*)0x70;
	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		if(*KEY==0){
			*LED_PIO = *SW + *LED_PIO;
			if(*LED_PIO>255){
				*LED_PIO = *LED_PIO%255;
			}
			while(*KEY==0){

			}
		}

//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO |= 0x1; //set LSB
//		for (i = 0; i < 100000; i++); //software delay

//		*LED_PIO &= ~0x1; //clear LSB
	}
	return 1; //never gets here
}

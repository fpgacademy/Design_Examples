/*******************************************************************************
 * This program demonstrates use of floating-point numbers
 *
 * It performs the following:
 *		1. initializes two fp variables
 *		2. performs +, -, *, and / on the variables
 *		3. shows the results with printf
 ******************************************************************************/
#include <stdio.h>

int main(void) {
    float x, y, add, sub, mult, div;

    x = 10.5;
    y = 20.5;
    printf("x = %f, y = %f\n", x, y);

    add  = x + y;
    sub  = x - y;
    mult = x * y;
    div  = x / y;
    printf("X + Y = %f\n", add);
    printf("X - Y = %f\n", sub);
    printf("X * Y = %f\n", mult);
    printf("X / Y = %f\n", div);
}

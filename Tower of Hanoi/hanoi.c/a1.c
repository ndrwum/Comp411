#include <stdio.h>

static char peg1[] = "1";
static char peg2[] = "2";
static char peg3[] = "3";

void Hanoi(char *from, char *middle, char *to, int n) {

    if (n > 0) {
        Hanoi(from, to, middle, n - 1); //recursive call to move n-1 disks from peg1 to peg2 using peg3 as aux
        printf("Moved disk from %s to %s\n", from, to);
        Hanoi(middle, from, to, n - 1); //2nd recursive call to move n-1 disks from peg2 to peg3 using peg1 as aux
    }
}

int main() {
    int n;

    printf("Enter the number of disks: ");
    scanf("%d", &n);
    printf("\n");
    Hanoi(peg1, peg2, peg3, n);
}
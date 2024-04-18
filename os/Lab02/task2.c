#include <stdio.h>
#include <stdlib.h>

void reverseSp(int *sp, int n) {
    for (int i = 0; i < n / 2; i++) {
        int t = sp[i];
        sp[i] = sp[n - 1 - i];
        sp[n - 1 - i] = t;
    }
}

int main() {
    int n;
    int *sp;

    scanf("%d", &n);
    sp = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        scanf("%d", &sp[i]);
    }
    reverseSp(sp, n);
    for (int i = 0; i < n; i++) {
        printf("%d ", sp[i]);
    }
    free(sp);

    return 0;
}



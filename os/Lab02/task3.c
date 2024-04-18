#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, m;
    scanf("%d %d", &n, &m);

    int** mat = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        mat[i] = (int*)malloc(m * sizeof(int));
    }


    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &mat[i][j]);
        }
    }

    int** mat2 = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        mat2[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            mat2[j][i] = mat[i][j];
        }
    }


    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", mat2[i][j]);
        }
        printf("\n");
    }


   
    free(mat);

    free(mat2);

    return 0;
}

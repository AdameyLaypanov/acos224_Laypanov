#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include "functions.h"

#define NUM_FUNCTIONS 4

double (*functions[NUM_FUNCTIONS])(double) = {f1, f2, f3, f4};

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <start> <end> <step>\n", argv[0]);
        return EXIT_FAILURE;
    }

    double start = atof(argv[1]);
    double end = atof(argv[2]);
    double step = atof(argv[3]);

    if (step <= 0) {
        return EXIT_FAILURE;
    }

    int pipes[NUM_FUNCTIONS][2];
    pid_t pid;

    for (int i = 0; i < NUM_FUNCTIONS; ++i) {
        if (pipe(pipes[i]) == -1) {
            perror("pipe");
            return EXIT_FAILURE;
        }
    }

    pid = fork();
    if (pid == -1) {
        perror("fork");
        return EXIT_FAILURE;
    }

    if (pid == 0) { 
        for (double x = start; x <= end; x += step) {
            double results[NUM_FUNCTIONS];
            for (int i = 0; i < NUM_FUNCTIONS; ++i) {
                close(pipes[i][0]); 
                results[i] = functions[i](x);
                write(pipes[i][1], &results[i], sizeof(results[i]));
                close(pipes[i][1]);
            }
        }
        _exit(EXIT_SUCCESS);
    } else {
        FILE *file = fopen("output.csv", "w");
        if (file == NULL) {
            perror("fopen");
            return EXIT_FAILURE;
        }
        fprintf(file, "x,f(x)\n");

        for (double x = start; x <= end; x += step) {
            double results[NUM_FUNCTIONS];
            for (int i = 0; i < NUM_FUNCTIONS; ++i) {
                close(pipes[i][1]); 
                read(pipes[i][0], &results[i], sizeof(results[i]));
                close(pipes[i][0]);
            }
            double final_result = f0(results[0], results[1], results[2], results[3]);
            fprintf(file, "%f,%f\n", x, final_result);
        }
        fclose(file);
        wait(NULL); 
    }

    return 0;
}

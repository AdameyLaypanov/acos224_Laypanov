#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include "functions.h"

#define NUM_FUNCTIONS 4

double (*functions[NUM_FUNCTIONS])(double) = {f1, f2, f3, f4};

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <value>\n", argv[0]);
        return EXIT_FAILURE;
    }

    double x = atof(argv[1]);
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

    if (pid == 0) { // Child process
        double results[NUM_FUNCTIONS];
        for (int i = 0; i < NUM_FUNCTIONS; ++i) {
            close(pipes[i][0]); // Close read end in child
            results[i] = functions[i](x);
            write(pipes[i][1], &results[i], sizeof(results[i]));
            close(pipes[i][1]); // Close write end after writing
        }
        _exit(EXIT_SUCCESS);
    } else { // Parent process
        double results[NUM_FUNCTIONS];
        for (int i = 0; i < NUM_FUNCTIONS; ++i) {
            close(pipes[i][1]); // Close write end in parent
            read(pipes[i][0], &results[i], sizeof(results[i]));
            close(pipes[i][0]); // Close read end after reading
        }
        wait(NULL); // Wait for child to finish

        double final_result = f0(results[0], results[1], results[2], results[3]);

        int fd = open("output.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
        if (fd == -1) {
            perror("open");
            return EXIT_FAILURE;
        }

        dup2(fd, STDOUT_FILENO);
        close(fd);

        printf("f0 result: %f\n", final_result);
    }

    return 0;
}

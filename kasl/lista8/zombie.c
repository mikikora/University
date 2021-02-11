#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>

int main() {
    pid_t proces_id = fork();
    if (proces_id < 0) {
        printf("fork failed!\n");
        exit(1);
    }
    if (proces_id > 0) {
        printf("Zombie process id: %d\n", proces_id);
        while (1) {sleep(1);}
    }
    else {
        exit(0);
    }
    return 0;
}

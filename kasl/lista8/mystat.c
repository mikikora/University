#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#define INFINITY 2147483647
#define MINFINITY -2147483648

FILE *rf, *wf;

void handle_sigint(int sig) {
    fclose(wf);
    exit(0);
}

int str2int(char *optarg) {
    int res = 0;
    for (int i = 0; *(optarg+i) != '\0'; i++) {
        if ((*(optarg + i) - '0') < 0 || (*(optarg + i) - '0') > 9) exit(1);
        res = res * 10 + (*(optarg + i) - '0');
    }
    return res;
}

int main(int argc, char** argv) {
    signal(SIGINT, handle_sigint);
    int interval = 60;
    int period = 1;
    char *logfile = "/var/log/mystat.log";
    while (1) {
        int c;
        static struct option long_options[] = {
            {"period", required_argument, 0, 'p'},
            {"interval", required_argument, 0, 'i'},
            {"logfile", required_argument, 0, 'f'},
            {0,0,0,0}
        };
        int option_index = 0;
        c = getopt_long(argc, argv, "p:i:f:", long_options, &option_index);
        if (c == -1) break;
        switch(c) {
            case 'f':
                logfile = optarg;
                break;
            case 'i':
                interval = str2int(optarg);
                break;
            case 'p':
                period = str2int(optarg);
                break;
            case '?':
                exit(0);
                break;
            default:
                abort();
                break;
        }
    }

    wf = fopen(logfile, "w");
    char trash[256];
    int min = INFINITY;
    int max = MINFINITY;
    unsigned long long sum = 0;
    int count = 0;
    int tab[10];
    int a;
    int time = 0;
    while (1) {

        do {
            sleep(1); time++;
        }
        while (time % interval != 0 && time % period != 0);
        if (time % period == 0) {
            rf = fopen("/proc/stat", "r");
            fscanf(rf, "%s %d %d %d %d %d %d %d %d %d %d", trash, &tab[0], &tab[1], &tab[2], &tab[3], &tab[4], &tab[5], &tab[6], &tab[7], &tab[8], &tab[9]);
            // printf("hello\n");
            for (int j = 0; j < 10; j++) a += tab[j];
            a -= tab[3];
            sum += a;
            count++;
            if (min > a) min = a;
            if (max < a) max = a;
            fclose(rf);
        }
        if (time % interval == 0 && time != 0) {
            // printf("Hi\n");
            fprintf(wf, "%d %d %d\n", max, min, sum/count);
            sum = 0;
            count = 0;
            min = INFINITY;
            max = MINFINITY;
        }
    }

    fclose(wf);
    return 0;
}

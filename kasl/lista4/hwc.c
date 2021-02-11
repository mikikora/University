#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void help() {
    printf("Welcome to hwc - program to greet anything\n\n");
    printf("hwc [OPTIONS] {ARGS...}\n");
    printf("Greets strings put in {ARGS...}\n\n");
    printf("available options are:\n");
    printf("-c --capitalise makes all characters capitalise\n");
    printf("-g {text} --greeting=text greets you with text word\n");
    printf("-h --help shows this instruction\n");
    printf("-v --version version of this program\n");
    printf("-w --world prints aditional line with 'wolrd' argument\n");
    printf("--color=[always|auto|never] (default auto)\n");
    exit(0);
}

void version() {
    printf("Version 1.0\n");
    printf("Copyrights (C) 2020 Mikołaj Korobczak\n");
    printf("Wyłączeni na użytek własny lub na zaliczenie kursu administrowania systemem linux\n");
    exit(0);
}

int main (int argc, char** argv) {
    int c;
    int capitalise=0;
    static int color=0;
    char *greets = "Hello";
    char *col = "auto";
    int world=0;
    while (1) {
        static struct option long_options[] = {
            {"capitalise", no_argument, 0, 'c'},
            {"version", no_argument, 0, 'v'},
            {"world", no_argument, 0, 'w'},
            {"help", no_argument, 0, 'h'},
            {"greeting", required_argument, 0, 'g'},
            {"color", required_argument, &color, 1},
            {0,0,0,0}
        };
        int option_index=0;
        c = getopt_long(argc, argv, "cvwhg:", long_options, &option_index);
        // printf("%d\n", c);
        // int test;
        // scanf("%d", &test);
        if (c == -1) break;
        switch(c) {
            case 0:
                if (option_index == 5) {col = optarg;}
                break;
            case 'g':
                greets = optarg;
                break;
            case 'h':
                help();
                exit(0);
                break;
            case 'v':
                version();
                exit(0);
                break;
            case 'c':
                capitalise=1;
                break;
            case 'w':
                world=1;
                break;
            case '?':
                exit(0);
                break;
            default:
                abort();
                break;
        }

    }


    char *greeting = malloc(256);
    strcpy(greeting, greets);
    if (capitalise) {
        for (int i = 0; *(greeting+i) != '\0'; i++) {
            if (*(greeting+i) >= 97 && *(greeting+i) <= 122) *(greeting+i) -= 32;
            }
    }
    // printf("%s\n", greeting);


    while (optind < argc) {
        char *name = malloc(256);
        strcpy(name, argv[optind++]);
        if (capitalise) {
            for (int i = 0; *(name + i) != '\0'; i++) {
                if (*(name+i) >= 97 && *(name+i) <= 122) *(name+i) -= 32;
            }
        }
        if (strcmp(col, "always") == 0) {
            printf("\033[0;31m%s, \033[0;32m%s!\n", greeting, name);
        }
        else if(strcmp(col, "auto") == 0) {
            if( isatty( STDOUT_FILENO )) {
                printf("\033[0;31m%s, \033[0;32m%s!\n", greeting, name);
            }
            else {
                printf("%s, %s!\n", greeting, name);
            }
        }
        else if (strcmp(col, "never") == 0) {
            printf("%s, %s!\n", greeting, name);
        }
        else exit(1);
        free(name);
    }
    if (world) {
        char *w;
        if (!capitalise) w = "world";
        else w = "WORLD";
        if (strcmp(col, "always") == 0) {
            printf("\033[0;31m%s, \033[0;32m%s!\n", greeting, w);
        }
        else if(strcmp(col, "auto") == 0) {
            if( isatty( STDOUT_FILENO )) {
                printf("\033[0;31m%s, \033[0;32m%s!\n", greeting, w);
            }
            else {
                printf("%s, %s!\n", greeting, w);
            }
        }
        else if (strcmp(col, "never") == 0) {
            printf("%s, %s!\n", greeting, w);
        }
        // printf("%s %s\n", greeting, w);
    }
    free(greeting);


    return 0;
}

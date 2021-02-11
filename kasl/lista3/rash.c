//Mikołaj Korobczak
//lista 3 zadanie 8
//rush - really awesome shell
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>

char *build_in_functions[] = {
    "cd",
    "exit"
};
int build_in_functions_n = 2;
int cd_function(char **args);
int exit_function(char **args);

char *rash_read_line() {
    char *line = NULL;
    ssize_t buffsize = 0;
    getline(&line, &buffsize, stdin);
    return line;
}

#define DEFAULT_TOKEN_BUFFORSIZE 64
char **rash_split2words(char *line) {
    int buffor_size = DEFAULT_TOKEN_BUFFORSIZE;
    char **tokens = malloc(buffor_size * sizeof(char*));
    char *token;
    int pos = 0;

    if (!tokens) {
        printf("rash: memory allocation error");
        exit(EXIT_FAILURE);
    }

    token = strtok(line, " \t\n\r\a");
    while (token != NULL) {
        tokens[pos++] = token;
        if (pos >= buffor_size) {
            buffor_size += DEFAULT_TOKEN_BUFFORSIZE;
            tokens = realloc(tokens, buffor_size * sizeof(char*));
            if (!tokens) {
                printf("rash: memory allocation error");
                exit(EXIT_FAILURE);
            }
        }

        token = strtok(NULL, " \t\n\r\a");
    }
    tokens[pos] = NULL;
    return tokens;
}

int rash_execute_program(char **args) {
    pid_t pid;
    int status;

    pid = fork();
    //child process
    if (pid == 0) {
        char input[64], output[64];
        int out = 0, in = 0;
        for (int i = 0; args[i] != NULL; i++) {
            if (strcmp(args[i], ">") == 0) {
                args[i] = NULL;
                strcpy(output, args[i+1]);
                out = 1;
                continue;
            }
            if (strcmp(args[i], ">>") == 0) {
                args[i] = NULL;
                strcpy(output, args[i+1]);
                out = 2;
                continue;
            }
            if (strcmp(args[i], "<") == 0) {
                args[i] = NULL;
                strcpy(input, args[i+1]);
                in = 1;
            }
        }
        if (in == 1) {
            int fd0 = open(input, O_RDONLY, 0);
            if (fd0 < 0) {
                perror("rash");
                exit(EXIT_FAILURE);
            }
            dup2(fd0, STDIN_FILENO);
            close(fd0);
        }
        if (out > 0) {
            int fd1 = out == 2 ? open(output, O_CREAT | O_WRONLY | O_APPEND, 0644) : creat(output, 0644);
            if (fd1 < 0) {
                perror("rash");
                exit(EXIT_FAILURE);
            }
            dup2(fd1, STDOUT_FILENO);
            close(fd1);
        }
        if (execvp(args[0], args) == -1) {
            perror("rash");
        }
        exit(EXIT_FAILURE);
    }
    if (pid < 0) {
        perror("rash");
    }
    else {
        do {
            pid_t wpid = waitpid(pid, &status, WUNTRACED);
        } while (!WIFEXITED(status) && WIFSIGNALED(status));
         // while (!(wait(&status) == pid));
    }
    return 1;
}

int rash_execute(char **args) {
    int program = -1;
    for (int i = 0; i < build_in_functions_n; i++) {
        if (strcmp(args[0], build_in_functions[i]) == 0) {
            program = i;
        }
    }
    // printf("%d", program);
    switch (program) {
        case 0:
            return cd_function(args);
            break;
        case 1:
            return exit_function(args);
            break;
        default:
            return rash_execute_program(args);
            break;
    }
}

void rash_loop() {
    char *line;
    char **args;
    int status = 0;

    do {
        printf("# ");
        line = rash_read_line();
        args = rash_split2words(line);
        // for (int i = 0; args[i] != NULL; i++) printf("%d\n", strcmp(args[i], ">"));
        status = rash_execute(args);

        free(line);
        free(args);
    } while (status);
}

int main () {
    //execute some set up files
    printf("Welcome to rash - really awesome shell\n");

    //main program
    rash_loop();

    //exiting shell

    return EXIT_SUCCESS;
}

int cd_function(char **args) {
    if (args[1] == NULL) {
        fprintf(stderr, "rash: expected argument \"cd \"\n  ^");
    }
    else {
        if (chdir(args[1]) != 0) {
            perror("rash");
        }
    }
    return 1;
}

int exit_function(char **args) {
    printf("exit\n");
    return 0;
}

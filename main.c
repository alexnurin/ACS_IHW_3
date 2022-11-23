#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern double find_zero(int precision);

int main(int argc, char *argv[]) {
    int precision;
    FILE *f_input, *f_output;
    if (argc == 1) {
        printf("Enter precision - the number of decimal places (from 1 to 9): \n");
        scanf("%d", &precision);
        if (errno != 0 || precision > 9 || precision < 1) {
            printf("Error: incorrect input data\n");
            return 1;
        }
    } else if (argc == 2) {
        char *p;
        precision = strtol(argv[1], &p, 10);
        if (errno != 0 || *p != '\0' || precision > 9 || precision < 1) {
            printf("Error: incorrect terminal argument\n");
            return 1;
        }
    } else if (argc == 3) {
        f_input = fopen(argv[1], "r");
        f_output = fopen(argv[2], "w");
        if (f_input == NULL || f_output == NULL) {
            char s1[80] = "../";
            f_input = fopen(strcat(s1, argv[1]), "r");
            s1[3] = '\0';
            f_output = fopen(strcat(s1, argv[2]), "w");
            if (f_input == NULL || f_output == NULL) {
                printf("Cannot open file.\n");
                return 0;
            }
        }
        fscanf(f_input, "%d", &precision);
        fclose(f_input);
        if (errno != 0 || precision > 9 || precision < 1) {
            printf("Error: incorrect data in input file\n");
            return 0;
        }
    } else {
        printf("Error: incorrect number of args: expected 0, 1 or 2, have %d: \n", argc - 1);
        return 0;
    }
    double result = find_zero(precision);
    if (argc != 3) {
        printf("%.*f\n", precision, result);
    } else {
        fprintf(f_output, "%.*f\n", precision, result);
    }
    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

int main(int argc, char **argv) {

    const char *pattern = argv[1];
    const char *text = argv[2];
    const char *replacement = argv[3];
    
    regex_t regex;
    if (regcomp(&regex, pattern, REG_EXTENDED) != 0) {
        return 1;
    }

    regmatch_t match;
    size_t orig_b_size = 1024;
    char *buff1 = malloc(orig_b_size);
    if (buff1 == NULL) {
        regfree(&regex);
        return 1;
    }

    char *cur_pos = (char *)text;
    size_t offset = 0;

    while (regexec(&regex, cur_pos, 1, &match, 0) == 0) {
        size_t start = match.rm_so;
        size_t end = match.rm_eo;

        size_t size_replace = offset + start + strlen(replacement) + 1;
        if (size_replace > orig_b_size) {
            orig_b_size = size_replace * 2;
            char *buff2 = realloc(buff1, orig_b_size);
            if (buff2 == NULL) {
                free(buff1);
                regfree(&regex);
                return 1;
            }
            buff1 = buff2;
        }

        memcpy(buff1 + offset, cur_pos, start);
        offset += start;

        memcpy(buff1 + offset, replacement, strlen(replacement));
        offset += strlen(replacement);

        cur_pos += end;
    }

    strcpy(buff1 + offset, cur_pos);
    printf("%s", buff1);
    free(buff1);
    regfree(&regex);
    return 0;
}

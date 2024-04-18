#include <stdlib.h>
#include <stdio.h>

struct Node {
    int val;
    struct Node* node1;
};

void insert1(struct Node** nodeMain, int v) {
    struct Node* node2 = malloc(sizeof(struct Node));
    node2->val = v;
    node2->node1 = NULL;

    if (*nodeMain == NULL) {
        *nodeMain = node2;
    } else {
        struct Node* current = *nodeMain;
        while (current->node1 != NULL) {
            current = current->node1;
        }
        current->node1 = node2;
    }
}

void rev(struct Node** nodeMain) {
    struct Node *prev = NULL, *current = *nodeMain, *node1 = NULL;
    while (current != NULL) {
        node1 = current->node1;
        current->node1 = prev;
        prev = current;
        current = node1;
    }
    *nodeMain = prev;
}

void print(struct Node* nodeMain) {
    while (nodeMain != NULL) {
        printf("%d ", nodeMain->val);
        nodeMain = nodeMain->node1;
    }
    printf("\n");
}

void fre(struct Node* nodeMain) {
    struct Node* temp;
    while (nodeMain != NULL) {
        temp = nodeMain;
        nodeMain = nodeMain->node1;
        free(temp);  
    }
}

int main() {
    struct Node* nodeMain = NULL;

    while (1) {
        int num;
        scanf("%d", &num);
        if (num == 0) break;
        insert1(&nodeMain, num);
    }

    rev(&nodeMain);

    print(nodeMain);
    fre(nodeMain);

    return 0;
}
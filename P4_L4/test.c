#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    FILE *File_0 = fopen("file_0.txt", "rb");
    if(File_0 == NULL)
    {
        perror("Cannot open the file\n");
    }

    unsigned int number_of_words = 128;
    unsigned char *buffer;
    buffer = (unsigned char *)malloc(1151);

    unsigned int h_input[number_of_words];
    
    fread(buffer, 1, 1151, File_0);

    printf("%s", buffer);

    for (int i=0; i < number_of_words; i++)
        h_input[i] = 0;

    for (int i=0; i < number_of_words; i++)
    {
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input[i] = (h_input[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }

    for (int i=0; i<number_of_words; i++)
    {
        printf("%08x\n", h_input[i]);
    }

    return 0;

}
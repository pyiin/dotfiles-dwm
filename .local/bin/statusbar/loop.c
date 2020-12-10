#include <stdio.h>
#include <string.h>
#include <time.h>

char message[8192+128+128];
char add[128];
int length;
int speed = 1;
int isStdin = 1;

void wrap(int time){
	int LEN = strlen(message);
	int addLen = strlen(add);
	if(length>=LEN){
		puts(message);
		return;
	}

	int i = ((time%(LEN+addLen) + LEN + addLen)*speed)%(LEN+addLen);
	strcat(message,add);
	strcat(message,message);
	*(message+i+length) = 0;
	puts(message+i);
}

int main(int argc, char *argv[]){

	for(int i=1; i<argc; i++){
		if(!strcmp(argv[i],"-m")){
			if(i==argc-1){
				fprintf(stderr, "\033[31;1mERROR:\033[0m give proper message\n");
				return 1;
			}
			strcpy(message, argv[i+1]);
			i++, isStdin = 0;
		}
		else if(!strcmp(argv[i],"-l")){
			if(i==argc-1){
				fprintf(stderr, "\033[31;1mERROR:\033[0m give proper length\n");
				return 2;
			}
			else
				sscanf(argv[i+1], "%d", &length);

			if(length <= 0)
				fprintf(stderr, "\033[31;1mERROR:\033[0m give positive length\n");
		}
		else if(!strcmp(argv[i],"-a")){
			if(i==argc-1)
				add[0] = 0;
			else
				strcpy(add, argv[i+1]);
		}
		else if(!strcmp(argv[i],"-s")){
			if(i==argc-1)
				speed = 1;
			else
				sscanf(argv[i+1], "%d", &speed);
		}
		else if(!strcmp(argv[i],"-h")){
			printf("Usage: loop [OPTIONS]... \nWraps text depending on time, and size of avilable letters.\n\nWith no -m option, read standard input.\n\n  -m\t\tmessage\n  -l\t\tlength of output\n  -a\t\tstring between begining and end of message\n  -s\t\tnumber of characters per second\n  -h\t\tdisplay this message and exit\n");
			return 0;
		}

	}
	if(isStdin)
		fgets(message, 4095, stdin);
	if(message[strlen(message)-1] == '\n')
		message[strlen(message)-1] = 0;
	length = length <= 0 ? strlen(message) : length;

	//struct timeval tv;
	//gettimeofday(&tv, NULL);
	//int timeV = ((long long)(tv.tv_sec)*4 + (long long)(tv.tv_usec/1000/250));
	//wrap(timeV);
	wrap((int)time(NULL));
}

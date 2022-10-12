#include <stdio.h>


char count_ones(long int x);




int main(){
	printf("RAX tiene %d bit/s en 1\n",count_ones(23));
	printf("RAX tiene %d bit/s en 1\n",count_ones(20));
	printf("RAX tiene %d bit/s en 1\n",count_ones(8));
	printf("RAX tiene %d bit/s en 1\n",count_ones(1));
	printf("RAX tiene %d bit/s en 1\n",count_ones(2));
	printf("RAX tiene %d bit/s en 1\n",count_ones(3));
	printf("RAX tiene %d bit/s en 1\n",count_ones(0));
	printf("RAX tiene %d bit/s en 1\n",count_ones(-1));
	}

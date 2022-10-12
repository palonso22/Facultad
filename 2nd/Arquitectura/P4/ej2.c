#include <stdio.h>
unsigned int campesino_ruso(unsigned int,unsigned int);
int main(){
    printf("%d\n",campesino_ruso(0,0));
    printf("%d\n",campesino_ruso(1,0));
    printf("%d\n",campesino_ruso(0,1));
    printf("%d\n",campesino_ruso(1,2));    
    printf("%d\n",campesino_ruso(4,4));    
    printf("%d\n",campesino_ruso(4,2));    
    printf("%d\n",campesino_ruso(3,3));    
    printf("%d\n",campesino_ruso(999,963));    
    return 0;
}

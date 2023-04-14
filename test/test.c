#include <stdlib.h>

void main(){
  int i  = 3;
  int a[16] = {256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256};
  int b[16] = {0};

  for(i=0;i<16;i++)
  {
    if(a[i] > 255)
    {
      a[i] = b[i];
    }
  }
}

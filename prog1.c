#include <stdio.h>

/* (c) Larry Herman, 2022.  You are allowed to use this code yourself, but
   not to provide it to anyone else. */

int n= 0;
int ans= -1;

int main(void) {
  scanf("%d", &n);

  if (n == 0 || (n > 0 && n % 10 != 0)) {
    ans= 0;

    while (n > 0) {
      ans= ans * 10 + (n % 10);
      n /= 10;
    }
  }

  printf("%d\n", ans);

  return 0;
}

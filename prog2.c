#include <stdio.h>

/* (c) Larry Herman, 2022.  You are allowed to use this code yourself, but
   not to provide it to anyone else. */

int number= 0;
int result= 0;

static int catalan(int n);

int main(void) {
  scanf("%d", &number);

  result= catalan(number);

  printf("%d\n", result);

  return 0;
}

static int catalan(int n) {
  int ans, i;

  ans= -1;

  if (n >= 0) {
    ans= 1;

    for (i= 1; i <= n; i++)
      ans= (2 * (2 * i - 1) * ans) / (i + 1);
  }

  return ans;
}

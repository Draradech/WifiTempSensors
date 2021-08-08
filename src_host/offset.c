#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <stdio.h>

void check(int code, const char * msg)
{
  if(code < 0)
  {
    perror(msg);
    printf("return code: %d\n", code);
    exit(-1);
  }
}


int main(int argc, char* argv[])
{
  int fd;
  struct stat st;
  float* values;
  double offset;

  if(argc != 3)
  {
    printf("wrong number of arguments\n");
    exit(-1);
  }

  offset = atof(argv[1]);
  printf("offset: %f\n", offset);

  check(fd = open(argv[2], O_RDWR), "can't open file");
  check(fstat(fd, &st), "fstat failed");
  check((int)(values = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)), "mmap failed");
  close(fd);

  for(int i = 1; i < st.st_size / 4; i += 2)
  {
    values[i] += offset;
  }

  check(munmap(values, st.st_size), "munmap failed");

  return 0;
}







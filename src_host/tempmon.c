#include <sys/stat.h>
#include <fcntl.h>
#include <netinet/ip.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

typedef struct
{
   char id[12];
   float val;
} SPacket;

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
   struct sockaddr_in servaddr;
   int udpfd = socket(AF_INET, SOCK_DGRAM, 0);
   bzero(&servaddr, sizeof(servaddr));
   servaddr.sin_family = AF_INET;
   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
   servaddr.sin_port = htons(5505);
   bind(udpfd, (const struct sockaddr*)&servaddr, sizeof(servaddr));

   for(;;)
   {
      SPacket bufin[20];
      ssize_t n = recv(udpfd, &bufin, sizeof(bufin), 0);
      time_t now = time(0);
      if(n > 0 && n % sizeof(bufin[0]) == 0)
      {
         for(int i = 0; i < n / sizeof(bufin[0]); i++)
         {
            char buf[] = "aabbccddeeff.log";
            memcpy(buf, bufin[i].id, 12);
            //printf("%s: %f\n", buf, bufin[i].val);
            int fdout;
            check(fdout = open(buf, O_CREAT | O_WRONLY | O_APPEND, 0644), "can't open output file");
            write(fdout, &now, sizeof(int));
            write(fdout, &bufin[i].val, sizeof(float));
            close(fdout);
         }
      }
   }

   return -1;
}







#include <resolv.h>
#include <netdb.h>

#define __USE_GNU
#include <dlfcn.h>

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const char* getfield(char* line, int num) {
    char* tmp = strdup(line);
    const char* tok;
    for (tok = strtok(tmp, " "); 
         tok && *tok;
         tok = strtok(NULL, " ")) {
        if (--num < 0) {
            return strdup(tok);
        }
    }
    return NULL;
}

int getaddrinfo(const char *node, const char *service, const struct addrinfo *hints, struct addrinfo **res) {
    FILE* stream = fopen("/host/etc/addr_aliases", "r");
    char line[1024];
    while (fgets(line, 1024, stream)) {        
        const char* host_from = getfield(line, 0);
        const char* port_from = getfield(line, 1);
        const char* host_to = getfield(line, 2);
        const char* port_to = getfield(line, 3);
        if (strcmp(node, host_from) == 0 && strcmp(service, port_from) == 0) {
            fprintf(stderr, "%s:%s => %s:%s\n", host_from, port_from, host_to, port_to);
            node = host_to;
            service = host_to;
        }
    }
	if (res_init () < 0) {
		return EAI_SYSTEM;
    } else {
        int (*f)() = dlsym (RTLD_NEXT, "getaddrinfo");
        return f(node, service, hints, res);
    }
}
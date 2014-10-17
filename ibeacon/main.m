//
//  Copyright (c) 2014 RadiusNetworks. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#import <Foundation/Foundation.h>
#import "Scanner.h"
#import "Macros.h"
#import "GeneratedVersion.h"

static void sigint(const int signum) {
    printf("\n");
    exit(EXIT_SUCCESS);
}

void print_version() {
    printf("Version %s\n", VERSION);
}
void print_usage() {
    printf("ibeacon: iBeacon command line utility\n");
    printf("\n");
    printf("      -h  --help             Display this message\n");
    printf("      -v  --version          Display 'Version %s'\n", VERSION);
    printf("\n");
    printf("    Scan options:\n");
    printf("      -i  --interval         Time interval in seconds\n");
    printf("\n");

}

int main(int argc, char * argv[]) {
    int exit_value = EXIT_SUCCESS;

    @autoreleasepool {
        signal(SIGINT, sigint);

        double interval = 1.1;

        static struct option long_options[] =
        {
            {"interval", required_argument, NULL, 'i'},
            {"help", no_argument, NULL, 'h'},
            {"version", no_argument, NULL, 'v'},
            {NULL, 0, NULL, 0}
        };

        int opt = 0;
        while ((opt = getopt_long(argc, argv, "hvi:", long_options, NULL)) != -1)
        {
            // check to see if a single character or long option came through
            switch (opt)
            {
                case 'i':
                    interval = atof(optarg);
                    break;
                case 'v':
                    print_version();
                    exit(EXIT_SUCCESS);
                    break;
                case 'h':
                    print_usage();
                    exit(EXIT_SUCCESS);
                    break;
            }
        }
        Scanner *scanner = [[Scanner alloc] init];
        [scanner startWithTimeInterval:interval];
        [[NSRunLoop currentRunLoop] run];
    }
    return exit_value;
}


void startWithTimeInterval(double interval) {
    Scanner *scanner = [[Scanner alloc] init];
    [scanner startWithTimeInterval:interval];
    [[NSRunLoop currentRunLoop] run];
}
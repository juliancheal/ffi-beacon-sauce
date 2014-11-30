#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#import <Foundation/Foundation.h>
#import "Scanner.h"
#import "GeneratedVersion.h"

static void sigint(const int signum) {
    printf("\n");
    exit(EXIT_SUCCESS);
}

void print_version() {
    printf("Version %s\n", VERSION);
}

int version() {
    return 0;
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
        [[NSRunLoop currentRunLoop] run];
    }
    return exit_value;
}

typedef int (*callback_function)(const char *uuid, int major, int minor, int power, int rssi);

void startWithTimeInterval(double interval, callback_function completion_callback) {
    Scanner *scanner = [[Scanner alloc] init];
    [scanner startWithTimeInterval:interval andBlock: ^void (ScanItem *i) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
        const char* uuid = [[NSString stringWithFormat:i.uuid] cStringUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop

        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
        int major = i.major;
        int minor = i.minor;
        int power = i.power;
        int rssi = i.rssi;
#pragma clang diagnostic pop
        
        int ret = completion_callback(uuid, major , minor, power, rssi);
        if (ret != 0) {
            exit(EXIT_SUCCESS);
        }
    }];
     [[NSRunLoop currentRunLoop] run];
}
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

int main(int argc, char * argv[]) {
    int exit_value = EXIT_SUCCESS;

    @autoreleasepool {
        signal(SIGINT, sigint);
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
#import <Foundation/Foundation.h>
#import <IOBluetooth/IOBluetooth.h>
#import "ScanItem.h"

@interface Scanner : NSObject <CBCentralManagerDelegate>

@property CBCentralManager *centralManager;
@property NSTimer *timer;
@property NSMutableDictionary *scans;
@property double quietTime;
@property (nonatomic, copy) void (^externalCallback)(ScanItem *i);

- (void)startWithTimeInterval:(double)interval andBlock: (void (^)(ScanItem *i))callback;

@end

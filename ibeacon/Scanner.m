#import "Scanner.h"
#import "ScanItem.h"
#import "Macros.h"

@implementation Scanner

-(id)init {
    if (self = [super init])  {
        self.quietTime = 5.0f;
        self.scans = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)startWithTimeInterval: (double)interval andBlock: (void (^)(ScanItem *i))callback {
    self.externalCallback = callback;
    dispatch_queue_t scanQueue = dispatch_queue_create("com.tweed.lawyer", DISPATCH_QUEUE_SERIAL);
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:scanQueue];
    [self startTimer:interval];
}

- (void)startTimer:(double) interval {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                      target:self
                                                    selector:@selector(tick)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if ([central state] != CBCentralManagerStatePoweredOn) {
        NSLog(@"Error: Bluetooth Turned Off or Unsupported");
        exit(1);
    }
}

- (void)tick {
    [self print];
    [self clean];
    [self scan];
}

- (void)clean {
    for(NSString *key in [self.scans allKeys]) {
        ScanItem *scanItem = [self.scans objectForKey:key];

        // Reset RSSI to 0
        scanItem.rssi = 0;

        // Remove scans older than quite time
        NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate: scanItem.last_seen];
        if (diff > self.quietTime) {
            [self printExit:scanItem];
            [self.scans removeObjectForKey: key];
        }
    }
}

- (void)print {
    for(NSString *key in [self.scans allKeys]) {
        ScanItem *scanItem = [self.scans objectForKey:key];
        self.externalCallback(scanItem);
    }
}

- (void)scan {
    if ([self.centralManager state] == CBCentralManagerStatePoweredOn) {
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)printEnter: (ScanItem *)scanItem {
//    Puts(@"{entered: %@}", scanItem.jsonString);
}
- (void)printExit: (ScanItem *)scanItem {
//    Puts(@"{exited: %@}", scanItem.jsonString);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)rssi
{
    ScanItem *scanItem = [[ScanItem alloc] initWithPeripheral:peripheral advertisementData:advertisementData RSSI:rssi];
    if (scanItem) {
        if (self.scans[scanItem.identifier]) {
            ScanItem *si = self.scans[scanItem.identifier];
            si.last_seen = [NSDate date];
            si.rssi = scanItem.rssi;
            [self.scans setObject:si forKey:scanItem.identifier];
        } else {
            [self.scans setObject:scanItem forKey:scanItem.identifier];
            [self printEnter:scanItem];
        }
    }
}

@end

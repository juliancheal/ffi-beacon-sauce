#import "ScanItem.h"

@implementation ScanItem

- (id)initWithPeripheral:(CBPeripheral *)peripheral
       advertisementData:(NSDictionary *)advertisementData
                    RSSI:(NSNumber *)rssi {

    self = [super init];
    if (self) {
        NSData *theAdData =  advertisementData[@"kCBAdvDataManufacturerData"];
        unsigned int thePreamble;
        [theAdData getBytes:&thePreamble length:sizeof(thePreamble)];
        if ((thePreamble == 0x1502004c) && (theAdData.length >= 25)) {
            self.identifier = [peripheral.identifier UUIDString];
            self.first_seen  = [NSDate date];
            self.last_seen = self.first_seen;
            self.rssi = [rssi integerValue];
            
            // get the uuid string
            CFUUIDBytes uuidBytes;
            [theAdData getBytes:&uuidBytes range:NSMakeRange(4, 16)];
            CFUUIDRef uuid = CFUUIDCreateFromUUIDBytes (kCFAllocatorDefault,uuidBytes);
            self.uuid = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
            
            // get the major
            unsigned short  major;
            [theAdData getBytes:&major range:NSMakeRange(20 , 2)];
            self.major = NSSwapShort(major);
            
            // get the minor
            unsigned short  minor;
            [theAdData getBytes:&minor range:NSMakeRange(22 , 2)];
            self.minor = NSSwapShort(minor);
            
            // get the power
            SignedByte  power;
            [theAdData getBytes:&power range:NSMakeRange(24 , 1)];
            self.power = power;
            
        } else {
            // Not an iBeacon, so return nil
            return NULL;
        }
    }
    return self;
}

@end

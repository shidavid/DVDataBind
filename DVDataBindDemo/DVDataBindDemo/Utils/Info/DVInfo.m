//
//  DVInfo.m
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DVInfo.h"
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation DVInfo

#pragma mark - <-- Readonly -->
+ (NSString *)projectName {
    return [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleExecutableKey];
}

+ (NSString *)appName {
    NSString *name = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    return name == nil ? [self projectName] : name;
}

+ (NSString *)appVersion {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

+ (NSString *)appBuild {
    return [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
}

+ (NSString *)bundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
}

+ (DVPhoneType)phoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return kiPhone_2G;//@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return kiPhone_3G;//@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return k_NULL;//@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return kiPhone_4;//@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return kiPhone_4;//@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return kiPhone_4;//@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return kiPhone_4S;//@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return kiPhone_5;//@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return kiPhone_5;//@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return kiPhone_5C;//@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return kiPhone_5C;//@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return kiPhone_5S;//@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return kiPhone_5S;//@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return kiPhone_6P;//@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return kiPhone_6;//@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return kiPhone_6S;//@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return kiPhone_6SP;//@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return kiPhone_SE;//@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return kiPhone_7;//@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return kiPhone_7P;//@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return kiPhone_8;//@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return kiPhone_8;//@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return kiPhone_8P;//@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return kiPhone_8P;//@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return kiPhone_X;//@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return kiPhone_X;//@"iPhone X";
    
    //    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    //
    //    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    //
    //    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    //
    //    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    //
    //    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    //
    //    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    //
    //    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    //
    //    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    //
    //    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    //
    //    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    //
    //    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    //
    //    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    //
    //    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    //
    //    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    //
    //    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    //
    //    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    //
    //    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    //
    //    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    //
    //    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    //
    //    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    //
    //    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    //
    //    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    //
    //    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    //
    //    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    //
    //    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    //
    //    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    //
    //    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    //
    //    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    //
    //    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    //
    //    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    //
    //    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    //
    //    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    //
    //    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    //
    //    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    //
    //    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    //
    //    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    //
    if([platform isEqualToString:@"i386"]) return k_PC;//@"iPhone Simulator";
    //
    if([platform isEqualToString:@"x86_64"]) return k_PC;//@"iPhone Simulator";
    
    return k_NULL;
}

+ (BOOL)isPhoneX_All {
    return IS_PhoneXAll;
}


+ (NSString *)UUID {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

//#import <mach-o/ldsyms.h>
//
//NSString *executableUUID()
//{
//    const uint8_t *command = (const uint8_t *)(&_mh_execute_header + 1);
//    for (uint32_t idx = 0; idx < _mh_execute_header.ncmds; ++idx) {
//        if (((const struct load_command *)command)->cmd == LC_UUID) {
//            command += sizeof(struct load_command);
//            return [NSString stringWithFormat:@"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X",
//                    command[0], command[1], command[2], command[3],
//                    command[4], command[5],
//                    command[6], command[7],
//                    command[8], command[9],
//                    command[10], command[11], command[12], command[13], command[14], command[15]];
//        } else {
//            command += ((const struct load_command *)command)->cmdsize;
//        }
//    }
//    return nil;
//}

+ (NSString *)developRegion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleDevelopmentRegionKey];
}

+ (NSString *)localLanguage {
    return [NSLocale preferredLanguages][0];
}

+ (NSString *)systemLanuage {
    return @"";
}

+ (NSString *)minimumSystemVersion {
    return [NSBundle mainBundle].infoDictionary[@"MinimumOSVersion"];
}

+ (NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (UIDeviceBatteryState)batteryState {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = [[UIDevice currentDevice] batteryState];
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    return state;
}

+ (float)batteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    float level = [[UIDevice currentDevice] batteryLevel];
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    return level;
}

+ (NSString *)simIP {
    return [self getIPAddresses][@"en2/ipv4"];
}

+ (NSString *)wifiIP {
    NSDictionary *dict = [self getIPAddresses];
    
    if (dict[@"en0/ipv4"] != nil) {
        return [self getIPAddresses][@"en0/ipv4"];
    }
    
    return @"0.0.0.0";
}




#pragma mark - <-- Method -->
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
         address = addresses[key];
         if(address) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}


@end

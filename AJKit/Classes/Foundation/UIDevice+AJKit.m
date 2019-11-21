//
//  UIDevice+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "UIDevice+AJKit.h"

@implementation UIDevice (AJKit)

+ (NSString *)ajUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (BOOL)ajIsPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

- (BOOL)ajIsSimulator {
    static dispatch_once_t one;
    static BOOL simu;
    dispatch_once(&one, ^{
        simu = NSNotFound != [[self model] rangeOfString:@"Simulator"].location;
    });
    return simu;
}

- (BOOL)ajIsJailbroken {
    if (self.ajIsSimulator) {
        return NO;
    }
    
    NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package/com.saurik.cydia"];
    if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
    
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt/",
                       @"/private/var/lib/cydia",
                       @"/private/var/stash"];
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
    }
    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    NSString *path = [NSString stringWithFormat:@"/private/%@", [[self class] ajUUID]];
    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    return NO;
}

- (BOOL)ajCanMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}

- (NSString *)ajMachineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{ //!OCLINT
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

- (NSString *)ajIpAddressWIFI {
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr != NULL) {
            if (addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:
                               inet_ntoa(((struct sockaddr_in *)addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}

- (int64_t)ajDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)ajDiskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)ajDiskSpaceUsed {
    int64_t total = self.ajDiskSpace;
    int64_t free = self.ajDiskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

- (int64_t)ajMemoryTotal {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

- (int64_t)ajMemoryUsed {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * (vm.active_count +
                                  vm.inactive_count +
                                  vm.wire_count);
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)ajMemoryFree {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.free_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)ajMemoryActive {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.active_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)ajMemoryInactive {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.inactive_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)ajMemoryWired {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.wire_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)ajMemoryPurgable {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.purgeable_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (NSUInteger)ajCpuCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}

- (float)ajCpuUsage {
    float cpu = 0;
    NSArray *cpus = self.ajCpuUsagePerProcessor;
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}

- (NSArray *)ajCpuUsagePerProcessor {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = @[].mutableCopy;
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

@end

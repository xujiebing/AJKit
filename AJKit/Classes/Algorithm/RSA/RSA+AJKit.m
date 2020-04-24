//
//  RSA+AJKit.m
//  Base64
//
//  Created by 徐结兵 on 2020/4/9.
//

#import "RSA+AJKit.h"

@implementation RSA (AJKit)

+ (NSString *)ajEncrypt:(NSDictionary *)params {
    NSString *signStr = @"";
    NSArray *keys = [params allKeys];
    NSArray *array = [keys sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *paramArray = [NSMutableArray arrayWithCapacity:1];
    // 先进行筛选, 去除NSData数据
    for (id key in array) {
        id obj = params[key];
        if ([obj isKindOfClass:[NSData class]]) {
            continue;
        }
        if([obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""]) {
            continue;
        }
        if ([obj isKindOfClass:[NSNull class]]) {
            continue;
        }
        NSString *item = [NSString stringWithFormat:@"%@=%@", key, obj];
        [paramArray addObject:item];
    }

    NSString *result = [paramArray componentsJoinedByString:@"&"];
    NSString *waitMD5 = result.stringByRemovingPercentEncoding;
    AJLog(@"待加载参数 ===== %@", waitMD5);
    signStr = waitMD5.ajToMd5String;
    NSString *pubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCTof8hyG+rbPI15ZlEyarvw6pyFrL8r6oc/dMaSTSBrA9RMCjhOLjnPBnOszqSNia+D6VO0F+PEo+bwCG8wCNLg90YNo7dBTj9xcplWLGx/vesK2XqdDovV+9aj3cW388ajOAHcfA5Mg8ui9FrnyAL5NyJXjtTuKOhBT5Er/vMgwIDAQAB";
    NSString *encrypted = [RSA encryptString:signStr publicKey:pubkey];
    return encrypted;
}

+ (NSString *)ajDecrypt:(NSString *)encrypt {
    if (NSString.ajIsEmpty(encrypt)) {
        return @"";
    }
    NSString *pubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCe7kxTTEHqe00ooigjsSpv9tvYaeaow0RTOx1gTkth/ypV6/QkVh9SkmQhgcWqzHvvCodNEje1rHBg75wxI3rPOuWlyQyNJnpMXdwK4T3WZ63+bIvEiEAEUl2xN5eYwpQg0VXTADNzXQKVrnWMFO2uT6OARev2HA2bNcFvvIDehwIDAQAB";
    NSString *md5 = [RSA decryptString:encrypt publicKey:pubkey];
    return md5;
}

@end

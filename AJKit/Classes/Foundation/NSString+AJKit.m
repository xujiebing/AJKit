//
//  NSString+AJKit.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/3.
//

#import "NSString+AJKit.h"
#import <CommonCrypto/CommonDigest.h>

static const short base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
};

static inline CGSize CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

@implementation NSString (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

static NSString *_bwtDeviceUUID = nil;
static NSString *AJDeviceUUIDKey = @"DeviceUUID";
+ (NSString *)ajDeviceUUID {
    if (!_bwtDeviceUUID) {
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        NSString *device = [[NSUserDefaults standardUserDefaults] stringForKey:AJDeviceUUIDKey];
        if (NSString.ajIsEmpty(device)) {
            device = [AJSSKeychain passwordForService:bundleIdentifier account:bundleIdentifier];
            if(NSString.ajIsEmpty(device)) {
                NSString *UUID = NSString.ajStringWithUUID;
                device = [NSString stringWithFormat:@"%@%@",UUID, bundleIdentifier].ajToMd5String;
                [AJSSKeychain setPassword:device forService:bundleIdentifier account:bundleIdentifier];
            }
            [[NSUserDefaults standardUserDefaults] setObject:_bwtDeviceUUID forKey:AJDeviceUUIDKey];
        }
        _bwtDeviceUUID = device;
    }
    return _bwtDeviceUUID;
}


+ (NSString *)ajStringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)ajSequence {
    NSString *value = @"";
    NSString *currentDate = [[NSDate date] ajToStringWithFormat:@"yyyyMMddHHmmss"];
    NSString *strRandom = @"";
    for(int i = 0; i < 10; i++) {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    value = [NSString stringWithFormat:@"%@%@", currentDate, strRandom];
    return value;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (![string isKindOfClass:[NSString class]]) {
            return YES;
        }
        if (string.length == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (NSDictionary *)ajQueryToDictionary {
    NSMutableDictionary *resut = nil;
    if (NSString.ajIsEmpty(self)) {
        return resut;
    }
    NSArray *array = [self componentsSeparatedByString:@"&"];
    resut = [NSMutableDictionary.alloc initWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *objArray = [obj componentsSeparatedByString:@"="];
        NSString *key = objArray.firstObject;
        NSString *value = objArray.lastObject;
        [resut setValue:value forKey:key];
    }];
    return resut;
}

+ (NSString * _Nonnull (^)(int))ajStringFromInt {
    NSString * (^block)(int) = ^(int aInt) {
        NSString *string = [NSString stringWithFormat:@"%d", aInt];
        return string;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSInteger))ajStringFromInteger {
    NSString * (^block)(NSInteger) = ^(NSInteger aInteger) {
        NSString *string = [NSString stringWithFormat:@"%d", aInteger];
        return string;
    };
    return block;
}

- (NSData *)ajToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)ajToMd5String {
    return self.ajToData.ajToMd5String;
}

- (NSString *)ajToDecimal {
    NSMutableData *stringData = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    return [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding];
}

- (NSString *)ajToHex {
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ ) {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    return hexString;
}

- (NSString *)ajBase64Encoding {
    return self.ajToData.ajBase64Encoding;
}

- (NSData *)ajBase64EncodingData {
    NSInteger length = self.length;
    const char *string = [self cStringUsingEncoding:NSASCIIStringEncoding];
    if (string == NULL) {
        return nil;
    }
    while (length > 0 && string[length - 1] == '=')
        length--;
    
    NSInteger outputLength = length * 3 / 4;
    NSMutableData *data = [NSMutableData dataWithLength:outputLength];
    if (data == nil)
        return nil;
    if (length == 0)
        return data;
    
    uint8_t *output = data.mutableBytes;
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < length) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < length ? string[inputPoint++] : 'A';
        char i3 = inputPoint < length ? string[inputPoint++] : 'A';
        
        output[outputPoint++] = (base64DecodingTable[i0] << 2)
        | (base64DecodingTable[i1] >> 4);
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i1] & 0xf) << 4)
            | (base64DecodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i2] & 0x3) << 6)
            | base64DecodingTable[i3];
        }
    }
    
    return data;
}

- (NSString *)ajBase64Decoding {
    NSData *data = self.ajBase64EncodingData;
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)ajBase64DecodingToHex {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[decodedData length]];
    [decodedData enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return [string uppercaseString];
}

- (NSString *)ajURLEncode {
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                       (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    
    return outputStr;
}

- (NSString *)ajURLDecoding {
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (BOOL)ajIsChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)ajIsNameRule {
    NSString *newName = [self stringByReplacingOccurrencesOfString:@"·" withString:@""];
    newName = [newName stringByReplacingOccurrencesOfString:@"." withString:@""];
    newName = [newName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *match = @"(^([\u4e00-\u9fa5|a-zA-Z])+$)";
    BOOL valide = [newName ajMatchesRegex:match];
    return valide;
}

- (BOOL)ajMatchesRegex:(NSString *)regex {
    NSError *error = nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
    if (error) {
        NSLog(@"NSString+YYAdd create regex error: %@", error);
        return NO;
    }
    BOOL result = [pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0;
    return result;
}

- (NSString *)ajStringByTrimming {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (BOOL (^)(NSString * _Nonnull))ajContainsString {
    BOOL (^block)(NSString *) = ^(NSString *string){
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        BOOL result = [self rangeOfString:string].location != NSNotFound;
        return result;
    };
    return block;
}

- (NSNumber *)ajToNumber {
    NSString *str = [self.ajStringByTrimming lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:self];
}

- (BOOL)ajIsMobileNumber {
    BOOL isPhone = NO;
    NSString *phoneRegex = @"^(1)[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    isPhone = [phoneTest evaluateWithObject:self];
    return isPhone;
}

- (BOOL)ajIsNumber {
    NSString *regex = @"(^[0-9]*$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)ajIsMoney {
    NSString *regex = @"(^[0-9]+(\\.[0-9]{1,2})?$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)ajIsEmailAddress {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [pre evaluateWithObject:self];
}

- (BOOL)ajAccurateVerifyIDCardNumber {
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    length = (int)value.length;
    if (length !=15 && length !=18) {
        return NO;
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            }
            
            return NO;
            
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }

                return NO;
                
            }
            
            return NO;
        default:
            return NO;
    }
}

- (NSString *)ajSha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (CGSize (^)(UIFont * _Nonnull, CGSize, NSLineBreakMode))ajSize {
    CGSize (^block)(UIFont *, CGSize, NSLineBreakMode) = ^(UIFont *font, CGSize size, NSLineBreakMode lineBreakMode){
        CGSize result;
        if (!font) font = [UIFont systemFontOfSize:12];
        if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            NSMutableDictionary *attr = @{}.mutableCopy;
            attr[NSFontAttributeName] = font;
            if (lineBreakMode != NSLineBreakByWordWrapping) {
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                paragraphStyle.lineBreakMode = lineBreakMode;
                attr[NSParagraphStyleAttributeName] = paragraphStyle;
            }
            CGRect rect = [self boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attr context:nil];
            result = rect.size;
        } else {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
    #pragma clang diagnostic pop
        }
        return CGSizeCeil(result);
    };
    return block;
}

- (NSDate * _Nonnull (^)(NSString * _Nonnull))ajToDate {
    NSDate * (^block)(NSString *) = ^(NSString *format){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter dateFromString:self];
    };
    return block;
}

- (CGFloat (^)(UIFont * _Nonnull, CGFloat))ajSizeHeight {
    CGFloat (^block)(UIFont *, CGFloat) = ^(UIFont *font, CGFloat width){
        CGSize size = self.ajSize(font, CGSizeMake(width, HUGE), NSLineBreakByWordWrapping);
        return size.height;
    };
    return block;
}

- (NSString *)ajClearWhiteSpaceAndNewLine {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
            componentsJoinedByString:@""];
}

- (void)ajOpenInSafari {
    NSURL *url = [NSURL URLWithString:self];
    url.ajOpenInSafari;
}

- (UIColor *)ajToColor {
    UIColor *color = UIColor.clearColor;
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return color;
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return color;
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (NSMutableAttributedString *)ajAttributedString:(NSString *)targetString
                                            color:(UIColor *)color
                                             font:(UIFont *)font {
    NSRange targetRange = [self rangeOfString:targetString];
    if (targetRange.length == 0) {
        NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc]initWithString:self];
        return arrString;
    }
    NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc]initWithString:self];
    // 设置前面几个字串的格式:字号字体、颜色
    [arrString addAttributes:@{NSFontAttributeName:font,
                               NSForegroundColorAttributeName:color
                               }
                       range:targetRange];
    return arrString;
}

@end

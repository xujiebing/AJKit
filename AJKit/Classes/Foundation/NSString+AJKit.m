//
//  NSString+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSString+AJKit.h"

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

@implementation NSString (AJKit)

- (BOOL)ajNonEmpty {
    if (self.length == 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)ajDocumentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask, YES) firstObject];
}

+ (NSString *)ajLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                NSUserDomainMask, YES) firstObject];
}

+ (NSString *)ajCachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                NSUserDomainMask, YES) firstObject];
}

- (NSString *)ajEncodeUTF8 {
    return self.ajEncode(NSUTF8StringEncoding);
}

- (NSString * _Nonnull (^)(NSStringEncoding))ajEncode {
    kAJWeakSelf
    NSString *(^block)(NSStringEncoding) = ^(NSStringEncoding encoding) {
        NSString *encoded = nil;
        if (!ajSelf.ajNonEmpty) {
            return encoded;
        }
        encoded = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                        (__bridge CFStringRef)ajSelf,
                                                                                        NULL,
                                                                                        CFSTR("!#$&'()*+,/:;=?@[]"),
                                                                                        (CFStringEncoding)encoding);
        return encoded;
    };
    return block;
}

- (NSString *)ajDecodeUTF8 {
    return self.ajDecode(NSUTF8StringEncoding);
}

- (NSString * _Nonnull (^)(NSStringEncoding))ajDecode {
    kAJWeakSelf
    NSString *(^block)(NSStringEncoding) = ^(NSStringEncoding encoding) {
        NSString *decodeString = nil;
        if (!ajSelf.ajNonEmpty) {
            return decodeString;
        }
        decodeString = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)ajSelf, CFSTR(""),CFStringConvertNSStringEncodingToEncoding(encoding));
        return decodeString;
    };
    return block;
}

- (id)ajJsonObject {
    if (!self.ajNonEmpty) {
        return nil;
    }
    return self.ajDataValue.ajJsonValueDecoded;
}

- (NSData *)ajBase64DecodeToData {
    NSMutableData *data = nil;
    if (!self.ajNonEmpty) {
        return data;
    }
    NSInteger length = self.length;
    const char *string = [self cStringUsingEncoding:NSASCIIStringEncoding];
    if (string  == NULL)
        return data;
    
    while (length > 0 && string[length - 1] == '=')
        length--;
    
    NSInteger outputLength = length * 3 / 4;
    data = [NSMutableData dataWithLength:outputLength];
    if (data == nil)
        return data;
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

- (NSString *)ajBase64Encode {
    if (!self.ajNonEmpty) {
        return AJEmptyString;
    }
    return [self.ajDataValue base64EncodedStringWithOptions:0];
}

- (NSString *)ajBase64Decode {
    if (!self.ajNonEmpty) {
        return AJEmptyString;
    }
    return [[NSString alloc] initWithData:self.ajBase64DecodeToData encoding:NSUTF8StringEncoding];
}

- (NSData *)ajFileData {
    NSData *data = nil;
    if (!self.ajNonEmpty) {
        return data;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:self ofType:@""];
    data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSString *)ajSequence {
    NSString *currentDate = NSDate.date.ajStringValue(AJYYYYMMDDHHMMSS5);
    NSString *value = [currentDate stringByAppendingString:NSString.ajRandom(10)];
    return value;
}

+ (NSString *(^)(NSInteger))ajRandom {
    NSString *(^block)(NSInteger) = ^(NSInteger length){
        if (!length) {
            length = 16;
        }
        NSString *random = @"";
        for(int i = 0; i < length; i++) {
            random = [random stringByAppendingFormat:@"%i",(arc4random() % 9)];
        }
        return random;
    };
    return block;
}

- (NSString *)ajHexToDecimal {
    if (!self.ajNonEmpty) {
        return AJEmptyString;
    }
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

- (NSString *)ajDecimalToHex {
    NSMutableString *hexString = nil;
    if (!self.ajNonEmpty) {
        return hexString;
    }
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    hexString = [[NSMutableString alloc] init];
    for(NSUInteger i = 0; i < len; i++ ) {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    return hexString;
}

- (BOOL)ajIsChinese {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    return self.ajMatchesRegex(match);
}

- (BOOL (^)(NSString * _Nonnull))ajMatchesRegex {
    kAJWeakSelf
    BOOL (^block)(NSString *) = ^(NSString *regex) {
        if (!ajSelf.ajNonEmpty || !regex.ajNonEmpty) {
            return NO;
        }
        NSError *error = nil;
        NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
        if (error) {
            AJLog(@"NSString+YYAdd create regex error: %@", error);
            return NO;
        }
        NSUInteger result = [pattern numberOfMatchesInString:ajSelf options:0 range:NSMakeRange(0, ajSelf.length)];
        if (result > 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (NSString *)ajClearWhiteSpace {
    if (!self.ajNonEmpty) {
        return AJEmptyString;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *value = [self stringByTrimmingCharactersInSet:set];
    return value;
}

- (NSString *)ajClearWhiteSpaceAndNewLine {
    if (!self.ajNonEmpty) {
        return AJEmptyString;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *array = [self componentsSeparatedByCharactersInSet:set];
    NSString *value = [array componentsJoinedByString:@""];
    return value;
}

- (BOOL (^)(NSString * _Nonnull))ajContainsString {
    kAJWeakSelf
    BOOL (^block)(NSString *) = ^(NSString *containString) {
        if (!ajSelf.ajNonEmpty || !containString.ajNonEmpty) {
            return NO;
        }
        BOOL contains = [ajSelf rangeOfString:containString].location != NSNotFound;
        return contains;
    };
    return block;
}

- (NSNumber *)ajNumberValue {
    NSNumber *number = nil;
    if (!self.ajNonEmpty) {
        return number;
    }
    NSString *str = self.ajClearWhiteSpace.lowercaseString;
    if (!str || !str.length) {
        return number;
    }
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc) {
            number = [NSNumber numberWithLong:((long)num * sign)];
        }
        return number;
    }
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    number = [formatter numberFromString:self];
    return number;
}

- (NSData *)ajDataValue {
    NSData *data = nil;
    if (!self.ajNonEmpty) {
        return data;
    }
    data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

- (NSDate * _Nonnull (^)(NSString * _Nonnull))ajDateValue {
    kAJWeakSelf
    NSDate * (^block)(NSString *) = ^(NSString *format){
        NSDate *date = nil;
        if (!ajSelf.ajNonEmpty || !format.ajNonEmpty) {
            return date;
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        [formatter setLocale:[NSLocale currentLocale]];
        date = [formatter dateFromString:ajSelf];
        return date;
    };
    return block;
}

- (UIColor *)ajColorValue {
    UIColor *color = UIColor.clearColor;
    if (!self.ajNonEmpty) {
        return color;
    }
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

- (BOOL)ajIsEmail {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return self.ajMatchesRegex(regex);
}

- (BOOL)ajIsMobileNumber {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *regex = @"^(1)[0-9]{10}$";
    return self.ajMatchesRegex(regex);
}

- (BOOL)ajIsNumber {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *regex = @"(^[0-9]*$)";
    return self.ajMatchesRegex(regex);
}

- (BOOL)ajIsPostalcode {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *regex = @"^[0-8]\\d{5}(?!\\d)$";
    return self.ajMatchesRegex(regex);
}

- (BOOL)ajIsUrl {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return self.ajMatchesRegex(regex);
}

- (BOOL)ajIsIDCardNumber {
    if (!self.ajNonEmpty) {
        return NO;
    }
    NSString *value = self;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }
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
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
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

@end

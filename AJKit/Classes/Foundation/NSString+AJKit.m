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

+ (BOOL (^)(NSString *))ajIsEmpty {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (![string isKindOfClass:NSString.class]) {
            return YES;
        }
        if (string.length == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajEncodeUTF8 {
    NSString *(^block)(NSString *) = ^(NSString *string) {
        NSString *encoded = NSString.ajEncode(string, NSUTF8StringEncoding);
        return encoded;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull, NSStringEncoding))ajEncode {

    NSString *(^block)(NSString *, NSStringEncoding) = ^(NSString *string, NSStringEncoding encoding) {
        NSString *encoded = nil;
        if (NSString.ajIsEmpty(string)) {
            return encoded;
        }
        encoded = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                        (__bridge CFStringRef)string,
                                                                                        NULL,
                                                                                        CFSTR("!#$&'()*+,/:;=?@[]"),
                                                                                        (CFStringEncoding)encoding);
        return encoded;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajDecodeUTF8 {
    NSString *(^block)(NSString *) = ^(NSString *string) {
        NSString *encoded = NSString.ajDecode(string, NSUTF8StringEncoding);
        return encoded;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull, NSStringEncoding))ajDecode {
    NSString *(^block)(NSString *, NSStringEncoding) = ^(NSString *string, NSStringEncoding encoding) {
        NSString *decodeString = nil;
        if (NSString.ajIsEmpty(string)) {
            return decodeString;
        }
        decodeString = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string, CFSTR(""),CFStringConvertNSStringEncodingToEncoding(encoding));
        return decodeString;
    };
    return block;
}

+ (id  _Nonnull (^)(NSString * _Nonnull))ajJsonObject {
    id (^block)(NSString *) = ^(NSString *string) {
        id complete = nil;
        if (NSString.ajIsEmpty(string)) {
            return complete;
        }
        NSData *data = NSString.ajDataValue(string);
        complete = NSData.ajJsonValueDecoded(data);
        return complete;
    };
    return block;
}

+ (NSData * _Nonnull (^)(NSString * _Nonnull))ajBase64DecodeToData {
    NSData * (^block)(NSString *) = ^(NSString *base64String) {
        NSMutableData *data = nil;
        if (NSString.ajIsEmpty(base64String)) {
            return data;
        }
        NSInteger length = base64String.length;
        const char *string = [base64String cStringUsingEncoding:NSASCIIStringEncoding];
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
    };
    return block;
}

+ (NSData * _Nonnull (^)(NSString * _Nonnull))ajFileData {
    NSData * (^block)(NSString *) = ^(NSString *string) {
        NSMutableData *data = nil;
        if (NSString.ajIsEmpty(string)) {
            return data;
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@""];
        data = [NSData dataWithContentsOfFile:path];
        return data;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajSequence {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return AJEmptyString;
        }
        NSString *currentDate = NSDate.ajStringValue(NSDate.date, AJYYYYMMDDHHMMSS5);
        NSString *value = [currentDate stringByAppendingString:NSString.ajRandom(10)];
        return value;
    };
    return block;
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

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajHexToDecimal {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return AJEmptyString;
        }
        NSMutableData *stringData = [[NSMutableData alloc] init];
        unsigned char whole_byte;
        char byte_chars[3] = {'\0','\0','\0'};
        int i;
        for (i=0; i < [string length] / 2; i++) {
            byte_chars[0] = [string characterAtIndex:i*2];
            byte_chars[1] = [string characterAtIndex:i*2+1];
            whole_byte = strtol(byte_chars, NULL, 16);
            [stringData appendBytes:&whole_byte length:1];
        }
        return [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding];
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajDecimalToHex {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        NSMutableString *hexString = [[NSMutableString alloc] initWithString:AJEmptyString];
        if (NSString.ajIsEmpty(string)) {
            return hexString;
        }
        NSUInteger len = [string length];
        unichar *chars = malloc(len * sizeof(unichar));
        [string getCharacters:chars];
        hexString = [[NSMutableString alloc] init];
        for(NSUInteger i = 0; i < len; i++ ) {
            [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
        }
        free(chars);
        return hexString;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajBase64Encode {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return AJEmptyString;
        }
        NSData *data = NSString.ajDataValue(string);
        NSString *value = [data base64EncodedStringWithOptions:0];
        return value;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajBase64Decode {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return AJEmptyString;
        }
        NSData *data = NSString.ajBase64DecodeToData(string);
        NSString *value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return value;
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsChinese {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *match = @"(^[\u4e00-\u9fa5]+$)";
        return NSString.ajMatchesRegex(string, match);
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull, NSString * _Nonnull))ajMatchesRegex {
    BOOL (^block)(NSString *, NSString *) = ^(NSString *string, NSString *regex) {
        if (NSString.ajIsEmpty(string) || NSString.ajIsEmpty(regex)) {
            return NO;
        }
        NSError *error = nil;
        NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
        if (error) {
            AJLog(@"NSString+YYAdd create regex error: %@", error);
            return NO;
        }
        NSUInteger result = [pattern numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
        if (result > 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajClearWhiteSpace {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return AJEmptyString;
        }
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *value = [string stringByTrimmingCharactersInSet:set];
        return value;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajClearWhiteSpaceAndNewLine {
    NSString * (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return AJEmptyString;
        }
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSArray *array = [string componentsSeparatedByCharactersInSet:set];
        NSString *value = [array componentsJoinedByString:@""];
        return value;
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull, NSString * _Nonnull))ajContainsString {
    BOOL (^block)(NSString *, NSString *) = ^(NSString *string, NSString *containString) {
        if (NSString.ajIsEmpty(string) || NSString.ajIsEmpty(containString)) {
            return NO;
        }
        BOOL contains = [string rangeOfString:containString].location != NSNotFound;
        return contains;
    };
    return block;
}

+ (NSNumber * _Nonnull (^)(NSString * _Nonnull))ajNumberValue {
    NSNumber * (^block)(NSString *) = ^(NSString *string) {
        NSNumber *number = nil;
        if (NSString.ajIsEmpty(string)) {
            return number;
        }
        NSString *str = [NSString.ajClearWhiteSpace(string) lowercaseString];
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
        number = [formatter numberFromString:string];
        return number;
    };
    return block;
}

+ (NSData * _Nonnull (^)(NSString * _Nonnull))ajDataValue {
    NSData * (^block)(NSString *) = ^(NSString *string) {
        NSData *data = nil;
        if (NSString.ajIsEmpty(string)) {
            return data;
        }
        data = [string dataUsingEncoding:NSUTF8StringEncoding];
        return data;
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsEmail {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        return NSString.ajMatchesRegex(string, regex);
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsMobileNumber {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *regex = @"^(1)[0-9]{10}$";
        return NSString.ajMatchesRegex(string, regex);
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsNumber {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *regex = @"(^[0-9]*$)";
        return NSString.ajMatchesRegex(string, regex);
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsPostalcode {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *regex = @"^[0-8]\\d{5}(?!\\d)$";
        return NSString.ajMatchesRegex(string, regex);
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsUrl {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
        return NSString.ajMatchesRegex(string, regex);
    };
    return block;
}

+ (BOOL (^)(NSString * _Nonnull))ajIsIDCardNumber {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (NSString.ajIsEmpty(string)) {
            return NO;
        }
        NSString *value = string;
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
    };
    return block;
}

+ (NSDate * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))ajDateValue {
    NSDate * (^block)(NSString *, NSString *) = ^(NSString *string, NSString *format){
        NSDate *date = nil;
        if (NSString.ajIsEmpty(string) || NSString.ajIsEmpty(format)) {
            return date;
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        [formatter setLocale:[NSLocale currentLocale]];
        date = [formatter dateFromString:string];
        return date;
    };
    return block;
}

@end

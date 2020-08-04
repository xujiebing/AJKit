//
//  AJTools.m
//  AJon
//
//  Created by HuHao on 15/9/28.
//  Copyright © 2015年 AJon. All rights reserved.
//

#import "AJTools.h"

#define AJ_KEY 0xEC

static NSDictionary *_pubkeysDic;
static NSString *prefsKey = @"ajonprefs"; ///<密钥 加解密的密钥必须相同 可自定义

@implementation AJTools

+ (AJTools *)shareInstance {
    static AJTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{  //!OCLINT
        tools = [[self alloc] init];
    });
    return tools;
}



+ (void)handleURL:(NSString *)url {
    NSString *ipIdentifi = @"connecttcpay:";
    
    if ([url hasPrefix:ipIdentifi]) {
        NSString *ipAddress = [url substringFromIndex:ipIdentifi.length];
        [self setValue:ipAddress forKey:kIPAddress];
    }
}

+ (NSString *)ipAddress:(NSString *)predefineIP {
    NSString *ip = [NSUserDefaults ajObjectForKey:kIPAddress];
    if (ip.length == 0) {
        return predefineIP;
    }
    return ip;
}

+ (NSDictionary *)plistContentWithName:(NSString *)fileName {
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:pathFile];
    return dic;
}

+ (void)openLocationSettingPage {
    if (![CLLocationManager locationServicesEnabled]) {
        NSURL *url = [NSURL URLWithString:[AJTools getPrefskeyWith:@"AppLocationUrl"]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            return;
        }
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

+ (void)openMicrophoneSettingPage {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

+ (void)openWiFiSettingPage {
    NSString *urlString = [self getPrefskeyWith:@"AppWiFiUrl"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}


/**
 打开设置
 */
+ (void)openSettingPage {
    NSURL *url = [NSURL URLWithString:[AJTools getPrefskeyWith:@"AppGeneralUrl"]];
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
}

+ (BOOL)checkSimpleCracking {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:@"SignerIdentity"] != nil)
    {
        return YES;
    }
    return NO;
}


+ (NSString *)getPrefskeyWith:(NSString *)keyName {
    NSString *pubkey = [[self p_pubkeys] objectForKey:keyName];
    unsigned char str[pubkey.length+1];
    for(int i = 0; i < pubkey.length; i++)
    {
        NSString *temp = [pubkey substringWithRange:NSMakeRange(i,1)];
        const char tempChar = *[temp UTF8String];
        str[i] = (AJ_KEY ^ tempChar);
    }
    str[pubkey.length] = (AJ_KEY ^ '\0');
    ajPrefString(str, AJ_KEY);
    unsigned char result[pubkey.length+1];
    memcpy(result, str, pubkey.length+1);
    return [AJTools p_decryptForEncryption:[NSString stringWithFormat:@"%s", result]].ajBase64Decoding;
}

#pragma mark 加密字符串

+ (NSString *)p_encryptForPlainText:(NSString *)plainText {
    //保存加密后的字符
    NSMutableString *encryption=[NSMutableString string];
    //编码转换后的字符串 UTF_8->iso-8859-1
    NSString *encoding=[[NSString alloc]initWithData:[plainText dataUsingEncoding:NSUTF8StringEncoding] encoding:NSISOLatin1StringEncoding];
    
    for(int i=0,j=0;i<encoding.length;i++,j++){
        if(j==prefsKey.length){
            j=0;
        }
        //异或后的字符
        char cipher=(char)([encoding characterAtIndex:i]^[prefsKey characterAtIndex:j]);
        //NSLog(@"%c转成16进制的字符串：%@,%@",cipher,[NSString stringWithFormat:@"%hhx",cipher],[NSString stringWithFormat:@"%x",cipher&0xff]);
        //转成16进制形式的字符串 \x8b转成8b字符串
        NSString *strCipher= [NSString stringWithFormat:@"%hhx",cipher];
        if(strCipher.length == 1){
            [encryption appendFormat:@"0%@",strCipher];
        }else{
            [encryption appendString:strCipher];
        }
    }
    return encryption;
}

#pragma mark 解密 如果不为加密字符则返回原字符

+ (NSString *)p_decryptForEncryption:(NSString *)encryption {
    //保存解密后的字符
    NSMutableString *decryption=[NSMutableString string];
    //解码字符
    NSString *decoding=nil;
    
    for(int i=0,j=0;i<encryption.length/2;i++,j++){
        if(j==prefsKey.length){
            j=0;
        }
        //截取16进制形式的字符串 \x8b中的8b
        NSString *tem=[encryption substringWithRange:NSMakeRange(i*2, 2)];
        char *endptr;
        //把16进制形式的字符串转为字符
        char n=(char)(int)strtoul([tem UTF8String],&endptr,16);
        //判断是否为加密字符
        if (n=='\0'&&*endptr!='\0') {
            [decryption setString:@""];
            break;
        }
        [decryption appendFormat:@"%c",(char)(n^[prefsKey characterAtIndex:j])];
    }
    if (![decryption isEqualToString:@""]) {
        //编码后的字符串 iso-8859-1 -> UTF_8
        decoding=[[NSString alloc]initWithData:[[decryption copy] dataUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    }
    if (decoding==nil) {
        decoding=encryption;
    }
    return decoding;
}

+ (NSDictionary *)p_pubkeys {
    if (_pubkeysDic) {
        return _pubkeysDic;
    }
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BaseFramework" ofType:@"bundle"];
    NSString *plistPath = [NSString stringWithFormat:@"%@/%@",bundlePath, @"prefKeys.plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if (!dic) {
        AJLog(@"未配置prefKeys.plist文件");
    }
    _pubkeysDic = dic;
    return dic;
}

void ajPrefString(unsigned char *str, unsigned char key)
{
    unsigned char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

@end


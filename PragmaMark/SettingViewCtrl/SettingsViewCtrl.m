//
//  SettingsViewCtrl.m
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "SettingsViewCtrl.h"
#import "UserDefaultUtil.h"

NSString * const PragmaMarkDefaultStringKey1 = @"PragmaMarkDefaultStringKey1";
NSString * const PragmaMarkDefaultStringKey2 = @"PragmaMarkDefaultStringKey2";
NSString * const PragmaMarkDefaultStringKey3 = @"PragmaMarkDefaultStringKey3";
NSString * const PragmaMarkDefaultStringKey4 = @"PragmaMarkDefaultStringKey4";
NSString * const PragmaMarkDefaultStringKey5 = @"PragmaMarkDefaultStringKey5";
NSString * const PragmaMarkDefaultStringKey6 = @"PragmaMarkDefaultStringKey6";


@interface SettingsViewCtrl ()

@property (weak) IBOutlet NSTextField *txtOne;
@property (weak) IBOutlet NSTextField *txtTwo;
@property (weak) IBOutlet NSTextField *txtThree;
@property (weak) IBOutlet NSTextField *txtFour;
@property (weak) IBOutlet NSTextField *txtFive;
@property (weak) IBOutlet NSTextField *txtSix;

@end

@implementation SettingsViewCtrl

- (void)windowDidLoad {
    [super windowDidLoad];
    [self updateValueToUI];
}

-(void)updateValueToUI{
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey1]) {
        _txtOne.stringValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey1];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey2]) {
        _txtTwo.stringValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey2];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey3]) {
        _txtThree.stringValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey3];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey4]) {
        _txtFour.stringValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey4];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey5]) {
        _txtFive.stringValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey5];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey6]) {
        _txtSix.stringValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey6];
    }
}

- (IBAction)actionReset:(id)sender {
    [UserDefaultUtil saveValue:@"Life Cycle" forKey:PragmaMarkDefaultStringKey1];
    [UserDefaultUtil saveValue:@"Getters & Setters" forKey:PragmaMarkDefaultStringKey2];
    [UserDefaultUtil saveValue:@"Private Methods" forKey:PragmaMarkDefaultStringKey3];
    [UserDefaultUtil saveValue:@"Public Methods" forKey:PragmaMarkDefaultStringKey4];
    [UserDefaultUtil saveValue:@"Overrided Methods" forKey:PragmaMarkDefaultStringKey5];
    [UserDefaultUtil saveValue:@"Delegate" forKey:PragmaMarkDefaultStringKey6];
    
    [self updateValueToUI];
}

- (IBAction)actionSave:(id)sender {
    NSString* strOne = _txtOne.stringValue;
    NSString* strTwo = _txtTwo.stringValue;
    NSString* strThree = _txtThree.stringValue;
    NSString* strFour = _txtFour.stringValue;
    NSString* strFive = _txtFive.stringValue;
    NSString* strSix = _txtSix.stringValue;
    
    if ([self isNilNoEmptyStr:strOne]) {
        [UserDefaultUtil removeObjectWithKey:PragmaMarkDefaultStringKey1];
    }else{
        [UserDefaultUtil saveValue:strOne forKey:PragmaMarkDefaultStringKey1];
    }
    
    if ([self isNilNoEmptyStr:strTwo]) {
        [UserDefaultUtil removeObjectWithKey:PragmaMarkDefaultStringKey2];
    }else{
        [UserDefaultUtil saveValue:strTwo forKey:PragmaMarkDefaultStringKey2];
    }
    
    if ([self isNilNoEmptyStr:strThree]) {
        [UserDefaultUtil removeObjectWithKey:PragmaMarkDefaultStringKey3];
    }else{
        [UserDefaultUtil saveValue:strThree forKey:PragmaMarkDefaultStringKey3];
    }
    
    if ([self isNilNoEmptyStr:strFour]) {
        [UserDefaultUtil removeObjectWithKey:PragmaMarkDefaultStringKey4];
    }else{
        [UserDefaultUtil saveValue:strFour forKey:PragmaMarkDefaultStringKey4];
    }
    
    if ([self isNilNoEmptyStr:strFive]) {
        [UserDefaultUtil removeObjectWithKey:PragmaMarkDefaultStringKey5];
    }else{
        [UserDefaultUtil saveValue:strFive forKey:PragmaMarkDefaultStringKey5];
    }
    
    if ([self isNilNoEmptyStr:strSix]) {
        [UserDefaultUtil removeObjectWithKey:PragmaMarkDefaultStringKey6];
    }else{
        [UserDefaultUtil saveValue:strSix forKey:PragmaMarkDefaultStringKey6];
    }
}

-(BOOL)isNilNoEmptyStr:(NSString *)str{
    return !str|| (str.length < 1);
}

+(void)loadDefaultSettings{
    if (![UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey1]) {
        [UserDefaultUtil saveValue:@"Life Cycle" forKey:PragmaMarkDefaultStringKey1];
    }
    
    if (![UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey2]) {
        [UserDefaultUtil saveValue:@"Getters & Setters" forKey:PragmaMarkDefaultStringKey2];
    }
    
    if (![UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey3]) {
        [UserDefaultUtil saveValue:@"Private Methods" forKey:PragmaMarkDefaultStringKey3];
    }
    
    if (![UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey4]) {
        [UserDefaultUtil saveValue:@"Public Methods" forKey:PragmaMarkDefaultStringKey4];
    }
    
    if (![UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey5]) {
        [UserDefaultUtil saveValue:@"Overrided Methods" forKey:PragmaMarkDefaultStringKey5];
    }
    
    if (![UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey6]) {
        [UserDefaultUtil saveValue:@"Delegate" forKey:PragmaMarkDefaultStringKey6];
    }
}

+(NSString *)loadStrFromSettings{
    NSString* strRet = @"";
    NSString* tmp = @"#pragma mark - %@\n\n";
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey1]) {
        NSString* strValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey1];
        strRet = [strRet stringByAppendingString:[NSString stringWithFormat:tmp,strValue]];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey2]) {
        NSString* strValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey2];
        strRet = [strRet stringByAppendingString:[NSString stringWithFormat:tmp,strValue]];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey3]) {
        NSString* strValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey3];
        strRet = [strRet stringByAppendingString:[NSString stringWithFormat:tmp,strValue]];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey4]) {
        NSString* strValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey4];
        strRet = [strRet stringByAppendingString:[NSString stringWithFormat:tmp,strValue]];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey5]) {
        NSString* strValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey5];
        strRet = [strRet stringByAppendingString:[NSString stringWithFormat:tmp,strValue]];
    }
    
    if ([UserDefaultUtil hasValueForKey:PragmaMarkDefaultStringKey6]) {
        NSString* strValue = [UserDefaultUtil valueWithKey:PragmaMarkDefaultStringKey6];
        strRet = [strRet stringByAppendingString:[NSString stringWithFormat:tmp,strValue]];
    }
    
    if(strRet.length > 2){
        strRet = [strRet substringToIndex:strRet.length-2];
    }
    
    return strRet;
}

@end
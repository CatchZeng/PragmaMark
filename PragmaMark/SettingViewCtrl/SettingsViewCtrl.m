//
//  SettingsViewCtrl.m
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "SettingsViewCtrl.h"

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
    
    
}

- (IBAction)actionSave:(id)sender {
    NSString* strOne = _txtOne.stringValue;
    NSString* strTwo = _txtTwo.stringValue;
    NSString* strThree = _txtThree.stringValue;
    NSString* strFour = _txtFour.stringValue;
    NSString* strFive = _txtFive.stringValue;
    NSString* strSix = _txtSix.stringValue;
    
    
}

@end

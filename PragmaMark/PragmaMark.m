//
//  PragmaMark.m
//  PragmaMark
//
//  Created by Administrator on 16/9/12.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "PragmaMark.h"
#import "TextResult.h"
#import "NSTextView+TextGetter.h"
#import "KeyboardEventSender.h"
#import "SettingsViewCtrl.h"
#import "UserDefaultUtil.h"

static PragmaMark *sharedPlugin;

NSString* const PragmaMarkDefaultTriggerString = @"ppp";

@interface PragmaMark()

@property (nonatomic, strong) id eventMonitor;
@property (nonatomic, strong) SettingsViewCtrl* settingsViewCtrl;

@end

@implementation PragmaMark

#pragma mark - Initialization

+ (void)pluginDidLoad:(NSBundle *)plugin{
    NSArray *allowedLoaders = [plugin objectForInfoDictionaryKey:@"me.delisa.XcodePluginBase.AllowedLoaders"];
    if ([allowedLoaders containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
        sharedPlugin = [[self alloc] initWithBundle:plugin];
    }
}

+ (instancetype)sharedPlugin{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)bundle{
    if (self = [super init]) {
        _bundle = bundle;
        if (NSApp && !NSApp.mainMenu) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:NSApplicationDidFinishLaunchingNotification object:nil];
        } else {
            [self initializeAndLog];
        }
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    [self initializeAndLog];
}

- (void)initializeAndLog{
    NSString *name = [self.bundle objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *version = [self.bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *status = [self initialize] ? @"loaded successfully" : @"failed to load";
    NSLog(@"🔌 Plugin %@ %@ %@", name, version, status);
    
    [SettingsViewCtrl loadDefaultSettings];
    
    [self addNotification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChangeNotification:)
                                                 name:NSTextDidChangeNotification
                                               object:nil];
}

- (void)textDidChangeNotification:(NSNotification *)aNotification{
    NSTextView *textView = [aNotification object];
    if (![textView isKindOfClass:[NSTextView class]]) return;
    
    NSString* pragmaMarkDefaultString = [SettingsViewCtrl loadStrFromSettings];
    if (!pragmaMarkDefaultString || pragmaMarkDefaultString.length < 1) {
        return;
    }
    
    //获取当前鼠标光标所在行的文字
    TextResult *currentLineResult = [textView textResultOfCurrentLine];
    if (!currentLineResult) {
        return;
    }
    
    //触发标准字符串
    NSString *pattern = [NSString stringWithFormat:@"\\s*%@", PragmaMarkDefaultTriggerString];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAllowCommentsAndWhitespace error:&error];
    if (error) {
        return;
    }
    NSUInteger matches = [regex numberOfMatchesInString:currentLineResult.string options:0 range:NSMakeRange(0, currentLineResult.string.length)];
    if (matches <= 0) {
        return;
    }
    
    //填充PragmaMarkDefaultString
    //保存当前内容到黏贴板
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    NSString *originPBString = [pasteBoard stringForType:NSPasteboardTypeString];
    
    //将PragmaMarkDefaultString放入
    [pasteBoard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [pasteBoard setString:pragmaMarkDefaultString forType:NSStringPboardType];
    
    //模拟键盘按下
    KeyboardEventSender *simKeyboard = [[KeyboardEventSender alloc] init];
    [simKeyboard beginKeyBoradEvents];
    // Command + delete: 删除本行
    [simKeyboard sendKeyCode:kVK_Delete withModifierCommand:YES alt:NO shift:NO control:NO];
    
    // Command + V, 黏贴 (If it is Dvorak layout, use '.', which is corresponding the key 'V' in a QWERTY layout)
    NSInteger kKeyVCode = [KeyboardEventSender useDvorakLayout] ? kVK_ANSI_Period : kVK_ANSI_V;
    [simKeyboard sendKeyCode:kKeyVCode withModifierCommand:YES alt:NO shift:NO control:NO];
    //    [simKeyboard sendKeyCode:kVK_Return];
    
    // The key down is just a defined finish signal by me. When we receive this key, we know operation above is finished.
    [simKeyboard sendKeyCode:kVK_F20];
    
    self.eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask
                                                              handler:^NSEvent *(NSEvent *incomingEvent) {
                                                                  if ([incomingEvent type] == NSKeyDown && [incomingEvent keyCode] == kVK_F20) {
                                                                      // Finish signal arrived, no need to observe the event
                                                                      [NSEvent removeMonitor:_eventMonitor];
                                                                      self.eventMonitor = nil;
                                                                      
                                                                      // Restore previois patse board content
                                                                      [pasteBoard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
                                                                      [pasteBoard setString:originPBString forType:NSStringPboardType];
                                                                      
                                                                      // Set cursor before the inserted magic line. So we can use tab to begin edit.
                                                                      // int baseIndentationLength = (int)[doc baseIndentation].length;
                                                                      // [textView setSelectedRange:NSMakeRange(currentLineResult.range.location + baseIndentationLength, 0)];
                                                                      
                                                                      // Send a 'tab' after insert the doc. For our lazy programmers. :)
                                                                      // [kes sendKeyCode:kVK_Tab];
                                                                      [simKeyboard endKeyBoradEvents];
                                                                      
                                                                      // Invalidate the finish signal, in case you set it to do some other thing.
                                                                      return nil;
                                                                  }
                                                                  else if ([incomingEvent type] == NSKeyDown && [incomingEvent keyCode] == kKeyVCode) {
                                                                      // Select input line and the define code block.
                                                                      // NSRange r = [textView vv_textResultUntilNextString:@";"].range;
                                                                      
                                                                      // NSRange r begins from the starting of enum(struct) line. Select 1 character before to include the trigger input line.
                                                                      // [textView setSelectedRange:NSMakeRange(r.location - 1, r.length + 1)];
                                                                      return incomingEvent;
                                                                  }
                                                                  else {
                                                                      return incomingEvent;
                                                                  }
                                                              }];
}

#pragma mark - Implementation

- (BOOL)initialize{
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Pragma Mark" action:nil keyEquivalent:@""];
        
        NSMenuItem *dc_settingMenuItem = [[NSMenuItem alloc] init];
        dc_settingMenuItem.title  = @"Settings";
        dc_settingMenuItem.target = self;
        dc_settingMenuItem.action = @selector(showSettings);
        
        NSMenu *settingMenu = [[NSMenu alloc] init];
        [settingMenu addItem:dc_settingMenuItem];
        
        [actionMenuItem setSubmenu:settingMenu];
        
        [[menuItem submenu] addItem:actionMenuItem];
        return YES;
    } else {
        return NO;
    }
}

-(void)showSettings{
    [self.settingsViewCtrl showWindow:self.settingsViewCtrl];
}

- (SettingsViewCtrl *)settingsViewCtrl {
    if(_settingsViewCtrl == nil) {
        _settingsViewCtrl = [[SettingsViewCtrl alloc] initWithWindowNibName:NSStringFromClass([SettingsViewCtrl class])];
    }
    return _settingsViewCtrl;
}

@end
//
//  ZHAppSettingViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/8/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHAppSettingViewController.h"

// The value for the 'Text Color' setting is stored as an integer between
// one and three inclusive.  This enumeration provides a mapping between
// the integer value, and color.
typedef NS_ENUM(NSUInteger, TextColor) {
    blue = 1,
    red,
    green
};


// It's best practice to define constant strings for each preference's key.
// These constants should be defined in a location that is visible to all
// source files that will be accessing the preferences.
NSString* const kFirstNameKey			= @"firstNameKey";
NSString* const kLastNameKey			= @"lastNameKey";
NSString* const kNameColorKey			= @"nameColorKey";
NSString* const kFontSizeKey			= @"fontSizeKey";


@interface ZHAppSettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) UIColor *nameColor;
@property (assign) NSUInteger fontSize;

@end

@implementation ZHAppSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"App设置";
    
    // Only iOS 8 and above supports the UIApplicationOpenSettingsURLString
    // used to launch the Settings app from your application.  If the
    // UIApplicationOpenSettingsURLString is not present, we're running on an
    // old version of iOS.  Remove the Settings button from the navigation bar
    // since it won't be able to do anything.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(openSetting:)];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeNotification:) name:NSUserDefaultsDidChangeNotification object:nil];
//    [self didChangeNotification:nil];
    
    // App设置 修改后会保存到 [NSUserDefaults standardUserDefaults] , 但是如果没有改变,  [NSUserDefaults standardUserDefaults] 里面读取不到任何数据, 所以初始化时要把 App设置
    // 保存到 [NSUserDefaults standardUserDefaults]
    [self populateRegistrationDomain];
}

//| ----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Load our preferences.  Preloading the relevant preferences here will
    // prevent possible diskIO latency from stalling our code in more time
    // critical areas, such as tableView:cellForRowAtIndexPath:, where the
    // values associated with these preferences are actually needed.
    [self didChangeNotification:nil];
    
    // Begin listening for changes to our preferences when the Settings app does
    // so, when we are resumed from the backround, this will give us a chance to
    // update our UI
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeNotification:) name:NSUserDefaultsDidChangeNotification object:nil];
}


//| ----------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Stop listening for the NSUserDefaultsDidChangeNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openSetting:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)didChangeNotification:(NSNotification *)notification
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    self.firstName = [standardDefaults objectForKey:kFirstNameKey];
    self.lastName = [standardDefaults objectForKey:kLastNameKey];
    
    // The value for the 'Text Color' setting is stored as an integer between
    // one and three inclusive.  Convert the integer into a UIColor object.
    TextColor textColor = [standardDefaults integerForKey:kNameColorKey];
    switch (textColor) {
        case blue:
            self.nameColor = [UIColor blueColor];
            break;
        case red:
            self.nameColor = [UIColor redColor];
            break;
        case green:
            self.nameColor = [UIColor greenColor];
            break;
        default:
            NSAssert(NO, @"Got an unexpected value %@ for %@", @(textColor), kNameColorKey);
    }
    
    self.fontSize = [standardDefaults integerForKey:kFontSizeKey];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    self.nameLabel.textColor = self.nameColor;
    self.nameLabel.font = [UIFont systemFontOfSize:self.fontSize];
}


//| ----------------------------------------------------------------------------
//! Locates the file representing the root page of the settings for this app,
//! invokes loadDefaults:fromSettingsPage:inSettingsBundleAtURL: on it,
//! and registers the loaded values as the app's defaults.
//
- (void)populateRegistrationDomain
{
    NSURL *settingsBundleURL = [[NSBundle mainBundle] URLForResource:@"Settings" withExtension:@"bundle"];
    
    // Invoke loadDefaultsFromSettingsPage:inSettingsBundleAtURL: on the property
    // list file for the root settings page (always named Root.plist).
    NSDictionary *appDefaults = [self loadDefaultsFromSettingsPage:@"Root.plist" inSettingsBundleAtURL:settingsBundleURL];
    
    NSLog(@"load setting %@", appDefaults);
    
    // appDefaults is now populated with the preferences and their default values.
    // Add these to the registration domain.
    // 注意:此处是设置默认值,而不是赋值,所以如果有值的,默认值就不生效了
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"set setting firstName %@", [standardDefaults objectForKey:kFirstNameKey]);
    NSLog(@"set setting lastName %@", [standardDefaults objectForKey:kLastNameKey]);
    NSLog(@"set setting kNameColorKey %ld", [standardDefaults integerForKey:kNameColorKey]);

}


//| ----------------------------------------------------------------------------
//! Helper function that parses a Settings page file, extracts each preference
//! defined within along with its default value.  If the page contains a
//! 'Child Pane Element', this method will recurs on the referenced page file.
//
- (NSDictionary*)loadDefaultsFromSettingsPage:(NSString*)plistName inSettingsBundleAtURL:(NSURL*)settingsBundleURL
{
    // Each page of settings is represented by a property-list file that follows
    // the Settings Application Schema:
    // <https://developer.apple.com/library/ios/#documentation/PreferenceSettings/Conceptual/SettingsApplicationSchemaReference/Introduction/Introduction.html>.
    
    // Create an NSDictionary from the plist file.
    NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfURL:[settingsBundleURL URLByAppendingPathComponent:plistName]];
    
    // The elements defined in a settings page are contained within an array
    // that is associated with the root-level PreferenceSpecifiers key.
    NSArray *prefSpecifierArray = settingsDict[@"PreferenceSpecifiers"];
    
    // If prefSpecifierArray is nil, something wen't wrong.  Either the
    // specified plist does ot exist or is malformed.
    if (prefSpecifierArray == nil)
        return nil;
    
    // Create a dictionary to hold the parsed results.
    NSMutableDictionary *keyValuePairs = [NSMutableDictionary dictionary];
    
    for (NSDictionary *prefItem in prefSpecifierArray)
        // Each element is itself a dictionary.
    {
        // What kind of control is used to represent the preference element in the
        // Settings app.
        NSString *prefItemType = prefItem[@"Type"];
        // How this preference element maps to the defaults database for the app.
        NSString *prefItemKey = prefItem[@"Key"];
        // The default value for the preference key.
        NSString *prefItemDefaultValue = prefItem[@"DefaultValue"];
        
        if ([prefItemType isEqualToString:@"PSChildPaneSpecifier"])
            // If this is a 'Child Pane Element'.  That is, a reference to another
            // page.
        {
            // There must be a value associated with the 'File' key in this preference
            // element's dictionary.  Its value is the name of the plist file in the
            // Settings bundle for the referenced page.
            NSString *prefItemFile = prefItem[@"File"];
            
            // Recurs on the referenced page.
            NSDictionary *childPageKeyValuePairs = [self loadDefaultsFromSettingsPage:prefItemFile inSettingsBundleAtURL:settingsBundleURL];
            
            // Add the results to our dictionary
            [keyValuePairs addEntriesFromDictionary:childPageKeyValuePairs];
        }
        else if (prefItemKey != nil && prefItemDefaultValue != nil)
            // Some elements, such as 'Group' or 'Text Field' elements do not contain
            // a key and default value.  Skip those.
        {
            keyValuePairs[prefItemKey] = prefItemDefaultValue;
        }
    }
    
    return keyValuePairs;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

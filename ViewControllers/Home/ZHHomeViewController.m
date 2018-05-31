//
//  ZHHomeViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHHomeViewController.h"
#import "ZHAVPlayerViewController.h"
#import "ZHLayoutVisualFormatViewController.h"
#import "ZHAFNetworkingViewController.h"
#import "ZHTestEncryptionViewController.h"
#import "ZHTestYapdatabaseViewController.h"
#import "ZHTestModel.h"
#import "ZHTests.h"
#import "ZHCameraViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ZHDisplayLinkViewController.h"
#import "ZHTestBonjourViewController.h"

#import "APLResultsTableController.h"
#import "ZHMotionViewController.h"
#import "ZHPredicateViewController.h"
#import "ZHRuntimeTableViewController.h"
#import "ZHJsonTestViewController.h"
#import "ZHTestLeakedMemoryViewController.h"

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface ZHHomeViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

// our secondary search results table view
@property (nonatomic, strong) APLResultsTableController *resultsTableController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end

@implementation ZHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"主页";
    self.hidesBottomBarWhenPushed = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"AVPlayer" className:NSStringFromClass([ZHAVPlayerViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"Constraint-VisualFormat" className:NSStringFromClass([ZHLayoutVisualFormatViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"AFNetworking" className:NSStringFromClass([ZHAFNetworkingViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"Encryption" className:NSStringFromClass([ZHTestEncryptionViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"YapDatabase" className:NSStringFromClass([ZHTestYapdatabaseViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"FMDB" className:NSStringFromClass([ZHTestFMDBViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"Motion" className:NSStringFromClass([ZHTestMotionViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"AppSetting" className:NSStringFromClass([ZHAppSettingViewController class])];
        [array addObject:model];
    }
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"Camera" className:NSStringFromClass([ZHCameraViewController class]) showViewStyle:ZHTestModelShowViewStylePresent];
        [array addObject:model];
    }
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"提示音" methodName:NSStringFromSelector(@selector(playSystemSound))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"震动" methodName:NSStringFromSelector(@selector(shake))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"New UILocalNotification" methodName:NSStringFromSelector(@selector(createLocalNotification))]];
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"DisplayLink" className:NSStringFromClass([ZHDisplayLinkViewController class])];
        [array addObject:model];
    }
//    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Stack View" className:NSStringFromClass([ZHStackViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Motion" className:NSStringFromClass([ZHMotionViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Block" className:NSStringFromClass([ZHTestBlockViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Photos" className:NSStringFromClass([ZHTestPhotoLibraryViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"OpenGLES" className:NSStringFromClass([ZHTestOpenGLESViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Bonjour" className:NSStringFromClass([ZHTestBonjourViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Predicate" className:NSStringFromClass([ZHPredicateViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Runtime" className:NSStringFromClass([ZHRuntimeTableViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"Json" className:NSStringFromClass([ZHJsonTestViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"内存泄漏" className:NSStringFromClass([ZHTestLeakedMemoryViewController class])]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"GPUImage" className:@"GPUImageStoryboard" showViewStyle:ZHTestModelShowViewStylePush createType:ZHTestModelCreateTypeStoryboard]];
    
    self.dataArray = array;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:nil] forCellReuseIdentifier:ZH_TABLEVIEWCELL_ID];
    
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", self.dataArray.count];
    
    [self initSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
    
    // 如何实现滚动到搜索栏下面?
    //    [self.tableView setContentOffset:CGPointMake(0, self.searchController.searchBar.frame.size.height) animated:YES];
    
    // 滚动到底部
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:NO];
    }
}

- (void)initSearch
{
    _resultsTableController = [[APLResultsTableController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
}

- (void)playSystemSound
{
//    static int viid = 1000;
    AudioServicesPlaySystemSound(1002);
//    NSLog(@"viid %d", viid);
}

- (void)shake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)createLocalNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];

    //设置本地通知的触发时间（如果要立即触发，无需设置），这里设置为20妙后
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //设置本地通知的时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //设置通知的标题
    localNotification.alertTitle = @"通知的标题";
    //设置通知的内容
    localNotification.alertBody = @"通知的内容";
    //设置通知动作按钮的标题
    localNotification.alertAction = @"查看";
    //设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"id",[NSNumber numberWithInteger:1],@"time",[NSNumber numberWithInt:2],@"affair.aid", nil];
    localNotification.userInfo = infoDic;
    //在规定的日期触发通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    ZHLog(@"createLocalNotification %@", localNotification);
    //立即触发一个通知
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

//#pragma mark - UITableViewDataSource
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSMutableArray *arr = [NSMutableArray array];
////    [arr addObject:@"{search}"];//等价于[arr addObject:UITableViewIndexSearch];
//    [arr addObject:UITableViewIndexSearch];
//    return arr;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
//    return;
    NSMutableArray *searchResults = [self.dataArray mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    //
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems) {
        // each searchString creates an OR predicate for: name, yearIntroduced, introPrice
        //
        // example if searchItems contains "iphone 599 2007":
        //      name CONTAINS[c] "iphone"
        //      name CONTAINS[c] "599", yearIntroduced ==[c] 599, introPrice ==[c] 599
        //      name CONTAINS[c] "2007", yearIntroduced ==[c] 2007, introPrice ==[c] 2007
        //
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        // Below we use NSExpression represent expressions in our predicates.
        // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value)
        
        // name field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"title"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
//        // yearIntroduced field matching
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
//        NSNumber *targetNumber = [numberFormatter numberFromString:searchString];
//        if (targetNumber != nil) {   // searchString may not convert to a number
//            lhs = [NSExpression expressionForKeyPath:@"yearIntroduced"];
//            rhs = [NSExpression expressionForConstantValue:targetNumber];
//            finalPredicate = [NSComparisonPredicate
//                              predicateWithLeftExpression:lhs
//                              rightExpression:rhs
//                              modifier:NSDirectPredicateModifier
//                              type:NSEqualToPredicateOperatorType
//                              options:NSCaseInsensitivePredicateOption];
//            [searchItemsPredicate addObject:finalPredicate];
//            
//            // price field matching
//            lhs = [NSExpression expressionForKeyPath:@"introPrice"];
//            rhs = [NSExpression expressionForConstantValue:targetNumber];
//            finalPredicate = [NSComparisonPredicate
//                              predicateWithLeftExpression:lhs
//                              rightExpression:rhs
//                              modifier:NSDirectPredicateModifier
//                              type:NSEqualToPredicateOperatorType
//                              options:NSCaseInsensitivePredicateOption];
//            [searchItemsPredicate addObject:finalPredicate];
//        }
        
        // at this OR predicate to our master AND predicate
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    APLResultsTableController *tableController = (APLResultsTableController *)self.searchController.searchResultsController;
    tableController.filteredProducts = searchResults;
    [tableController.tableView reloadData];
}


@end

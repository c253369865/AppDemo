//
//  ZHPredicateViewController.m
//  AppDemo
//
//  Created by TerryChao on 2017/2/27.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHPredicateViewController.h"

@interface ZHPredicateViewController ()

@end

@implementation ZHPredicateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSPredicate";
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    {
        ZHLog(@"1.比较运算符");
        
        NSNumber *number = @123;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = 123"];
        if ([predicate evaluateWithObject:number]) {
            ZHLog(@"test %@", number);
        }
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF == 123"];
        if ([predicate1 evaluateWithObject:number]) {
            ZHLog(@"test1 %@", number);
        }
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF > 123"];
        if ([predicate2 evaluateWithObject:number]) {
            ZHLog(@"test2 %@", number);
        }
        else {
            ZHLog(@"test2 %@", @"no match");
        }
        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF BETWEEN {100, 210}"];
        if ([predicate3 evaluateWithObject:number]) {
            ZHLog(@"test3 %@", number);
        }
        else {
            ZHLog(@"test3 %@", @"no match");
        }
    }
    
    {
        ZHLog(@"2.逻辑运算符");
        
        NSArray *numbers = @[@1, @2, @3, @4, @5];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF > 2 && SELF < 5"];
        NSArray *filterArray = [numbers filteredArrayUsingPredicate:predicate];
        ZHLog(@"filter Array %@", filterArray);
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF < 2 || SELF > 5"];
        NSArray *filterArray1 = [numbers filteredArrayUsingPredicate:predicate1];
        ZHLog(@"filter Array1 %@", filterArray1);
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"NOT (SELF > 3)"];
        NSArray *filterArray2 = [numbers filteredArrayUsingPredicate:predicate2];
        ZHLog(@"filter Array2 %@", filterArray2);
        
        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"! (SELF > 3)"];
        NSArray *filterArray3 = [numbers filteredArrayUsingPredicate:predicate3];
        ZHLog(@"filter Array3 %@", filterArray3);
        
        NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"! SELF > 3"];
        NSArray *filterArray4 = [numbers filteredArrayUsingPredicate:predicate4];
        ZHLog(@"filter Array4 %@", filterArray4);
    }
    
    {
        ZHLog(@"3.字符串比较运算符");
        
        NSString *string = @"你好abc123哈哈!@key可以了.";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH '你'"];
        if ([predicate evaluateWithObject:string]) {
            ZHLog(@"%@ BEGINSWITH %@", string, @"你");
        }
        // 崩溃 BEGINWITH
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF ENDSWITH '.'"];
        if ([predicate1 evaluateWithObject:string]) {
            ZHLog(@"%@ ENDSWITH %@", string, @".");
        }
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF CONTAINS \"abc\""];
        if ([predicate2 evaluateWithObject:string]) {
            ZHLog(@"%@ CONTAINS %@", string, @"abc");
        }
        
        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF LIKE '*abc*'"];
        if ([predicate3 evaluateWithObject:string]) {
            ZHLog(@"%@ LIKE %@", string, @"*abc*");
        }
        // @"SELF LIKE 'abc'" 找不到
        
        NSString *regex = @"^*.+3$";
        NSPredicate *predicate4 = [NSPredicate predicateWithFormat:[NSString stringWithFormat: @"SELF MATCHES '%@'", regex]];
        if ([predicate4 evaluateWithObject:string]) {
            ZHLog(@"%@ MATCHES %@", string, regex);
        }
        else {
           ZHLog(@"%@ NOT MATCHES %@", string, regex);
        }
        //  崩溃 @"SELF MATCHES \"*abc*\""
    }
    
    
    {
        ZHLog(@"2.错误语法,将会导致崩溃,而且很难排查,要注意!!!! 打开下面代码,将会崩溃.");
        
//        NSArray *numbers = @[@1, @2, @3, @4, @5];
//        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF < 2 && SELF > 5 2"];
//        NSArray *filterArray1 = [numbers filteredArrayUsingPredicate:predicate1];
//        ZHLog(@"error Array1 %@", filterArray1);
    }

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

//
//  ZHTestBlockViewController.m
//  AppDemo
//
//  Created by TerryChao on 2016/12/14.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestBlockViewController.h"

@interface ZHTestBlockViewController ()

@property NSInteger memberVariable;

@end

@implementation ZHTestBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self testAccessVariable];
    [self testAccessSelf];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testAccessVariable
{
    NSInteger outsideVariable = 10;
    //__block NSInteger outsideVariable = 10;
    NSMutableArray * outsideArray = [[NSMutableArray alloc] init];
    static NSInteger staticInt = 10;
    
    void (^blockObject)(void) = ^(void){
        NSInteger insideVariable = 20;
        NSLog(@"  > member variable = %ld", self.memberVariable);
        NSLog(@"  > outside variable = %ld", outsideVariable);
        NSLog(@"  > inside variable = %ld", insideVariable);
        NSLog(@"  > staticInt variable = %ld", staticInt);
        
        [outsideArray addObject:@"AddedInsideBlock"];
    };
    
    void (^haha)(void) = ^() {
        
    };
    
    int (^block)(NSString *) = ^(NSString *hs) {
        return 1;
    };
    
    NSArray * (^block1)(NSDictionary *) = ^(NSDictionary *dic) {
        return [NSArray array];
    };
    haha();
    block(@"");
    block1(nil);
    
    outsideVariable = 30;
    self.memberVariable = 30;
    staticInt = 50;
    
    blockObject();
    
    NSLog(@"  > %ld items in outsideArray", [outsideArray count]);
}

typedef NSString* (^IntToStringConverter)(id self, NSInteger paramInteger);
- (NSString *) convertIntToString:(NSInteger)paramInteger
                 usingBlockObject:(IntToStringConverter)paramBlockObject
{
    return paramBlockObject(self, paramInteger);
}

typedef NSString* (^IntToStringInlineConverter)(NSInteger paramInteger);
- (NSString *) convertIntToStringInline:(NSInteger)paramInteger
                       usingBlockObject:(IntToStringInlineConverter)paramBlockObject
{
    return paramBlockObject(paramInteger);
}

IntToStringConverter independentBlockObject = ^(id self, NSInteger paramInteger) {
    NSLog(@" >> self %@, memberVariable %ld", self, [self memberVariable]);
    
    NSString *result = [NSString stringWithFormat:@"%ld", paramInteger];
    NSLog(@" >> independentBlockObject %@", result);
    return result;
};

- (void)testAccessSelf
{
    // Independent
    //
    [self convertIntToString:20 usingBlockObject:independentBlockObject];
    
    // Inline
    //
    IntToStringInlineConverter inlineBlockObject = ^(NSInteger paramInteger) {
        NSLog(@" >> self %@, memberVariable %ld", self, self.memberVariable);
        
        NSString *result = [NSString stringWithFormat:@"%ld", paramInteger];
        NSLog(@" >> inlineBlockObject %@", result);
        return result;
    };
    [self convertIntToStringInline:20 usingBlockObject:inlineBlockObject];
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

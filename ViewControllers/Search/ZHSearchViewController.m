//
//  ZHSearchViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHSearchViewController.h"
#import "PPLabel.h"

@interface ZHSearchViewController () <PPLabelDelegate>

@property (nonatomic, copy) NSString *filePath;

@property (weak, nonatomic) IBOutlet PPLabel *ppLabel;

@end

@implementation ZHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索";
    
//    [self showLoadingText:@"等等我,马上来~" hideAfterDelay:10];
    
    self.ppLabel.text = @"hahahfasdfasdf sadflsadfjsadfjsa;ldfjsad;fjsa fsal fsalf asjdlf;jafld;s ";
    [self.ppLabel setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    UIImage *image = [UIImage imageNamed:@"cat"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    imageView.image = image;
    NSString *fileCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/WTImages/IM/"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileCacheDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    NSString *cacheimagePath = [fileCacheDir stringByAppendingPathComponent:fileName];
    BOOL isSaveImage = [[NSFileManager defaultManager] createFileAtPath:cacheimagePath contents:imageData attributes:nil];
    if (isSaveImage) {
        NSLog(@"ok %@", cacheimagePath);
    }
    [self.view addSubview:imageView];
    self.filePath = cacheimagePath;
}

- (IBAction)check:(id)sender {
//    NSString *filePath = self.filePath;
    NSString *fileCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/WTImages/IM/"];
    NSString *filePath = @"/var/mobile/Containers/Data/Application/BBB0C670-40EC-4F62-BD69-FE7AEA0CB46C/Library/Caches/WTImages/IM/20160920171447.jpg";
    NSString *cacheimagePath = [fileCacheDir stringByAppendingPathComponent:@"20160920171447.jpg"];
    if ([filePath isEqualToString:cacheimagePath]) {
        NSLog(@"equal");
    }
    else {
       NSLog(@"no equal");
    }
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:cacheimagePath];
    NSLog(@"exist %@", exist ? @"YES" : @"NO");
}

- (IBAction)enumfile:(id)sender {
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *fileCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/WTImages/IM/"];
    //方法一
    NSArray *file = [fileManage subpathsOfDirectoryAtPath:fileCacheDir error:nil];
    NSLog(@"%@",file);
}

- (IBAction)nemu:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self becomeFirstResponder];
    [btn becomeFirstResponder];
    
    UIMenuItem *add = [[UIMenuItem alloc] initWithTitle:@"添加到笔记" action:@selector(menuItemClick:)];
    UIMenuItem *translate = [[UIMenuItem alloc] initWithTitle:@"翻译" action:@selector(menuItemClick:)];
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuItemClick:)];
    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuItemClick:)];
    UIMenuController *menu=[UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:add,translate,copy, delete, nil]];
    [menu setTargetRect:btn.frame inView:self.view];
    menu.arrowDirection = UIMenuControllerArrowDown;
    [menu update];
    [menu setMenuVisible:NO];
    [menu setMenuVisible:YES animated:YES];
    NSLog(@"show menus :%@", menu.menuItems);

}

- (void)menuItemClick:(id)sender
{
    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return YES;
}


#pragma mark - PPLabelDelegate

- (void)label:(PPLabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
//    int c = 3;
}

- (void)label:(PPLabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
//    int c = 3;
}


- (void)label:(PPLabel *)label didEndTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex
{
//    int c = 3;
//    for (NSTextCheckingResult *match in self.matches) {
//        
//        if ([match resultType] == NSTextCheckingTypeLink) {
//            
//            NSRange matchRange = [match range];
//            
//            if ([self isIndex:charIndex inRange:matchRange]) {
//                
//                [[UIApplication sharedApplication] openURL:match.URL];
//                break;
//            }
//        }
//    }
}

- (void)label:(PPLabel*)label didCancelTouch:(UITouch*)touch
{
//    int c = 3;
}

- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range {
    return index > range.location && index < range.location+range.length;
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

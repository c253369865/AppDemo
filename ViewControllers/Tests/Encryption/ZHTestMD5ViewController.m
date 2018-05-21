//
//  ZHTestMD5ViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/28.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestMD5ViewController.h"
#import <MD5Digest/NSString+MD5.h>
#import <CocoaSecurity.h>

@interface ZHTestMD5ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *md5CocosButton;
@property (weak, nonatomic) IBOutlet UIButton *aesEncryButton;
@property (weak, nonatomic) IBOutlet UIButton *aesDecryButton;
@property (weak, nonatomic) IBOutlet UITextView *originTextTextView;
@property (weak, nonatomic) IBOutlet UILabel *md5ResultLabel;

@end

@implementation ZHTestMD5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"MD5";
    
    CGFloat cornerRadius = 4.0;
    self.button.layer.cornerRadius = cornerRadius;
    self.md5CocosButton.layer.cornerRadius = cornerRadius;
    self.aesEncryButton.layer.cornerRadius = cornerRadius;
    self.aesDecryButton.layer.cornerRadius = cornerRadius;
    
    self.textView.text = @"601814";
}

- (IBAction)buttonTouchUpInside:(id)sender {
    NSString *text = self.textView.text;
    NSString *resultText = [text MD5Digest];
    self.originTextTextView.text = text;
    self.md5ResultLabel.text = resultText;
//    self.textView.text = @"";
    ZHLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    ZHLog(@"text:%@",text);
    ZHLog(@"md5:%@",resultText);
    [self.textView resignFirstResponder];
}

- (IBAction)md5CocosButtonTouchUpInside:(id)sender {
    NSString *text = self.textView.text;
    CocoaSecurityResult *result = [CocoaSecurity md5:text];
//    NSString *resultText = result.utf8String;
    NSString *hex = result.hexLower;
//    NSString *base64 = result.base64;
//    NSString *dataText = [[NSString alloc] initWithData:result.data encoding:NSUTF8StringEncoding];
    self.originTextTextView.text = text;
    self.md5ResultLabel.text = hex;
//    self.textView.text = @"";
    ZHLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    ZHLog(@"text:%@",text);
    ZHLog(@"CocoaSecurityResult:%@",result);
    [self.textView resignFirstResponder];
}

- (IBAction)aesEncryButtonTouchUpInside:(id)sender {
    NSString *text = self.textView.text;
    CocoaSecurityResult *result = [CocoaSecurity aesEncrypt:text key:@"aes"];
    NSString *resultText = result.hexLower;
    self.originTextTextView.text = text;
    self.md5ResultLabel.text = resultText;
//    self.textView.text = @"";
    ZHLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    ZHLog(@"text:%@",text);
    ZHLog(@"CocoaSecurityResult:%@",result);
    [self.textView resignFirstResponder];
}

- (IBAction)aesDecryButtonTouchUpInside:(id)sender {
    NSString *text = self.md5ResultLabel.text;
    CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithBase64:text key:@"aes"];
    NSString *resultText = result.hexLower;
    self.originTextTextView.text = text;
    self.md5ResultLabel.text = resultText;
//    self.textView.text = @"";
    ZHLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    ZHLog(@"text:%@",text);
    ZHLog(@"CocoaSecurityResult:%@",result);
    [self.textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

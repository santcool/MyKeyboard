//
//  SCViewController.m
//  MyKeyboard
//
//  Created by zhangwenfeng [张文锋] on 11/22/2017.
//  Copyright (c) 2017 zhangwenfeng [张文锋]. All rights reserved.
//

#import "SCViewController.h"
#import "MIFIKeyboardView.h"
#import "MyCommon.h"

@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(15, 64, self.view.frame.size.width - 30, 44)];
    field.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
    field.layer.borderWidth = 0.5;
    [self.view addSubview:field];
    
    NSString *string = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"keyboardAllKeys" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    MIFIKeyboardView *keyView = [[MIFIKeyboardView alloc] initWithConfig:string];
    keyView.typingBlock = ^(NSString *str) {
        if ([str isEqualToString:kMILDeleteStr] && field.text.length) {
            field.text = [field.text substringToIndex:field.text.length-1];
            return;
        }
        [field setText:[field.text stringByAppendingString:str]];
    };
    [keyView showInView:self.view];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

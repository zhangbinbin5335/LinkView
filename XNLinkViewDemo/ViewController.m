//
//  ViewController.m
//  XNLinkViewDemo
//
//  Created by 张彬彬 on 2018/4/4.
//  Copyright © 2018年 张彬彬. All rights reserved.
//

#import "ViewController.h"
// view
#import "XNLinkView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    NSString *text = @"这是个测试链接http://baidu.com";
    XNLinkView *linkView = [XNLinkView linkWithText:text
                                          linkRange:NSMakeRange(7, text.length - 7)
                                              click:^(NSString *linkText) {
                                                  UIAlertView *av = [[UIAlertView alloc]
                                                                     initWithTitle:@"链接"
                                                                     message:linkText
                                                                     delegate:nil
                                                                     cancelButtonTitle:@"cancel"
                                                                     otherButtonTitles:nil, nil];
                                                  
                                                  [av show];
                                              }
                            ];
    
    linkView.frame = CGRectMake(100, 100, 150, 100);
    linkView.backgroundColor = [UIColor yellowColor];
    linkView.userInteractionEnabled = YES;
    [self.view addSubview:linkView];
}



@end

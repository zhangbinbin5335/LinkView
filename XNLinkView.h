//
//  CTLinkView.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XNLinkViewClick)(NSString *linkText);
@interface XNLinkView : UIView

@property (nonatomic, copy) NSString *content; // 显示内容,重新赋值，属性将被重置
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, strong) UIColor *linkColor; // 链接文字颜色
@property (nonatomic, strong) UIFont *linkFont;
@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

- (instancetype)initWithText:(NSString *)text linkRange:(NSRange)linkRange click:(XNLinkViewClick)click;
+ (instancetype)linkWithText:(NSString *)text linkRange:(NSRange)linkRange click:(XNLinkViewClick)click;
/**
 添加链接范围

 @param range 范围
 @param click 链接点击回调
 */
-(void)addLink:(NSRange)range click:(XNLinkViewClick)click;

@end

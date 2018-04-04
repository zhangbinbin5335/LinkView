//
//  CTLinkView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "XNLinkView.h"

@interface XNLinkView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSMutableDictionary *clicks;

@end

@implementation XNLinkView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textView];
        _contentFont = [UIFont systemFontOfSize:12];// [MyTool regularFontWithSize:12];
        _linkColor = [UIColor redColor];//UIColorFromRGB(0x008EFF);
        _linkFont = _contentFont;
        self.textView.font = _contentFont;
        self.textView.linkTextAttributes = @{NSForegroundColorAttributeName : _linkColor};
//        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.top.equalTo(self);
//        }];
        
        // 添加 top 约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:0];
        [self addConstraint:topConstraint];
        // 添加 bottom 约束
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1
                                                                             constant:0];
        [self addConstraint:bottomConstraint];
        // 添加 left 约束
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
        [self addConstraint:leftConstraint];
        // 添加 right 约束
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:0];
        [self addConstraint:rightConstraint];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.textView];
        _contentFont = [UIFont systemFontOfSize:12];// [MyTool regularFontWithSize:12];
        _linkColor = [UIColor redColor];//UIColorFromRGB(0x008EFF);
        _linkFont = _contentFont;
        self.textView.font = _contentFont;
        self.textView.linkTextAttributes = @{NSForegroundColorAttributeName : _linkColor};
        //        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.bottom.top.equalTo(self);
        //        }];
        
        // 添加 top 约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:0];
        [self addConstraint:topConstraint];
        // 添加 bottom 约束
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1
                                                                             constant:0];
        [self addConstraint:bottomConstraint];
        // 添加 left 约束
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
        [self addConstraint:leftConstraint];
        // 添加 right 约束
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:0];
        [self addConstraint:rightConstraint];
    }
    
    return self;
}

- (instancetype )initWithText:(NSString *)text
                    linkRange:(NSRange)linkRange
                        click:(XNLinkViewClick)click{
    if ([self initWithFrame:CGRectZero]) {
    
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]
                                                 initWithString:text];
        NSString *linkName = NSStringFromRange(linkRange);
        [attrString setAttributes:@{NSLinkAttributeName : linkName,
                                    NSFontAttributeName : _contentFont}
                            range:linkRange];
        _textView.attributedText = attrString;
        [self.clicks setValue:click forKey:linkName];
    }
    
    return self;
}

+ (instancetype)linkWithText:(NSString *)text linkRange:(NSRange)linkRange click:(XNLinkViewClick)click{
    return [[XNLinkView alloc]initWithText:text linkRange:linkRange click:click];
}


#pragma mark - 🔒private

#pragma mark - 🍐delegate
- (BOOL)textView:(UITextView *)textView
shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange
     interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
    if (interaction == UITextItemInteractionInvokeDefaultAction){
        NSString *rangeString = NSStringFromRange(characterRange);
        XNLinkViewClick click = (XNLinkViewClick)self.clicks[rangeString];
        if(click){
            click([textView.text substringWithRange:characterRange]);
            return NO;
        }
    }
    
    return NO;
}

- (BOOL)textView:(UITextView *)textView
shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange
NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead"){
    NSString *rangeString = NSStringFromRange(characterRange);
    XNLinkViewClick click = (XNLinkViewClick)self.clicks[rangeString];
    if(click){
        click([textView.text substringWithRange:characterRange]);
        return YES;
    }
    
    return NO;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if(!NSEqualRanges(textView.selectedRange, NSMakeRange(0, 0))) {
        textView.selectedRange = NSMakeRange(0, 0);
    }
}

#pragma mark - 🚪public
-(void)addLink:(NSRange)range click:(XNLinkViewClick)click{
    NSAttributedString *content = _textView.attributedText;
    if ((range.location + range.length) > content.length) {
        return;
    }
    NSMutableAttributedString *assrString = [[NSMutableAttributedString alloc]
                                             initWithAttributedString:content];
    NSString *linkName = NSStringFromRange(range);
    if (_paragraphStyle) {
        [assrString setAttributes:@{NSLinkAttributeName:linkName,
                                    NSFontAttributeName : _linkFont,
                                    NSParagraphStyleAttributeName : _paragraphStyle,
                                    }
                            range:range];
    }else{
        [assrString setAttributes:@{NSLinkAttributeName:linkName,
                                    NSFontAttributeName : _linkFont
                                    }
                            range:range];
    }
    _textView.attributedText = nil;
    _textView.attributedText = assrString;
    [self.clicks setValue:click forKey:linkName];
}

#pragma mark - ☸getter and setter
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.editable = NO;
        _textView.delegate = self;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.scrollEnabled = NO;
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor]};
        _textView.backgroundColor = [UIColor clearColor];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _textView;
}

-(NSMutableDictionary *)clicks{
    if (!_clicks) {
        _clicks = [[NSMutableDictionary alloc] init];
    }
    
    return _clicks;
}

-(void)setContent:(NSString *)content{
    if ([_content isEqualToString:content]) {
        return;
    }
    _content = [content copy];
    _textView.attributedText = nil;
    _clicks = nil;
    NSMutableDictionary *attributes = @{NSFontAttributeName : _contentFont,
                                        NSForegroundColorAttributeName : _contentColor
                                        }.mutableCopy;
    if (_paragraphStyle) {
        [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName : _paragraphStyle}];
    }
    _textView.attributedText = [[NSAttributedString alloc]initWithString:content
                                                              attributes:attributes];
}

-(void)setContentFont:(UIFont *)contentFont{
    if ([_contentFont isEqual:contentFont]) {
        return;
    }
    
    _contentFont = contentFont;
    if (_content && _content.length > 0) {
        NSMutableAttributedString *textAttStr = [[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
        [textAttStr removeAttribute:NSFontAttributeName range:NSMakeRange(0, textAttStr.length)];
        [textAttStr addAttributes:@{NSFontAttributeName : _contentFont,
                                    NSForegroundColorAttributeName : _contentColor
                                    }
                            range:NSMakeRange(0, textAttStr.length)];
        _textView.attributedText = textAttStr;
    }
}

-(void)setContentColor:(UIColor *)contentColor{
    if ([_contentColor isEqual:contentColor]) {
        return;
    }
    _contentColor = contentColor;
    _textView.textColor = _contentColor;
}

-(void)setLinkColor:(UIColor *)linkColor{
    if ([_linkColor isEqual:linkColor]) {
        return;
    }
    _linkColor = linkColor;
    _textView.linkTextAttributes = @{NSForegroundColorAttributeName : _linkColor};
}

- (void)setLinkFont:(UIFont *)linkFont{
    _linkFont = linkFont;
    _textView.linkTextAttributes = @{NSForegroundColorAttributeName : _linkColor,
                                     NSFontAttributeName : _linkFont};
}

@end

//
//  WTKAutoHighLightLabel.m
//  WTKAutoHighlightedLabelDemo
//
//  Created by 王同科 on 2016/11/24.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "WTKAutoHighLightLabel.h"

#define kRegexHighlightViewTypeURL @"url"
#define kRegexHighlightViewTypeAccount @"account"
#define kRegexHighlightViewTypeTopic @"topic"
#define kRegexHighlightViewTypeEmoji @"emoji"

///若要修改判定方法，修改此处
#define URLRegular @"((http|ftp|https|Http|Http)://)(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?"
#define EmojiRegular @"(\\[\\w+\\])"
#define AccountRegular @"@[\u4e00-\u9fa5a-zA-Z0-9_-]{1,30}"
#define TopicRegular @"#[^#]+#"

@implementation WTKAutoHighLightLabel{
    NSMutableDictionary *highDic;
}

- (void)wtk_setText:(NSString *)text
{
    [self wtk_setText:text withClickBlock:nil];
}
- (void)wtk_setText:(NSString *)text withClickBlock:(void (^)(NSString *))clickBlock
{
    [self wtk_setText:text highLightedColor:self.w_highColor withClickBlock:clickBlock];
}
- (void)wtk_setText:(NSString *)text highLightedColor:(UIColor *)highColor withClickBlock:(void (^)(NSString *))clickBlock
{
    [self wtk_setText:text highLightedColor:highColor withNormalColor:self.w_normalColor withClickBlock:clickBlock];
}
- (void)wtk_setText:(NSString *)text highLightedColor:(UIColor *)highColor withNormalColor:(UIColor *)normalColor withClickBlock:(void (^)(NSString *))clickBlock
{
    [self wtk_setText:text highLightedColor:highColor withNormalColor:normalColor withSelectedColor:self.w_selectedColor withClickBlock:clickBlock];
}
- (void)wtk_setText:(NSString *)text highLightedColor:(UIColor *)highColor withNormalColor:(UIColor *)normalColor withSelectedColor:(UIColor *)selectedColor withClickBlock:(void (^)(NSString *))clickBlock
{
    self.w_highColor = highColor;
    self.w_normalColor = normalColor;
    self.w_selectedColor = selectedColor;
    if (clickBlock)
    {
        self.clickBlock = clickBlock;
        self.userInteractionEnabled = YES;
        highDic = @{}.mutableCopy;
    }
    if (highDic)
    {
        [highDic removeAllObjects];
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : self.font,NSForegroundColorAttributeName : normalColor}];
    self.attributedText = [self highlightText:string];
}

- (NSMutableAttributedString *)highlightText:(NSMutableAttributedString *)coloredString{
    NSString* string = coloredString.string;
    NSRange range = NSMakeRange(0,[string length]);
    NSDictionary* definition = @{kRegexHighlightViewTypeAccount: AccountRegular,
                                 kRegexHighlightViewTypeURL:URLRegular,
                                 kRegexHighlightViewTypeTopic:TopicRegular,
                                 kRegexHighlightViewTypeEmoji:EmojiRegular,
                                 };
    for(NSString* key in definition) {
        NSString* expression = [definition objectForKey:key];
        NSArray* matches = [[NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionDotMatchesLineSeparators error:nil] matchesInString:string options:0 range:range];
        for(NSTextCheckingResult* match in matches) {
            [coloredString addAttribute:NSForegroundColorAttributeName value:self.w_highColor range:match.range];
        }
    }
    return coloredString;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - lazyLoad
- (UIColor *)w_highColor
{
    if (!_w_highColor)
    {
        _w_highColor = [UIColor blueColor];
    }
    return _w_highColor;
}
- (UIColor *)w_normalColor
{
    if (!_w_normalColor)
    {
        _w_normalColor = self.textColor;
    }
    return _w_normalColor;
}
- (UIColor *)w_selectedColor
{
    if (!_w_selectedColor)
    {
        _w_selectedColor = self.w_highColor;
    }
    return _w_selectedColor;
}


@end

//
//  LayerLabel.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/23.
//  Copyright © 2017年 teaason. All rights reserved.

//我们已经证实了CATextLayer比UILabel有着更好的性能表现，同时还有额外的布局选项并且在iOS 5上支持富文本。但是与一般的标签比较而言会更加繁琐一些。如果我们真的在需求一个UILabel的可用替代品，最好是能够在Interface Builder上创建我们的标签，而且尽可能地像一般的视图一样正常工作。+
//我们应该继承UILabel，然后添加一个子图层CATextLayer并重写显示文本的方法。但是仍然会有由UILabel的-drawRect:方法创建的空寄宿图。而且由于CALayer不支持自动缩放和自动布局，子视图并不是主动跟踪视图边界的大小，所以每次视图大小被更改，我们不得不手动更新子图层的边界。
//我们真正想要的是一个用CATextLayer作为宿主图层的UILabel子类，这样就可以随着视图自动调整大小而且也没有冗余的寄宿图啦。
//就像我们在第一章『图层树』讨论的一样，每一个UIView都是寄宿在一个CALayer的示例上。这个图层是由视图自动创建和管理的，那我们可以用别的图层类型替代它么？一旦被创建，我们就无法代替这个图层了。但是如果我们继承了UIView，那我们就可以重写+layerClass方法使得在创建的时候能返回一个不同的图层子类。UIView会在初始化的时候调用+layerClass方法，然后用它的返回类型来创建宿主图层。
//清单6.4 演示了一个UILabel子类LayerLabel用CATextLayer绘制它的问题，而不是调用一般的UILabel使用的较慢的-drawRect：方法。LayerLabel示例既可以用代码实现，也可以在Interface Builder实现，只要把普通的标签拖入视图之中，然后设置它的类是LayerLabel就可以了。
//如果你运行代码，你会发现文本并没有像素化，而我们也没有设置contentsScale属性。把CATextLayer作为宿主图层的另一好处就是视图自动设置了contentsScale属性。
//在这个简单的例子中，我们只是实现了UILabel的一部分风格和布局属性，不过稍微再改进一下我们就可以创建一个支持UILabel所有功能甚至更多功能的LayerLabel类（你可以在一些线上的开源项目中找到）。+



#import "LayerLabel.h"
#import <CoreText/CoreText.h>

@implementation LayerLabel

+ (Class)layerClass
{
    //this makes our label create a CATextLayer //instead of a regular CALayer for its backing layer
    return [CATextLayer class];
}

- (CATextLayer *)textLayer
{
    return (CATextLayer *)self.layer;
}

- (void)setUp
{
    //set defaults from UILabel settings
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    //we should really derive these from the UILabel settings too
    //but that's complicated, so for now we'll just hard-code them
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (id)initWithFrame:(CGRect)frame
{
    //called when creating label programmatically
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    //called when creating label using Interface Builder
    [self setUp];
}

- (void)setText:(NSString *)text
{
    super.text = text;
    //set layer text
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    //set layer text color
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
    super.font = font;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

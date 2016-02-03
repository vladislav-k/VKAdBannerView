//
//  VKAdBannerView.m d
//
//  Created by Vladislav Kovalyov on 2/3/16.
//  Copyright © 2016 WOOPSS.com (http://woopss.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "VKAdBannerView.h"
#import "UIImage+VKAdBannerView.h"

// It'll be better if you will use MarqueeLabel class.
// You can download it from this repo: https://github.com/cbpowell/MarqueeLabel
// If you want to use MarqueeLabel, then uncomment next line
//#import "MarqueeLabel.h"

@interface VKAdBannerView()
{
    NSInteger currentContentIndex;
}

@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *labelAppName;
//@property (nonatomic, strong) MarqueeLabel *labelAppDescription; // If you don't want to use MarqueeLabel, then uncomment this line and comment out next line
@property (nonatomic, strong) UILabel *labelAppDescription;
@property (nonatomic, strong) UILabel *labelAppPrice;
@property (nonatomic, strong) UIButton *buttonRef;

@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) VKAdBannerContent *currentContent;

@end

@implementation VKAdBannerView

const CGFloat static kValuePadding = 8.;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        [self addSubview:[self imageViewIconWithFrame:frame]];
        [self addSubview:[self labelAppNameWithFrame:frame]];
        [self addSubview:[self labelAppDescriptionWithFrame:frame]];
        [self addSubview:[self labelAppPriceWithFrame:frame]];
        [self addSubview:[self buttonRefWithFrame:frame]];
        
        self.rotationType = VKAdBannerViewRotationTypeOneByOne;
        self.rotationTime = 5.;
        
        currentContentIndex = 0;
    }
    
    return self;
}

#pragma mark - Content

-(void)setAdContent:(NSArray <VKAdBannerContent *> *)content
{
    _content = content;
}

#pragma mark - Rotation

-(void)startRotation
{
    [self applyContent];
}

-(void)stopRotation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)applyContent
{
    if (!_content.count)
        return;
    
    _currentContent = _content[currentContentIndex];
    
    self.backgroundColor = _currentContent.backgroundColor;
    
    self.labelAppName.text      = _currentContent.title;
    self.labelAppName.textColor = _currentContent.titleColor;
    self.labelAppName.font      = _currentContent.titleFont;

    self.labelAppDescription.text       = _currentContent.descriptionText;
    self.labelAppDescription.textColor  = _currentContent.descriptionColor;
    self.labelAppDescription.font       = _currentContent.descriptionFont;
    
    self.labelAppPrice.text      = _currentContent.price;
    self.labelAppPrice.textColor = _currentContent.priceColor;
    self.labelAppPrice.font      = _currentContent.priceFont;
    
    self.imageViewIcon.image = _currentContent.icon;
    self.imageViewIcon.layer.borderColor = _currentContent.iconBorderColor.CGColor;
    
    // Call delegate method if it's initialized
    if (_delegate && [_delegate respondsToSelector:@selector(VKAdBannerView:didRotateContent:)])
        [_delegate VKAdBannerView:self didRotateContent:_currentContent];
    
    // Start next rotation after specified time
    [self updateRotationIndex];
    [self performSelector:@selector(applyContent) withObject:nil afterDelay:_rotationTime];
}

#pragma mark - Actions

-(void)onButtonRef
{
    if (!_currentContent)
        return;
    
    // Call delegate method if it's initialized
    if (_delegate && [_delegate respondsToSelector:@selector(VKAdBannerView:willOpenURL:)])
        [_delegate VKAdBannerView:self willOpenURL:_currentContent.url];
    
    [[UIApplication sharedApplication] openURL:_currentContent.url];
}

#pragma mark - Private 

-(void)updateRotationIndex
{
    if (_content.count == 1)
    {
        currentContentIndex = 0;
        return;
    }
    
    if (_rotationType == VKAdBannerViewRotationTypeOneByOne)
    {
        if(++currentContentIndex >= _content.count)
            currentContentIndex = 0;
    }
    else
    {
        int newIndex = 0;
        
        // Keep from showing previous content again
        if (_content.count > 1)
        {
            while (currentContentIndex == newIndex)
                newIndex = arc4random() % [_content count];
        }
        
        currentContentIndex = newIndex;
        
    }
}

#pragma mark Subviews
-(UIImageView *)imageViewIconWithFrame:(CGRect)frame
{
    if (!self.imageViewIcon)
    {
        // Needed frame:
        // X = padding
        // Y = 5% of total frame height
        // W & H = 90% of total frame height
        self.imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kValuePadding, CGRectGetHeight(frame) * 0.05, CGRectGetHeight(frame) * 0.9, CGRectGetHeight(frame) * 0.9)];
        
        // Apply App Store like icon view
        self.imageViewIcon.layer.cornerRadius  = CGRectGetHeight(self.imageViewIcon.frame) * .22;
        self.imageViewIcon.layer.masksToBounds = YES;
        self.imageViewIcon.layer.borderWidth   = 1;
    }
    
    return self.imageViewIcon;
}

-(UILabel *)labelAppNameWithFrame:(CGRect)frame
{
    if (!self.labelAppName)
    {
        // Needed frame:
        // X = icon MAX Y + padding
        CGFloat x = CGRectGetMaxX(self.imageViewIcon.frame) + kValuePadding;
        // Y = padding / 1.5
        // W = frame WIDTH - label X - padding (right)
        // H = frame HEIGHT / 2 - padding
        self.labelAppName = [[UILabel alloc] initWithFrame:CGRectMake( x, kValuePadding, CGRectGetWidth(frame) - x - kValuePadding, CGRectGetHeight(frame) / 2 - kValuePadding)];
        self.labelAppName.adjustsFontSizeToFitWidth = YES;
    }
    
    return self.labelAppName;
}

-(UILabel *)labelAppDescriptionWithFrame:(CGRect)frame
{
    if (!self.labelAppDescription)
    {
        // Needed frame:
        // X = icon MAX Y + padding
        CGFloat x = CGRectGetMaxX(self.imageViewIcon.frame) + kValuePadding;
        // Y = labelAppName MAX Y
        // W = frame WIDTH - label X - padding (right)
        // H = frame HEIGHT / 2 - padding
        
        CGRect labelFrame = CGRectMake(x, CGRectGetMaxY(self.labelAppName.frame), CGRectGetWidth(frame) - x - kValuePadding, CGRectGetHeight(frame) / 2 - kValuePadding);
        
        // Comment out next line if you're using MarqueeLabel class
        self.labelAppDescription = [[UILabel alloc] initWithFrame:labelFrame];
        
        /* Uncomment this chunk of code if you're using MarqueeLabel class
         
        self.labelAppDescription = [[MarqueeLabel alloc] initWithFrame:labelFrame];
        
        self.labelAppDescription.marqueeType    = MLContinuous;
        self.labelAppDescription.scrollDuration = 10.0;
        self.labelAppDescription.animationCurve = UIViewAnimationOptionCurveLinear;
        self.labelAppDescription.fadeLength     = 1.0f;
        self.labelAppDescription.leadingBuffer  = 0.0f;
        self.labelAppDescription.trailingBuffer = 16.0f;
         
        */
    }
    
    return self.labelAppDescription;
}

-(UILabel *)labelAppPriceWithFrame:(CGRect)frame
{
    if (!self.labelAppPrice)
    {
        // Needed frame:
        // X = frame WIDTH - label WIDTH - padding
        CGFloat x = frame.size.width - 40 - kValuePadding;
        // Y = padding / 2
        // W = 40.
        // H = 21. (default)
        
        self.labelAppPrice = [[UILabel alloc] initWithFrame:CGRectMake(x, kValuePadding / 2, 40., 21.)];
        self.labelAppPrice.font      = [UIFont systemFontOfSize:15.];
        self.labelAppPrice.textColor = [UIColor lightTextColor];
        self.labelAppPrice.adjustsFontSizeToFitWidth = YES;
        self.labelAppPrice.textAlignment = NSTextAlignmentRight;
    }
    
    return self.labelAppPrice;
}

-(UIButton *)buttonRefWithFrame:(CGRect)frame
{
    if (!self.buttonRef)
    {
        // Button frame = total frame
        self.buttonRef = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.buttonRef setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.15]] forState:UIControlStateHighlighted];
        [self.buttonRef addTarget:self action:@selector(onButtonRef) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self.buttonRef;
}

#pragma mark - Frames

+(CGRect)defaultiPhoneFrame
{
    return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
}

+(CGRect)defaultiPadFrame
{
    return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 98);
}

@end

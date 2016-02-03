//
//  VKAdBannerContent.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VKAdBannerContent : NSObject

/*!
 @property icon
 @abstract App icon for ad
 */
@property (nonatomic, strong) UIImage *icon;

/*!
 @property iconBorderColor
 @abstract Icon border color for ad
 */
@property (nonatomic, strong) UIColor *iconBorderColor;

/*!
 @property url
 @abstract App URL
 */
@property (nonatomic, strong) NSURL *url;

/*!
 @property title
 @abstract Title text for ad
 */
@property (nonatomic, strong) NSString *title;

/*!
 @property titleColor
 @abstract Title text color for ad
 */
@property (nonatomic, strong) UIColor *titleColor;

/*!
 @property titleFont
 @abstract Title font for ad
 @note Default font size for iPad is 21. and for iPhone/iPod is 17.
 */
@property (nonatomic, strong) UIFont *titleFont;

/*!
 @property descriptionText
 @abstract Description text for ad
 */
@property (nonatomic, strong) NSString *descriptionText;

/*!
 @property descriptionColor
 @abstract Description text color for ad
 */
@property (nonatomic, strong) UIColor *descriptionColor;

/*!
 @property descriptionFont
 @abstract Description font for ad
 @note Default font size for iPad is 17. and for iPhone/iPod is 14.
 */
@property (nonatomic, strong) UIFont *descriptionFont;

/*!
 @property price
 @abstract Price text for ad
 */
@property (nonatomic, strong) NSString *price;

/*!
 @property priceColor
 @abstract Price text color for ad
 */
@property (nonatomic, strong) UIColor *priceColor;

/*!
 @property priceFont
 @abstract Price font for ad
 @note Default font size for iPad is 18. and for iPhone/iPod is 15.
 */
@property (nonatomic, strong) UIFont *priceFont;

/*!
 @property backgroundColor
 @abstract <code>VKAdBannerView</code> background color
 @note If you want to set background image use (UIColor) <code>colorWithPatternImage:</code> method
 */
@property (nonatomic, strong) UIColor *backgroundColor;

@end

//
//  VKAdBannerView.h
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
#import "VKAdBannerContent.h"

/*!
 @enum AVPlayerStatus
 @abstract 
    An enum that defines the types of <code>VKAdBannerView</code> rotation

 @constant VKAdBannerViewRotationTypeOneByOne
    Updates content one-by-one
 @constant VKAdBannerViewRotationTypeRandom
    Updates content in random order
*/
typedef NS_ENUM(NSInteger, VKAdBannerViewRotationType)
{
    VKAdBannerViewRotationTypeOneByOne,
    VKAdBannerViewRotationTypeRandom
};

@class VKAdBannerView;
@protocol VKAdBannerViewDelegate <NSObject>
@optional

/*!
 @method VKAdBannerView:didRotateContent:
 @abstract Called when <code>VKAdBannerView</code> changed content
 
 @param adBannerView
    <code>VKAdBannerView</code> called this method
 @param content
    Current content after rotation finish
 */
-(void)VKAdBannerView:(VKAdBannerView *)adBannerView didRotateContent:(VKAdBannerContent *)content;

/*!
 @method VKAdBannerView:willOpenURL:
 @abstract Called when user tap on <code>VKAdBannerView</code>
 
 @param adBannerView
    <code>VKAdBannerView</code> called this method
 @param url
    Url which will be opened
 */
-(void)VKAdBannerView:(VKAdBannerView *)adBannerView willOpenURL:(NSURL *)url;

@end

@interface VKAdBannerView : UIView

/* Declined methods list */
-(instancetype)init __attribute__((unavailable("use initWithFrame:")));
+(instancetype)new  __attribute__((unavailable("use initWithFrame:")));

/*!
 @method setAdContent:
 @abstract Set content items for <code>VKAdBannerView</code>
 
 Example usage:
 @code
    VKAdBannerView *adBannerView = ...
    KAdBannerViewContent *adContent1 = ..., *adContent2 = ...;
    [adBannerView setAdContent:@[adContent1, adContent2]];
 @endcode
 
 @param content
    List of <code>VKAdBannerContent</code> items which must be rotated
 */
-(void)setAdContent:(NSArray <VKAdBannerContent *> *)content;

/*!
 @property delegate
 @abstract Set <code>VKAdBannerViewDelegate</code> for <code>VKAdBannerView</code>
 */
@property (nonatomic, strong) id <VKAdBannerViewDelegate> delegate;

/*!
 @property rotationType
 @abstract Set rotation type enum for <code>VKAdBannerView</code>
 @note Default value is VKAdBannerViewRotationTypeOneByOne
 @see VKAdBannerViewRotationType
 */
@property (nonatomic, assign) VKAdBannerViewRotationType rotationType;

/*!
 @property rotationTime
 @abstract Set rotation time in seconds for <code>VKAdBannerView</code>
 @note Default value is 15 seconds
 */
@property (nonatomic, assign) float rotationTime;

/*!
 @method startRotation:
 @abstract Start rotation of content
 */
-(void)startRotation;

/*!
 @method stopRotation:
 @abstract Stop rotation of content
 */
-(void)stopRotation;

/*!
 @method defaultiPhoneFrame:
 @return default iAd frame for iPhone
 */
+(CGRect)defaultiPhoneFrame;

/*!
 @method defaultiPadFrame:
 @return default iAd frame for iPad
 */
+(CGRect)defaultiPadFrame;

@end

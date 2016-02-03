//
//  ViewController.m
//  Example
//
//  Created by Vladislav Kovalyov on 2/3/16.
//  Copyright © 2016 Vladislav Kovalyov. All rights reserved.
//

#import "ViewController.h"

#import <iAd/iAd.h>
#import "VKAdBannerView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController () <ADBannerViewDelegate, VKAdBannerViewDelegate>

@property (strong, nonatomic) ADBannerView *adBannerView;
@property (strong, nonatomic) VKAdBannerView *myBannerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAdBannerView];
    [self setupMyBannerView];
    
    [_myBannerView startRotation];
    
    [self.view bringSubviewToFront:_adBannerView];
}

#pragma mark - Banners init

-(void)setupAdBannerView
{
    _adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    _adBannerView.frame = CGRectOffset(_adBannerView.frame, 0, [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(_adBannerView.frame));
    _adBannerView.backgroundColor = [UIColor clearColor];
    [_adBannerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_adBannerView setAlpha:0];
    _adBannerView.delegate = self;
    
    [self.view addSubview:_adBannerView];
}

-(void)setupMyBannerView
{
    // Init VKAdBannerView with Apple's iAd frame
    // You can call [VKAdBannerView defaultiPhoneFrame:] or [VKAdBannerView defaultiPadFrame:] if you don't use iAd
    _myBannerView = [[VKAdBannerView alloc] initWithFrame:_adBannerView.frame];
    _myBannerView.delegate = self;
    
    // First Ad Content
    VKAdBannerContent *adContentCities = [[VKAdBannerContent alloc] init];
    
    adContentCities.icon = [UIImage imageNamed:@"ad_icon_cities"];
    adContentCities.iconBorderColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    adContentCities.title = @"City Names: Word Chain Game";
    adContentCities.titleColor = UIColorFromRGB(0xda4936);
    
    adContentCities.descriptionText  = [NSString stringWithFormat:@"Classic game in City Names in your %@", [UIDevice currentDevice].model];
    adContentCities.descriptionColor = UIColorFromRGB(0x3b3b3b);
    
    adContentCities.price = @"$0.99";
    adContentCities.priceColor = UIColorFromRGB(0x3b3b3b);
    
    adContentCities.url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id795845586"];
    adContentCities.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ad_bg_cities"]];
    
    
    // Second Ad Content
    VKAdBannerContent *adContentMyHeartbeat = [[VKAdBannerContent alloc] init];
    
    adContentMyHeartbeat.icon = [UIImage imageNamed:@"ad_icon_myhb"];
    
    adContentMyHeartbeat.title = @"My Heartbeat";
    adContentMyHeartbeat.titleColor = UIColorFromRGB(0xff2e47);
    
    adContentMyHeartbeat.descriptionText  = @"Universal fitness app for your Bluetooth HRM";
    adContentMyHeartbeat.descriptionColor = UIColorFromRGB(0x6f6f6f);
    
    adContentMyHeartbeat.price = @"$1.99";
    adContentMyHeartbeat.priceColor = UIColorFromRGB(0x3b3b3b);
    
    adContentMyHeartbeat.url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1048456519"];
    adContentMyHeartbeat.backgroundColor  = [UIColor whiteColor];
    
    
    // Third Ad Content
    VKAdBannerContent *adContentMusic = [[VKAdBannerContent alloc] init];
    
    adContentMusic.title = @"WOOPSS Music";
    adContentMusic.titleColor = UIColorFromRGB(0xff3366);
    
    adContentMusic.descriptionText  = @"Listen and download music from VK, SoundCloud & Dropbox!";
    adContentMusic.descriptionColor = UIColorFromRGB(0x00b1d1);
    
    adContentMusic.price = @"$1.99";
    adContentMusic.priceColor = [UIColor whiteColor];
    
    adContentMusic.url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1072707284"];
    adContentMusic.backgroundColor  = UIColorFromRGB(0x1E2023);
    
    adContentMusic.icon = [UIImage imageNamed:@"ad_icon_music"];
    adContentMusic.iconBorderColor = [UIColor colorWithWhite:0.15 alpha:1];
    
    
    // Add created content to your
    [_myBannerView setAdContent:@[adContentCities, adContentMyHeartbeat, adContentMusic]];
    [_myBannerView setRotationTime:12.];
    [_myBannerView setRotationType:VKAdBannerViewRotationTypeRandom];
    
    [self.view addSubview:_myBannerView];
}

#pragma mark - ADBannerViewDelegate

-(void)bannerViewWillLoadAd:(ADBannerView *)banner {}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self setAdBannerViewVisible:YES];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self setAdBannerViewVisible:NO];
}

-(void)setAdBannerViewVisible:(BOOL)visible
{
    if (visible)
        [_myBannerView stopRotation];
    else
        [_myBannerView startRotation];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.adBannerView.alpha = visible ? 1. : .0;
        self.myBannerView.alpha = visible ? .0 : 1.;
    }];
}

#pragma mark - VKAdBannerViewDelegate

-(void)VKAdBannerView:(VKAdBannerView *)adBannerView didRotateContent:(VKAdBannerContent *)content
{
    NSLog(@"Did show next content: %@", content.title);
}

-(void)VKAdBannerView:(VKAdBannerView *)adBannerView willOpenURL:(NSURL *)url
{
    NSLog(@"Will open URL: %@", url);
}

@end

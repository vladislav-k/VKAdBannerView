# VKAdBannerView
## Description
*VKAdBannerView* allows you to make offline Ad with your content. It's very convient when iAd or AdMob are not supported in some regions or network connection on user's device is corrupted. Once it happaned *VKAdBannerView* will help you to show Ad of your apps or services.

## Installation
For now you can install **VKAdBannerView** manually only. Please see instructions below.

### Manual Installation
The class files required for **VKAdBannerView** is located in the VKAdBannerView folder in the root of this repository. 
List of class files below:
```
VKAdBannerView.h
VKAdBannerView.m
VKAdBannerViewContent.h
VKAdBannerViewContent.m
UIImage+VKAdBannerView.h
UIImage+VKAdBannerView.m
```

## Example project
Example project shows how you can combine Apple's iAd and **VKAdBannerView** together.
To test it it, clone the repo and run it from the Example directory. 

## Usage
### VKAdBannerViewContent
Work of **VKAdBannerView** based on it's content. So, first you need to create some content for it with help of **VKAdBannerViewContent** class. Here is example of 
```
VKAdBannerContent *adContent = [[VKAdBannerContent alloc] init];
    
adContent.icon = [UIImage imageNamed:@"my_app_icon"];
adContent.iconBorderColor = [UIColor colorWithWhite:0.5 alpha:1];
    
adContent.title = @"My app name";
adContent.titleColor = UIColorFromRGB(0xda4936);
    
adContent.descriptionText  = @"Some short description of my app";
adContent.descriptionColor = UIColorFromRGB(0x3b3b3b);
    
adContent.price = @"$4.99";
adContent.priceColor = UIColorFromRGB(0x3b3b3b);
    
adContent.url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id_app_link"];
adContent.backgroundColor = [UIColor whiteColor];
```

This class is very flexible for customization. You can set icon, texts, text colors, text fonts, banner background color etc. See more info in `VKAdBannerViewContent.h` file.

### VKAdBannerView
Once all needed content is created you can create **VKAdBannerView** itself:
```
_myBannerView = [[VKAdBannerView alloc] initWithFrame:frame];
_myBannerView.delegate = self;

[_myBannerView setAdContent:@[adContent, adContent2, ...]];
[_myBannerView setRotationTime:15.];
[_myBannerView setRotationType:VKAdBannerViewRotationTypeOneByOne];
    
[self.view addSubview:_myBannerView];

```
### Advice
It's better to use **VKAdBannerView** together with **MarqueeLabel** class - https://github.com/cbpowell/MarqueeLabel. 
See `VKAdBannerViewContent.m` file how to use it.

## Author
Vladislav Kovalyov, http://woopss.com/

## License
VKAdBannerView is available under the Apache License. See the LICENSE file for more info.
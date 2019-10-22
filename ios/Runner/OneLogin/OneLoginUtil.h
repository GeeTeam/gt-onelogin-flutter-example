//
//  OneLoginUtil.h
//  Runner
//
//  Created by noctis on 2019/10/21.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneLoginUtil : NSObject

- (void)normalLogin:(UIViewController *)controller flutterResult:(FlutterResult)flutterResult;

- (void)popupLogin:(UIViewController *)controller flutterResult:(FlutterResult)flutterResult;

- (void)floatWindowLogin:(UIViewController *)controller flutterResult:(FlutterResult)flutterResult;

- (void)landscapeLogin:(UIViewController *)controller flutterResult:(FlutterResult)flutterResult;

@end

NS_ASSUME_NONNULL_END

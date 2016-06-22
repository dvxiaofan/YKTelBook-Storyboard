//
//  AddViewController.h
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议
@class AddViewController,YKContactModel;
@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addContact:(AddViewController *)addVC didAddContact:(YKContactModel *)contact;

@end

@interface AddViewController : UIViewController
// assign 类型，为了防止循环引用
@property (assign, nonatomic) id<AddViewControllerDelegate> delegate;
@end

//
//  EditViewController.h
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//
#import <UIKit/UIKit.h>

// 声明模型  用@class 是为了防止相互导入
@class YKContactModel,EditViewController;
@protocol EditViewControllerDelegate <NSObject>
// 声明代理行为
@optional
- (void)editViewController:(EditViewController *)editVC didSaveContact:(YKContactModel *)model;

@end

@interface EditViewController : UIViewController
// 模型属性
@property (strong, nonatomic) YKContactModel *contactModel;
//声明代理属性
@property (assign, nonatomic) id<EditViewControllerDelegate>delegate;
@end

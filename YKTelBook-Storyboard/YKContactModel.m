//
//  YKContactModel.m
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "YKContactModel.h"

@implementation YKContactModel
/**
 *  将某个对象写入文件时会调用
 *
 *  在这个方法中说清楚哪些属性需要存储
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}
/**
 *  解析对象时会调用这个方法
 *
 *  需要解析哪些属性，跟上面的相对应
 */
- (id)initWithCoder:(NSCoder *)decoder {
    // 先判断是否调用父类初始化
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end

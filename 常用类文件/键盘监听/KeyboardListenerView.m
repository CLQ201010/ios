//
//  KeyboardListenerView.m
//  ParkingProject
//
//  Created by Eric on 16/10/12.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "KeyboardListenerView.h"

@implementation KeyboardListenerView


//记录键盘是否移动过;
static bool isMove;
//记录键盘上移的距离
static CGFloat subHeight;
- (void)drawRect:(CGRect)rect {
    // 开始监听
    [self keyBoardNosnotification];

}
- (void)keyBoardNosnotification {
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardShow:(NSNotification *)notification
{
    //键盘的frame
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //键盘的y
    CGFloat y = rect.origin.y;
    [UIView animateWithDuration:0.2 animations:^{
        //view的最大y值
        CGFloat maxY = CGRectGetMaxY(self.frame);
        //比较view和键盘的y判断是否需要移动
        isMove = maxY > y ? YES:NO;
            if (isMove) {
                //移动的距离
                subHeight = maxY-y;
                //移动,注意不能直接改frame;
                self.transform = CGAffineTransformMakeTranslation(0, self.transform.ty-subHeight);
                
            }
    }];
    
}

- (void)keyboardHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        //如果移动了,移动回来.
        if (isMove) {
            self.transform =CGAffineTransformMakeTranslation(0,self.transform.ty+subHeight);

        }
    }];
}
@end

//
//  AppDelegate.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "AgesViewController.h"
#import "checkListCell.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    
}

@property (strong, nonatomic) UIWindow *window;


//グローバル変数として以下を宣言
@property (nonatomic) LeftViewController *leftMenuViewContoroller;
@property (nonatomic) ViewController *tmpViewContoroller;
@property (nonatomic) DetailViewController *detailViewContoroller;
@property (nonatomic) AgesViewController *agesViewController;
@property (nonatomic) checkListCell *checkListCell;
//- (void)switchTabBarController:(NSInteger)selectedViewIndex;





@end

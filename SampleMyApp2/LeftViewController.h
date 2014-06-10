//
//  LeftViewController.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *LeftTable;
@property (nonatomic) NSMutableArray *CategoryArray;
//@property (nonatomic) NSString *CategoryFilepath;
//@property (nonatomic) NSString *WannadoFilepath;


@end

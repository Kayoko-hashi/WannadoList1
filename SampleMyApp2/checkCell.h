//
//  checkCell.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/29.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkCell : UITableViewCell
@property (nonatomic) int indicateRow;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkBtnTap:(id)sender event:(id)event;


@end

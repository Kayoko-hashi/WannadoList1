//
//  RemovableCell.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/30.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemovableCell : UITableViewCell
- (IBAction)deleteTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *removableLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic) NSInteger indicateRow;
@end

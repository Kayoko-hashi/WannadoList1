//
//  AddNewCategoryCell.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/27.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewCategoryCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *AddNCTextField;
- (IBAction)TFReturn:(id)sender;
@property (nonatomic) NSInteger row;


@end

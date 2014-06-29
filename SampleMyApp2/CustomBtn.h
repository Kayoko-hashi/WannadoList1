//
//  CustomBtn.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/23.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBtn : UIButton{

    NSUInteger section;
    NSUInteger row;

}

@property (nonatomic, readwrite) NSUInteger section;
@property (nonatomic, readwrite) NSUInteger row;


@end

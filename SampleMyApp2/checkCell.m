//
//  checkCell.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/29.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "checkCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "ViewController.h"

@implementation checkCell{

    NSString *wannadoFilepath;
    AppDelegate *app;

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SelectWannadoPlist{
    
    //WannadoList用のパスを作る準備。
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    
    //指定されたディレクトリ配下から指定のplist
    wannadoFilepath = [documentsDirectory stringByAppendingPathComponent:@"wannadoList2.plist"];
    
}

-(AppDelegate *)appdelegate{
    
    //アップデリゲートをインスタンス化
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    return app;
    
    
}


-(void)Check{
    
    [self SelectWannadoPlist];
    [self appdelegate];
    
    
    NSMutableArray *getArray = [[NSMutableArray alloc]init];
    getArray = [NSMutableArray arrayWithContentsOfFile:wannadoFilepath];
    NSLog(@"%@",getArray);
    
    NSInteger count;
    count = 0;
    NSMutableArray *getArrayCopy;
    getArrayCopy = [[NSMutableArray alloc]init];
    
    
    for(NSMutableDictionary* temp in getArray ){
        
        
        if (self.checkBtn.tag == 1) {
            
            [temp setObject:[NSNumber numberWithBool:YES] forKey:@"Complete_flag"];
            [getArrayCopy setObject:temp atIndexedSubscript:count];

            
            
        }else{
            
            [getArrayCopy setObject:temp atIndexedSubscript:count];
            [temp setObject:[NSNumber numberWithBool:NO] forKey:@"Complete_flag"];
            
        }
        
        count++;
        
    }
    
    [getArrayCopy writeToFile:wannadoFilepath atomically:YES];
    [app.leftMenuViewContoroller.LeftTable reloadData];
    [app.detailViewContoroller.DetailTable reloadData];
    [app.tmpViewContoroller.myList reloadData];
    
    
}






- (IBAction)checkBtnTap:(id)sender event:(id)event{
    
    [self appdelegate];
    
    //タッチされたボタンがある行数を習得する。
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint touchPosition = [touch locationInView:app.tmpViewContoroller.myList];
    NSIndexPath *indexPath = [app.tmpViewContoroller.myList indexPathForRowAtPoint: touchPosition];
    NSLog(@"%@",indexPath);
    self.indicatedRow = indexPath.row;
    
    
    
    
}


@end

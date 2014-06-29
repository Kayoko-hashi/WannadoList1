//
//  checkListCell.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/13.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "checkListCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "ViewController.h"


@implementation checkListCell{

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


-(void)replaceToNonCategory{
    
    [self SelectWannadoPlist];
    [self appdelegate];
    
    //カスタムセルのボタンが押された時のセルの中身
    NSString *CategoryShouldDelete;
    CategoryShouldDelete = app.tmpViewContoroller.myArray[self.indicateRow];
    NSLog(@"====%@",app.leftMenuViewContoroller.CategoryArray);
    
    
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

-(AppDelegate *)appdelegate{

    //アップデリゲートをインスタンス化
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    return app;


}


-(void)deleteCellFromTableAndArray{
    
    [self SelectWannadoPlist];
    [self appdelegate];
    
    NSMutableArray *getArray;
    getArray = [NSMutableArray arrayWithContentsOfFile:wannadoFilepath];
    NSLog(@"%@",getArray);
    
   // [app.tmpViewContoroller.myList deleteRowsAtIndexPaths:[NSArray arrayWithObject:[self.indicateRow]]withRowAnimation:UITableViewRowAnimationFade];

    
    [app.tmpViewContoroller.FilteredArray removeObjectAtIndex:self.indicateRow];
    NSLog(@"%ld",(long)self.indicateRow);
    
    
    [app.tmpViewContoroller.FilteredArray writeToFile:wannadoFilepath atomically:YES];
    app.tmpViewContoroller.FilteredArray = [NSMutableArray arrayWithContentsOfFile:wannadoFilepath];
    
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
    self.indicateRow = indexPath.row;
    

    
 //   [self replaceToNonCategory];
    
    
   
}




@end

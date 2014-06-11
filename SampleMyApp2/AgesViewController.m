//
//  AgesViewController.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/03.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "AgesViewController.h"

@interface AgesViewController (){

    NSString *wannadoFilepath;
    NSMutableArray *myArray;
}

@end

@implementation AgesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
}

-(void)viewWillAppear:(BOOL)animated{

    //JSファイルを読み込む
    NSString *jsFilepath = [[NSBundle mainBundle] pathForResource:@"acc" ofType:@"js"];
    
    NSString *script = [NSString stringWithContentsOfFile:jsFilepath encoding:NSUTF8StringEncoding error:NULL];
    
    //JSファイルを読み込む
    NSString *jsFilepath2 = [[NSBundle mainBundle] pathForResource:@"jquery-1.11.1.min" ofType:@"js"];
    
    NSString *script2 = [NSString stringWithContentsOfFile:jsFilepath2 encoding:NSUTF8StringEncoding error:NULL];
    
    
    //JSがwebViewで使えるようにする
    [_webView stringByEvaluatingJavaScriptFromString:script2];
    [_webView stringByEvaluatingJavaScriptFromString:script];
    
    //WebView用のパスを取得し、表示させる
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
    //ストリング型の変数の中にhtmlファイルを保存
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    
    //プロパティリストを読む
    [self SelctPlist];
    myArray = [NSMutableArray arrayWithContentsOfFile:wannadoFilepath];
    
    
    //プロパティリストの中から、Key:limitのvalueを全部取り出して配列にする
    NSArray *LimitArray = [[NSArray alloc]init];
    LimitArray = [myArray valueForKeyPath:@"Limit"];
    
    
    //ここでmutableにしないとエラーになる。
    NSMutableArray *LimitArrayM = [[NSMutableArray alloc]init];
    LimitArrayM = [LimitArray mutableCopy];
    
    
    //limit配列の中から”いつやるの？”と"未定"を削除
    BOOL a = [LimitArrayM containsObject:@"いつやるの？"];
    if (a == YES) {
        
        [LimitArrayM removeObject:@"いつやるの？"];
    }
    
    BOOL b = [LimitArrayM containsObject:@"未定"];
    if (b == YES) {
        
        [LimitArrayM removeObject:@"未定"];
        
    }

    if ( LimitArrayM.count != 0) {
        
    
    
    //文字列が消去された配列をソート
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO];
    NSArray *sortedArray = [LimitArrayM sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableArray *soretedArrayM = [[NSMutableArray alloc]init];
    soretedArrayM = [sortedArray mutableCopy];
    
    //文字列が消去され、ソートされた配列をコピーしておく
    NSMutableArray *LimitArrayM2 = [[NSMutableArray alloc]init];
    LimitArrayM2 = [soretedArrayM mutableCopy];

    
    //ソートされた配列から重複要素を消去
    NSSet *set = [NSSet setWithArray:soretedArrayM];
    NSArray *tmpArray = [set allObjects];
    
    //文字列が消去された配列をソート
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO];
    NSArray *sortedArray2 = [tmpArray sortedArrayUsingDescriptors:@[sortDescriptor2]];

    
    
    
    //重複要素、文字列が削除、かつソートされたlimitの配列 tmpArray
    //mutableArrayに戻す
    NSMutableArray *sortedLimitArray = [[NSMutableArray alloc]init];
    sortedLimitArray = [sortedArray2 mutableCopy];
    
    
    
    
    //上記配列の要素それぞれを元にプロパティリストを参照する
    NSMutableArray *sortedToDoArray = [[NSMutableArray alloc]init];

    for (NSString *age in sortedLimitArray) {
        NSInteger count_age_data = 0;
        
        for (NSMutableDictionary *dic2 in myArray) {
            
            
            NSString *limitString = [dic2 objectForKey:@"Limit"];
            
            if ( [limitString isEqualToString:age] ){
            
                NSString *TODOString = [dic2 objectForKey:@"TODO"];
            
                if (count_age_data > 0) {
                    TODOString = [NSString stringWithFormat:@"<li id = \"elements\">%@</li>",TODOString];
                }
                
                [sortedToDoArray addObject:TODOString];
                count_age_data++;
            
            }
        
     }
}
    
    int count = [sortedToDoArray count];
    int i = 1;
    int result = 0;
    //NSMutableArray *MArray = [[NSMutableArray alloc]init];
    NSString *oneSet;
    NSString *PoneSet;
    
    
    //単数バージョン
    NSString *Divcontainer = @"<div class =\"container\"><div id =\"text\"><dl id=\"acMenu\"><dt>";
    NSString *ToDoTitle1 = [sortedToDoArray objectAtIndex:result];
    NSString *closeToDoTitle = @"</dt><dd></dd></dl></div>";
    NSString *opneAge = @"<div class = \"img\"><dl id =\"age\">";
    NSString *closeAge = @"</dl></div></div>";
    oneSet = @"";
    PoneSet = oneSet;
    //<li>ついてるやつを保存する用のストリング型の変数
    NSString *strForLi = [[NSString alloc]init];
    
    for ( i=0; i < count; i++) {
        
        NSString *PToDoTitle1;
        NSString *PAge;
        PToDoTitle1= [sortedToDoArray objectAtIndex:i];
        PAge= [LimitArrayM2 objectAtIndex:i];
        PoneSet = [[[[[Divcontainer stringByAppendingString:PToDoTitle1]stringByAppendingString:closeToDoTitle]stringByAppendingString:opneAge]stringByAppendingString:PAge]stringByAppendingString:closeAge];
        
        if( i < count-1){
            ToDoTitle1 = [sortedToDoArray objectAtIndex:i+1];
            
            BOOL bl = [ToDoTitle1 hasPrefix:@"<li"];
            if(bl){
                i++;
                while(bl){
                    
                    strForLi = [strForLi stringByAppendingString:ToDoTitle1];
                    i++;
                    if(i==count){
                        break;
                    }
                    ToDoTitle1 = [sortedToDoArray objectAtIndex:i];
                    bl = [ToDoTitle1 hasPrefix:@"<li"];
                }
                i--;
                strForLi = [NSString stringWithFormat:@"<dd>%@</dd>",strForLi];
                PoneSet = [PoneSet stringByReplacingOccurrencesOfString:@"<dd></dd>" withString:strForLi];
                oneSet = [oneSet stringByAppendingString:PoneSet];
                strForLi = @"";
                
            }else{
                
                oneSet = [oneSet stringByAppendingString:PoneSet];
                
            }
        }else{
            
            PoneSet = [[[[[Divcontainer stringByAppendingString:PToDoTitle1]stringByAppendingString:closeToDoTitle]stringByAppendingString:opneAge]stringByAppendingString:PAge]stringByAppendingString:closeAge];
            oneSet = [oneSet stringByAppendingString:PoneSet];
        }
    }

    
 /*
    
    int count = [sortedToDoArray count];
    int i = 1;
    int result = 0;
    //NSMutableArray *MArray = [[NSMutableArray alloc]init];
    NSString *oneSet;
    NSString *PoneSet;
    NSString *PoneSetTmp;
    
    //単数バージョン
    NSString *Divcontainer = @"<div class =\"container\"><div id =\"text\"><dl id=\"acMenu\"><dt>";
    NSString *ToDoTitle1 = [sortedToDoArray objectAtIndex:result];
    NSString *closeToDoTitle = @"</dt><dd></dd></dl></div>";
    NSString *opneAge = @"<div class = \"img\"><dl id =\"age\">";
    NSString *Age = [LimitArrayM2 objectAtIndex:result];
    NSString *closeAge = @"</dl></div></div>";
    
    oneSet = [[[[[Divcontainer stringByAppendingString:ToDoTitle1]stringByAppendingString:closeToDoTitle]stringByAppendingString:opneAge]stringByAppendingString:Age]stringByAppendingString:closeAge];
    
    PoneSet = oneSet;
    //<li>ついてるやつを保存する用のストリング型の変数
    NSString *strForLi = [[NSString alloc]init];
    
    for ( i=1; i < count; i++) {
        
        NSString *PToDoTitle1;
        NSString *PAge;
        PToDoTitle1= [sortedToDoArray objectAtIndex:i];
        PAge= [LimitArrayM2 objectAtIndex:i];

        
        BOOL bl = [PToDoTitle1 hasPrefix:@"<li"];
        
        
        if (bl) {
            
            strForLi = [strForLi stringByAppendingString:PToDoTitle1];
            
            
        }else{
            
            if (![strForLi isEqualToString:@""]) {
                
                strForLi = [NSString stringWithFormat:@"<dd>%@</dd>",strForLi];
                PoneSetTmp = [PoneSet stringByReplacingOccurrencesOfString:@"<dd></dd>" withString:strForLi];
                
                oneSet = [oneSet stringByReplacingOccurrencesOfString:PoneSet withString:PoneSetTmp];
                
                strForLi = @"";

            }else{
            
                PoneSet = [[[[[Divcontainer stringByAppendingString:PToDoTitle1]stringByAppendingString:closeToDoTitle]stringByAppendingString:opneAge]stringByAppendingString:PAge]stringByAppendingString:closeAge];
                
                oneSet = [oneSet stringByAppendingString:PoneSet];
                
            }
            
            
        
            
        }
        
    }
    
    //一番最後にリスト要素がある場合の処理
    if (strForLi != nil) {
        
        strForLi = [NSString stringWithFormat:@"<dd>%@</dd>",strForLi];
        PoneSetTmp = [PoneSet stringByReplacingOccurrencesOfString:@"<dd></dd>" withString:strForLi];
        
        oneSet = [oneSet stringByReplacingOccurrencesOfString:PoneSet withString:PoneSetTmp];
    }
    
    
  
    //複数バージョン
    //Divcontainer,
    NSString *mToDoTitle1;
    NSString *closeMtodoTitle1 = @"</dt><dd>";
    NSString *openmElement1 = @"<li id = \"elements\">";
    NSString *mElement1 = [//かぶった要素のひとつめ];
    //NSString *closemElement1 = @"</li>";
    NSString *closemDiv = @"</dd></dl></div>";
    NSString *openmAge = @"<div class = \"img\"><dl id =\"age\">";
    NSString *mAge; = []
    NSString *closemDivcontainer = @"</dl></div></div>";
     */
    
    
    
    
    
    
    //REPLACEの中身を書き換える
    NSString *htmlNew = [html stringByReplacingOccurrencesOfString:@"<!-- REPLACE -->" withString:oneSet];
    
    
    //NSString *htmlNew = [html stringByReplacingOccurrencesOfString:@"<!-- REPLACE -->" withString:@"<div class =\"container\"><div id =\"text\"><dl id=\"acMenu\"><dt>アコーディオンメニュー1</dt><dd><li id = \"elements\">要素１</li><li id = \"elements\">要素１</li><li id = \"elements\">要素１</li></dd></dl></div><div class = \"img\"><dl id =\"age\">36</dl></div></div>"];
    
    
    //webViewに表示させる
    [_webView loadHTMLString:htmlNew baseURL:[NSURL fileURLWithPath:path]];
    
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ステータスバーの表示/非表示メソッド呼び出し
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7以降
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 7未満
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

// ステータスバーの非表示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
    
    



-(void)SelctPlist{
    
    wannadoFilepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"wannadoList2.plist"];

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

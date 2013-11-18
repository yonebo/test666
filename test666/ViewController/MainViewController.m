//
//  MainViewController.m
//  test666
//
//  Created by MacPro01 on 2013/11/05.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import "MainViewController.h"
#import "EntTableA.h"

@interface MainViewController ()
@end

@implementation MainViewController

@synthesize tfKey;
@synthesize tfTData;
@synthesize tfIData;
@synthesize tfBData;

@synthesize buttonSearch;
@synthesize buttonRegistry;
@synthesize buttonDelete;

- (IBAction)closeSoftwareKeyboard:(id)sender{
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    /// DBを使う準備
    // - DBファイルのパス
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPathStr = [path objectAtIndex:0];
    // -- DBファイルのパスにDBファイル名を追加する
    FMDatabase *db = [FMDatabase databaseWithPath:[dbPathStr stringByAppendingPathComponent:@"test666.sqlite"]];
*/

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 登録ボタン押下処理
- (IBAction)InsertData:(id)sender {
    
    NSLog(@"登録ボタンが押されました。どうするか？");
}

/// 削除ボタン押下処理
- (IBAction)DeleteData:(id)sender {
    
    NSLog(@"削除ボタンを押しましたね。どうなっても知りませんよ。");
}

/// 検索ボタン押下処理
- (IBAction)SelectData:(id)sender {

    // 検索条件
    // --空だったら処理を抜ける
    NSInteger searchKey = [tfKey.text integerValue];
    if (searchKey < 1){
        NSLog(@"[key]を入力してください。");
        return;
    }
    
    /// DBを使う準備
    // - DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoy = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectoy stringByAppendingPathComponent:@"test666.sqlite"];
    // 存在チェック
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    // なかったら
    NSError *error;
    if (!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test666.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
    }
    if (!success){
        NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
        return;
    }
    
    // -- DBファイルのパスにDBファイル名を追加する
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    // "db" を再利用するステートメントに設定
    [db setShouldCacheStatements:YES];
    
    //NSString *sqlSELECT = @"SELECT * FROM tableA WHERE key = ?";
    NSString *sqlSELECT = [NSString stringWithFormat:@"SELECT * FROM tableA WHERE key = ?"];
    
    FMResultSet *rs = [db executeQuery:sqlSELECT, [NSNumber numberWithInteger:searchKey]];
    //FMResultSet *rs = [db executeQuery:sqlSELECT];
    while ([rs next]) {
        EntTableA *entout = [[EntTableA alloc] init];
        entout.key = [rs intForColumn:@"key"];
        entout.textData = [rs stringForColumn:@"textData"];
        entout.intData = [rs intForColumn:@"intData"];
        entout.boolData = [rs boolForColumn:@"boolData"];
        
    }
    
    
    NSLog(@"検索ボタンを押しましたか。お探しのものは見つかりましたか？");
}
@end

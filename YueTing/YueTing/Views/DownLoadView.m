//
//  DownLoadView.m
//  YueTing
//
//  Created by lanouhn on 16/3/21.
//  Copyright (c) 2016年 Orange. All rights reserved.
//

#import "DownLoadView.h"
#import "JokeModel.h"
@interface DownLoadView()
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@property (nonatomic, strong) NSURLConnection *connection;

@end
@implementation DownLoadView

- (void)addObserverForApplicationState {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleQuiteOfApplication:) name:@"quite" object:nil];
}
- (void)handleQuiteOfApplication:(NSNotification *)notify {
    [[NSUserDefaults standardUserDefaults] setValue:@0 forKey:@"Playing_num"];
    [self.connection cancel];
    self.connection = nil;
    [self saveMp3];
    self.joke.totalLength = self.totalLength;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"insert" object:self.joke];
}
- (void)startDownLoadWithData:(NSMutableData *)mutableData {
    [self.downLoadBtn setImage:[UIImage imageNamed:@"downLoading_pause"] forState:UIControlStateNormal];
    NSURL *url = [NSURL URLWithString:self.joke.audio_64_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:[NSString stringWithFormat:@"Bytes=%ld-", mutableData.length] forHTTPHeaderField:@"Range"];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (self.mutableData == nil) {
        self.mutableData = [NSMutableData dataWithCapacity:0];
    }
    if (self.totalLength == 0) {
        self.totalLength = response.expectedContentLength;
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.mutableData appendData:data];
    CGFloat progressValue = self.mutableData.length * 1.0 / self.totalLength;
    self.progressV.progress = progressValue;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self saveMp3];
    if ([self.delegate respondsToSelector:@selector(removeDownLoad:)]) {
        [self.delegate removeDownLoad:self];
    }
}
- (IBAction)downLoadAction:(id)sender {
    NSInteger playing_num = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Playing_num"] integerValue];
    if (self.connection != nil) {
        playing_num--;
        [self.connection cancel];
        self.connection = nil;
        [self.downLoadBtn setImage:[UIImage imageNamed:@"download_icon"] forState:UIControlStateNormal];
    }else {
        if (playing_num < 3) {
            playing_num++;
            [self startDownLoadWithData:self.mutableData];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:@(playing_num) forKey:@"Playing_num"];
}
#pragma mark File Manage 
- (NSString *)getCachesFilePath {
    NSString  *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [filePath stringByAppendingPathComponent:@"mp3"];
}
- (void)saveMp3 {
    NSString *filePath = [self getCachesFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *detailPath = [filePath stringByAppendingPathComponent:self.joke.audio_64_url];
    BOOL result = [self.mutableData writeToFile:detailPath atomically:YES];
    if (result) {
        NSLog(@"数据存储成功");
    }
}
@end

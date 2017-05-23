//
//  BookPresenter.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookPresenter.h"

#define USERDEFAULTS_SET_VALUE_KEY @"books"

@implementation BookPresenter {
    BookService *bookService;
    NSUserDefaults *userDefaults;
}

- (instancetype)init {
    
    self = [super init];
    bookService = [BookService new];
    userDefaults = [NSUserDefaults standardUserDefaults];
    return  self;
}

- (void)attachView:(id<BookViewDelegate>)delegate {
    
    self.delegate = delegate;
}

- (void) detachView {
    
    self.delegate = nil;
}

- (void)getBooks {
    NSLog(@"=====================Test 1");
    [self.delegate bookPresenterStartLoading:self];
    NSURL *url = [NSURL URLWithString:@"http://172.16.129.61:8080/video/mvp_test"];
    NSURLSessionConfiguration * config =[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionTask * task =[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"Download JSON Fail: %@",error);
//            done(error,nil);
            NSLog(@"=====================Test 2-1");
            return ;
        }
        [self.delegate bookPresenterFinishLoading:self];
//        [NSThread sleepForTimeInterval:5];
        NSLog(@"=====================Test 2-2=====================");
        NSMutableArray *books = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
        [userDefaults synchronize];
        [self.delegate bookPresenterSetBooks:self withArray:books];
//             done(nil,nil);
    }];
    [task resume];
    
    //    [bookService getBooksWithCompletion:^(bool isSucces, id result) {
    //
    //        if (isSucces) {
    //
    //            [self.delegate bookPresenterFinishLoading:self];
    //            NSMutableArray *books = [NSMutableArray arrayWithArray:result];
    //
    //            if (books.count == 0) {
    //
    //                [self.delegate bookPresenterSetEmptyBooks:self];
    //            } else {
    //
    //                [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
    //                [userDefaults synchronize];
    //                [self.delegate bookPresenterSetBooks:self withArray:books];
    //            }
    //        }
    //    }];
}

#pragma  mark - BookPresenterDelegate
- (void)bookPresenterChangeDB:(BookPresenter *)present withArray:(NSMutableArray *)books withCompletion:(DoneHandler _Nullable)done{
    [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
    [userDefaults synchronize];
    done(true,nil);
}

@end


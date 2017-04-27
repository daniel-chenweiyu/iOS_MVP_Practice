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
    
    [self.delegate bookPresenterStartLoading:self];
    [bookService getBooksWithCompletion:^(bool isSucces, id result) {
        
        if (isSucces) {
            
            [self.delegate bookPresenterFinishLoading:self];
            NSMutableArray *books = [NSMutableArray arrayWithArray:result];
            
            if (books.count == 0) {
                
                [self.delegate bookPresenterSetEmptyBooks:self];
            } else {

                [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
                [userDefaults synchronize];
                [self.delegate bookPresenterSetBooks:self withArray:books];
            }
        }
    }];
}

#pragma  mark - BookPresenterDelegate
- (void)bookPresenterChangeDB:(BookPresenter *)present withArray:(NSMutableArray *)books withCompletion:(DoneHandler _Nullable)done{
    [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
    [userDefaults synchronize];
    done(true,nil);
}

@end


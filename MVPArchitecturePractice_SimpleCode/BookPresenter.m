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
    
    [self.delegate startLoadingWithPresent:self];
    [bookService getBooksWithCompletion:^(bool isSucces, id result) {
        
        if (isSucces) {
            
            [self.delegate finishLoadingWithPresent:self];
            NSMutableArray *books = [NSMutableArray arrayWithArray:result];
            
            if (books.count == 0) {
                
                [self.delegate setEmptyBooksWithPresent:self];
            } else {

                [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
                [userDefaults synchronize];
                [self.delegate setBooksWithPresent:self withArray:books];
            }
        }
    }];
}

- (void)chagneBookInfo:(NSMutableArray *)books {
    
    [userDefaults setObject:books forKey:USERDEFAULTS_SET_VALUE_KEY];
    [userDefaults synchronize];
}
@end

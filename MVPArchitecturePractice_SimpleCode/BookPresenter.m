//
//  BookPresenter.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookPresenter.h"
#import "BookService.h"

@implementation BookPresenter {
    BookService *bookService;
    NSObject<BookPresenterDelegate> *bookView;
}

- (instancetype)init {
    
    self = [super init];
    bookService = [BookService new];
    return  self;
}

- (void)attachView:(id<BookPresenterDelegate>)delegate {
    
    bookView = delegate;
}

- (void) detachView {
    
    bookView = nil;
}

- (void)getBooks {
    
    [bookView startLoading];
    [bookService getBooksWithCompletion:^(bool isSucces, id result) {
        
        if (isSucces) {
            
            [bookView finishLoading];
            NSArray *books = [NSArray arrayWithArray:result];
            if (books.count == 0) {
                [bookView setEmptyBooks];
            } else {
                
                [bookView setBooksWithArray:books];
            }
        }
    }];
}

@end

//
//  BookPresenter.h
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookService.h"

@class BookPresenter;
@protocol BookViewDelegate <NSObject>

- (void) startLoadingWithPresent:(BookPresenter*_Nullable)present;
- (void) finishLoadingWithPresent:(BookPresenter*_Nullable)present;
- (void) setBooksWithPresent:(BookPresenter*_Nullable)present withArray:(NSMutableArray*_Nullable) books;
- (void) setEmptyBooksWithPresent:(BookPresenter*_Nullable)present;

@end

@interface BookPresenter : NSObject
@property (nonatomic, weak, nullable) id <BookViewDelegate> delegate;

- (void)attachView:(_Nullable id<BookViewDelegate>)delegate;
- (void)getBooks;
- (void)chagneBookInfo:(NSMutableArray*_Nullable)books;
@end


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

@protocol BookPresenterDelegate <NSObject>

- (void) bookPresenterChangeDB:(BookPresenter*_Nullable)present withArray:(NSMutableArray*_Nullable)books withCompletion:(DoneHandler _Nullable )done;

@end

@protocol BookViewDelegate <NSObject>

- (void) bookPresenterStartLoading:(BookPresenter*_Nullable)present;
- (void) bookPresenterFinishLoading:(BookPresenter*_Nullable)present;
- (void) bookPresenterSetBooks:(BookPresenter*_Nullable)present withArray:(NSMutableArray*_Nullable) books;
- (void) bookPresenterSetEmptyBooks:(BookPresenter*_Nullable)present;

@end

@interface BookPresenter : NSObject <BookPresenterDelegate>
@property (nonatomic, weak, nullable) id <BookViewDelegate> delegate;

- (void)attachView:(_Nullable id<BookViewDelegate>)delegate;
- (void) detachView;
- (void)getBooks;

@end



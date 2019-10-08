//
//  ZWWCardController.m
//  DeckObjC
//
//  Created by Zebadiah Watson on 10/7/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

#import "ZWWCardController.h"

@implementation ZWWCardController
//declared a class method that returns to us ONE instance of ZWWCardController
+ (ZWWCardController *)sharedController
{
    //CREATING A SINGLETON IN OBJECTIVE C
    //make sure this controller doesnt exist
    static ZWWCardController * sharedController = nil;
    //use 'dispatchOnce' thread with 'onceToken' and do something once this is complete
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //creating a new instance of the ZWWCardController after it runs the above
        sharedController = [ZWWCardController new];
    });
    return sharedController;
}
//create base URL (basically the 'static let baseURL')
static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new";

- (void)drawNewCard:(NSInteger)numberOfCards completion:(void (^)(NSArray<ZWWCard *> * ))completion
{
    NSURL * url = [NSURL URLWithString:baseURLString];
    NSString * cardCount = [@(numberOfCards) stringValue];
    NSURL* drawURL = [url URLByAppendingPathComponent:@"draw/"];
    
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem * queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    
    urlComponents.queryItems = @[queryItem];
    
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"there was an error in %s: %@, %@,", __PRETTY_FUNCTION__, error, [error localizedDescription]);
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            NSDictionary * TopLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            if (!TopLevelDictionary)
            {
                NSLog(@"error parsing JSON %@", error);
                completion(nil);
                return;
            }
            NSArray * cardArray = TopLevelDictionary[@"cards"];
            NSMutableArray * cardPlaceHolder = [NSMutableArray new];
            
            for (NSDictionary * dictionary in cardArray)
            {
                ZWWCard * card = [[ZWWCard alloc]
                                  initWithDictionary:dictionary];
                [cardPlaceHolder addObject:card];
            }
            completion(cardPlaceHolder);
        }
        
    } ]resume];


}
-(void)fetchImage:(ZWWCard *)card completion:(void (^)(UIImage * ))completion
{
    NSURL * imageURL = [NSURL URLWithString:card.image];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"error: %@, %@", error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
        
    }]resume];
}

@end

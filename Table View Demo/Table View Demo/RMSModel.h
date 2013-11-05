//
//  RMSModel.h
//  
//
//  Created by Tony Ingraldi on 6/25/13.
//
//

#import <Foundation/Foundation.h>

@interface RMSModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)attributes;

+ (NSArray *)truthyStringValues;

- (NSDictionary *)asDictionary;

@end

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SEGAppboyAdditions)

- (NSDictionary *)sega_newOrDifferentEntriesFrom:(NSDictionary *)other;
- (NSDictionary *)sega_serializableDictionary;

@end

@interface NSArray (SEGAppboyAdditions)

- (NSArray *)sega_serializableArray;

@end

NS_ASSUME_NONNULL_END

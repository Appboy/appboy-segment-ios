#import "NSDictionary+SEGAppboyAdditions.h"

@implementation NSDictionary (SEGAppboyAdditions)

- (NSDictionary *)sega_newOrDifferentEntriesFrom:(NSDictionary *)other {

  NSMutableDictionary *output = [other mutableCopy];

  [other enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    id myObject = [self objectForKey:key];
    if ([myObject conformsToProtocol:@protocol(NSObject)] && [myObject isEqual:obj]) {
      [output removeObjectForKey:key];
    }
  }];

  return output;
}

@end


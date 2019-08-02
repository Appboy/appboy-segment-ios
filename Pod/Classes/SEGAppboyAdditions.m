#import "SEGAppboyAdditions.h"

BOOL SEGAppboyIsValidKey(id key) {
  return [key isKindOfClass:NSString.class];
}

BOOL SEGAppboyIsValidObject(id object) {
  if ([object isKindOfClass:NSNumber.class] ||
      [object isKindOfClass:NSString.class] ||
      [object isKindOfClass:NSDate.class] ||
      [object isKindOfClass:NSDictionary.class] ||
      [object isKindOfClass:NSArray.class]) {
    return YES;
  } else {
    return NO;
  }
}

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

- (NSDictionary *)sega_serializableDictionary {
  NSMutableDictionary *output = [self mutableCopy];
  [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
    if (!SEGAppboyIsValidKey(key) || !SEGAppboyIsValidObject(obj)) {
      [output removeObjectForKey:key];
    }
    if ([obj isKindOfClass:NSDictionary.class]) {
      NSDictionary *dictionary = (NSDictionary *)obj;
      dictionary = [dictionary sega_serializableDictionary];
      [output setObject:dictionary forKey:key];
    }
    if ([obj isKindOfClass:NSArray.class]) {
      NSArray *array = (NSArray *)obj;
      array = [array sega_serializableArray];
      [output setObject:array forKey:key];
    }
  }];

  return output;
}

@end


@implementation NSArray (SEGAppboyAdditions)

- (NSArray *)sega_serializableArray {
  NSMutableArray *output = [self mutableCopy];
  NSMutableIndexSet *deletionIndexes = [NSMutableIndexSet new];

  [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (!SEGAppboyIsValidObject(obj)) {
      [deletionIndexes addIndex:idx];
    }
    if ([obj isKindOfClass:NSDictionary.class]) {
      NSDictionary *dictionary = (NSDictionary *)obj;
      dictionary = [dictionary sega_serializableDictionary];
      [output replaceObjectAtIndex:idx withObject:dictionary];
    }
    if ([obj isKindOfClass:NSArray.class]) {
      NSArray *array = (NSArray *)obj;
      array = [array sega_serializableArray];
      [output replaceObjectAtIndex:idx withObject:array];
    }
  }];

  [output removeObjectsAtIndexes:deletionIndexes];

  return output;
}

@end

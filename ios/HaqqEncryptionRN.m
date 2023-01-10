#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(HaqqEncryptionRN, NSObject)

RCT_EXTERN_METHOD(
                encrypt: (NSString *) password
                data: (NSString *) data
                resolve: (RCTPromiseResolveBlock) resolve
                rejecter: (RCTPromiseRejectBlock) reject
)

RCT_EXTERN_METHOD(
                decrypt: (NSString *) password
                data: (NSString *) data
                resolve: (RCTPromiseResolveBlock) resolve
                rejecter: (RCTPromiseRejectBlock) reject
)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end

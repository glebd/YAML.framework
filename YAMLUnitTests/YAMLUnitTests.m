//
//  YAMLUnitTests.m
//  YAMLUnitTests
//
//  Created by Josh Heidebrecht on 8/11/11.
//  Copyright 2011 Soma Creates. All rights reserved.
//

#import "YAMLUnitTests.h"

@implementation YAMLUnitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void) testBadYamlProvidesLineNumber
{
  NSString *brokenYaml = @"a: b\nc # c requires a colon";

  NSData *data = [brokenYaml dataUsingEncoding:NSUTF8StringEncoding];

  NSError *error;
  NSMutableArray *yaml = [YAMLSerialization YAMLWithData: data options: kYAMLReadOptionStringScalars error: &error];
  STAssertNil(yaml, @"yaml parsing should have failed");
  STAssertNotNil(error, @"Parser should have created an error");
  NSLog(@"Error details are: %@", [error description]);
  
  NSDictionary *user = [error userInfo];
  id line = [user valueForKey:@"line"];
  id column = [user valueForKey:@"column"];
  
  STAssertNotNil(line, @"line number should have been provided");
  STAssertNotNil(column, @"column number should have been provided");
  STAssertEquals(2, [line intValue], @"Parser should have logged the offending line number");
  STAssertEquals(0, [column intValue], @"Parser should have logged the offending column");  
}

@end

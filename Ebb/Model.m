//
//  Model.m
//  Ebb
//
//  Created by Daniel Walsh on 5/19/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import "Model.h"


@implementation Model

- (id) init {
    self = [super init];
    if (self) {

        headers = [NSArray arrayWithObjects:
                   @"Personal Information",
                   @"Assets - Savings",
                   @"Assets - SEP",
                   @"Assets - IRA/401k",
                   @"Assets - Taxable Invest",
                   @"Inflation",
                   nil
                   ];
        
        properties = [NSArray arrayWithObjects:
                      
                      //Personal Information
                      [NSArray arrayWithObjects:
                       @"Age",
                       @"Annual Expenses",
                       @"Early Retire Age",
                       @"Full Retire Age",
                       @"Early Retire Income",
                       @"Retire Inc/Soc Sec",
                       nil
                       ],
                      
                      //Assets - Savings
                      [NSArray arrayWithObjects:
                       @"Account Balance",
                       @"Annual Return",
                       @"Annual Contribution",
                       nil
                       ],
                      
                      //Assets - SEP
                      [NSArray arrayWithObjects:
                       @"Account Balance",
                       @"Annual Rtn - Pre",
                       @"Annual Rtn - Early",
                       @"Annual Rtn - Retire",
                       @"Annual Contribution",
                       nil
                       ],
                      
                      //Assets - IRA/401k
                      [NSArray arrayWithObjects:
                       @"Account Balance",
                       @"Annual Return",
                       @"Annual Contribution",
                       nil
                       ],
                      
                      //Assets - Taxable Investments
                      [NSArray arrayWithObjects:
                       @"Account Balance",
                       @"Annual Ret - Pre",
                       @"Annual Ret - Early",
                       @"Annual Ret - Retire",
                       @"Annual Contribution",
                       @"Tax Rate", 
                       nil
                       ],
                      
                      //Inflation
                      [NSArray arrayWithObjects:
                       @"Inflation",
                       nil
                       ],
                      
                      nil
                      ];
        
        parameters = [NSMutableArray arrayWithObjects:
                      
                      //Personal Information
                      [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithFloat:38],
                       [NSNumber numberWithFloat:100000],
                       [NSNumber numberWithFloat:50],
                       [NSNumber numberWithFloat:65],
                       [NSNumber numberWithFloat:0],
                       [NSNumber numberWithFloat:24000],
                       nil
                       ],
                      
                      //Assets - Savings
                      [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithFloat:175000],
                       [NSNumber numberWithFloat:0.0025],
                       [NSNumber numberWithFloat:0],
                       nil
                       ],
                      
                      //Assets - SEP
                      [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithFloat:52000],
                       [NSNumber numberWithFloat:0.12],
                       [NSNumber numberWithFloat:0.10],
                       [NSNumber numberWithFloat:0.08],
                       [NSNumber numberWithFloat:10000],
                       nil
                       ],
                      
                      //Assets - IRA/401k
                      [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithFloat:18000],
                       [NSNumber numberWithFloat:0.06],
                       [NSNumber numberWithFloat:0],
                       nil
                       ],
                      
                      //Assets - Taxable Investments
                      [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithFloat:125000],
                       [NSNumber numberWithFloat:0.50],
                       [NSNumber numberWithFloat:0.15],
                       [NSNumber numberWithFloat:0.10],
                       [NSNumber numberWithFloat:24000],
                       [NSNumber numberWithFloat:0.35], 
                       nil
                       ],
                      
                      //Inflation
                      [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithFloat:0.03],
                       nil
                       ],
                      
                      nil
                      ];
        
        outputs = [NSArray arrayWithObjects:
                   [NSArray arrayWithObjects:
                    @"Required Income",
                    @"Income",
                    @"Savings",
                    @"Retirement A",
                    @"Retirement B",
                    @"Taxable Invest",
                    @"Retired?",
                    @"Taxable Invest DD",
                    @"Retirement A DD",
                    @"Total Assets",
                    @"NW Change",
                    @"NW Change %",
                    nil
                    ],
                   
                   nil
                   ];
        
        results = [NSMutableArray arrayWithObjects:
                   [NSMutableArray arrayWithObjects:
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    @"NO",
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    [NSNumber numberWithFloat:0],
                    nil
                    ],
                   
                   nil
                   ];
                   
    }
    return self;
}

- (NSUInteger) numberOfSections {
    return properties.count;
}

//Return the number of subtrees of the tree to which the indexPath leads.

- (NSUInteger) numberOfRowsInSection: (NSInteger) section
{
    NSArray *paramGroup = [properties objectAtIndex: section];
    return paramGroup.count;
}

- (NSString *) headers: (NSInteger) section {
    return [headers objectAtIndex:section];
}

- (NSArray *) section: (NSIndexPath *) indexPath {
    return [properties objectAtIndex: indexPath.section];
}

- (NSArray *) getValues: (NSIndexPath *) indexPath {
    return [parameters objectAtIndex: indexPath.section];
}

- (NSMutableArray *) updateValues: (NSIndexPath *) indexPath {
    return [parameters objectAtIndex: indexPath.section];
}

//Return the line of text that should go in the specified row

- (NSString *) text: (NSIndexPath *) indexPath row: (NSUInteger) row
{
	indexPath = [indexPath indexPathByAddingIndex: row];
    return [properties objectAtIndex: row];
}

- (NSUInteger) numberOfRowsInResults: (NSInteger) section {
    NSArray *resultsGroup = [results objectAtIndex: section];
    return resultsGroup.count;
}

- (NSArray *) getOutputs: (NSIndexPath *) indexPath {
    return [outputs objectAtIndex: indexPath.section];
}

- (NSArray *) getResults: (NSIndexPath *) indexPath {
    return [results objectAtIndex: indexPath.section];
}


- (void) calculateResults {
    
    //declare constants
    static int const lifeExpectancy = 90;
    
    //pullout user data arrays
    NSArray *information = [parameters objectAtIndex: 0];
    NSArray *savings = [parameters objectAtIndex: 1];
    NSArray *sep = [parameters objectAtIndex: 2];
    NSArray *fourK = [parameters objectAtIndex: 3];
    NSArray *taxable = [parameters objectAtIndex: 4];
    NSArray *inflationA = [parameters objectAtIndex: 5];
    
    //pullout user parameters from arrays
    int currentAge = [[information objectAtIndex: 0] intValue];
    float requiredIncome = [[information objectAtIndex: 1] floatValue];
    int earlyRetirement = [[information objectAtIndex: 2] intValue];
    int fullRetirement = [[information objectAtIndex: 3] intValue];
    float earlyIncome = [[information objectAtIndex: 4] floatValue];
    float retirementIncome = [[information objectAtIndex: 5] floatValue];
    
    float savingsBal = [[savings objectAtIndex: 0] floatValue];
    float savingsRet = [[savings objectAtIndex: 1] floatValue];
    float savingsCon = [[savings objectAtIndex: 2] floatValue];
    
    float sepBal = [[sep objectAtIndex: 0] floatValue];
    float sepRetPre = [[sep objectAtIndex: 1] floatValue];
    float sepRetSemi = [[sep objectAtIndex: 2] floatValue];
    float sepRetFull = [[sep objectAtIndex: 3] floatValue];
    float sepCon = [[sep objectAtIndex: 4] floatValue];

    float taxableBal = [[taxable objectAtIndex: 0] floatValue];
    float taxableRetPre = [[taxable objectAtIndex: 1] floatValue];
    float taxableRetSemi = [[taxable objectAtIndex: 2] floatValue];
    float taxableRetFull = [[taxable objectAtIndex: 3] floatValue];
    float taxableCon = [[taxable objectAtIndex: 4] floatValue];
    float taxableRate = [[taxable objectAtIndex: 5] floatValue];
    
    float fourKBal = [[fourK objectAtIndex: 0] floatValue];
    float fourKRet = [[fourK objectAtIndex: 1] floatValue];
    float fourKCon = [[fourK objectAtIndex: 2] floatValue];
    
    float inflation = [[inflationA objectAtIndex: 0] floatValue];
    
    //non-time-dependent calculations
    int time  = lifeExpectancy - currentAge;
    
    //initialize other variables
    float income = 0.0;
    float taxableInvDd = 0.0;
    float retirementDd = 0.0;
    
    NSString *retired = @"";
    
    NSMutableArray *totalAssets = [NSMutableArray arrayWithCapacity: time];
    NSMutableArray *nwDelta = [NSMutableArray arrayWithCapacity: time];
    NSMutableArray *nwPerc = [NSMutableArray arrayWithCapacity: time];
    NSLog(@"%d",earlyRetirement);
    
    //increment the current age to skip the current year
    ++currentAge;
    
    //time-dependent calculations
    for (int i = 0; i < time; ++i) {
        
        //adjust the counter start point
        int age = i + currentAge;
        
        //inflate constants first
        earlyIncome += earlyIncome * inflation;
        retirementIncome += retirementIncome * inflation;
        requiredIncome += requiredIncome * inflation;

        
        //determine income
        if (age < earlyRetirement) {
            income = 0;
        } else if (age < fullRetirement) {
            income = earlyIncome;
        } else {
            income = retirementIncome;
        }

        //determine taxable investment drawdown
        if (age < earlyRetirement) {
            taxableInvDd = 0;
        } else {
            taxableInvDd = requiredIncome - income;
        }
        
        //determine taxable investment value
        if (age < earlyRetirement) {
            taxableBal += (1 - taxableRate) * (taxableBal * taxableRetPre) + taxableCon;
        } else if (age < fullRetirement) {
            taxableBal += (1 - taxableRate) * (taxableBal * taxableRetSemi) - taxableInvDd;
        } else {
            taxableBal += (1 - taxableRate) * (taxableBal * taxableRetFull) - taxableInvDd;
        }

        //determine retirement drawdown
        if (age < earlyRetirement || taxableBal > 0) {
            retirementDd = 0;
        } else {
            retirementDd = requiredIncome - income;
        }
        
        //determine savings value
        if (age < earlyRetirement) {
            savingsBal += savingsBal * savingsRet + savingsCon;
        } else {
            savingsBal += savingsBal * savingsRet;
        }
        
        //determine SEP value
        if (age < earlyRetirement) {
            sepBal += sepBal * sepRetPre + sepCon;
        } else if (age < fullRetirement) {
            sepBal += sepBal * sepRetSemi - retirementDd;
        } else {
            sepBal += sepBal *sepRetFull - retirementDd;
        }
        
        //determine 401k value
        if (age < earlyRetirement) {
            fourKBal += fourKBal * fourKRet + fourKCon;
        } else {
            fourKBal += fourKBal * fourKRet;
        }
        
        //determine if retired
        if (age < earlyRetirement) {
            retired = @"NO";
        } else if (age < fullRetirement) {
            retired = @"SEMI";
        } else {
            retired = @"YES";
        }

        //determine total assets
        float total = savingsBal + sepBal + fourKBal + taxableBal;
        [totalAssets addObject: [NSNumber numberWithFloat: total]];
        
        //determine net worth delta
        if (i > 0) {
            float ta = [[totalAssets objectAtIndex: i] floatValue];
            float pta = [[totalAssets objectAtIndex: (i-1)] floatValue];
            [nwDelta addObject: [NSNumber numberWithFloat:(ta - pta)]];
            
            float nwd = ta - pta;
            [nwPerc addObject: [NSNumber numberWithFloat:(nwd / pta)]];
            
        }
        
    }
    //add code to put values back into NSMutablArray results
    //could make this into a for loop if field names were added to an enum
    NSMutableArray *r = [results objectAtIndex: 0];
    
    [r replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:requiredIncome]];
    [r replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:income]];
    [r replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:savingsBal]];
    [r replaceObjectAtIndex:3 withObject:[NSNumber numberWithFloat:sepBal]];
    [r replaceObjectAtIndex:4 withObject:[NSNumber numberWithFloat:fourKBal]];
    [r replaceObjectAtIndex:5 withObject:[NSNumber numberWithFloat:taxableBal]];
    
    [r replaceObjectAtIndex:6 withObject: retired];
    [r replaceObjectAtIndex:7 withObject:[NSNumber numberWithFloat:taxableInvDd]];
    [r replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat:retirementDd]];

    [r replaceObjectAtIndex:9 withObject:[NSNumber numberWithFloat:[[totalAssets lastObject] floatValue]]];
    [r replaceObjectAtIndex:10 withObject:[NSNumber numberWithFloat:[[nwDelta lastObject] floatValue]]];
    [r replaceObjectAtIndex:11 withObject:[NSNumber numberWithFloat:[[nwPerc lastObject] floatValue]]];
    
    [results replaceObjectAtIndex:0 withObject: r];
}

@end

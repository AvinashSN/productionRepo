declare module "@salesforce/apex/LookupSObjectController.lookup" {
  export default function lookup(param: {searchString: any, sObjectAPIName: any, FilterCondition: any, isClickOnSearch: any}): Promise<any>;
}
declare module "@salesforce/apex/LookupSObjectController.lookupByFields" {
  export default function lookupByFields(param: {searchString: any, sObjectAPIName: any, FilterCondition: any, isClickOnSearch: any, listOfFieldsToBeQueried: any}): Promise<any>;
}

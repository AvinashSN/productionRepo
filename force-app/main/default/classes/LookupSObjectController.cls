/**
 * @group LookupComponentController. 
 *
 * @description Controller Class for Lookup Component.
 */
public with sharing class LookupSObjectController {

    /**
     * @description Query listof records matching the search string.
     * @param searchString : Search String corresponding to which records with saame name will be fetched.
     * @param sObjectAPIName: object apiname wrt to which query will be done.
     * @param FilterCondition : Extenal Filter condition to be applied in query.
     * @param isClickOnSearch : TRUE : SOQL ; FALSE : SOSL. 
     *
     */
    @AuraEnabled
    public static Result[] lookup(String searchString, String sObjectAPIName, String FilterCondition, boolean isClickOnSearch) {
        // Sanitze the input
        String sanitizedSObjectAPIName = String.isBlank(sObjectAPIName) ? '' : String.escapeSingleQuotes(sObjectAPIName);
        String sanitizedSearchString = String.isBlank(searchString) ? 'a' : String.escapeSingleQuotes(searchString);
        String sanitizedSObjectFilterCondition = String.isBlank(FilterCondition) ? '' : FilterCondition;

        List < Result > results = new List < Result > ();
        String ActiveProduct = 'Active';
        String searchQuery;
        // Build our SOSL query

        if (isClickOnSearch == true) {
            string orderbyquery = 'ORDER BY LastModifiedDate DESC';
            if (String.isBlank(FilterCondition)) {
                searchQuery = 'SELECT id, Name FROM ' + sanitizedSObjectAPIName + ' WHERE Name LIKE \'%' + searchString + '%\'' + orderbyquery + ' Limit 10';
            } else {
                searchQuery = 'SELECT id,Name FROM ' + sanitizedSObjectAPIName + ' WHERE Name LIKE \'%' + searchString + '%\' and ' + FilterCondition + ' ' + orderbyquery + ' Limit 10';
            }
            System.debug('lookup searchQuery1: ' + searchQuery);

            List < sObject > searchList = Database.query(searchQuery);

            for (SObject so: searchList) {
                results.add(new Result((String) so.get('Name'), so.Id));
            }

        } else {
            if (String.isBlank(FilterCondition)) {
                searchQuery = 'FIND {' + sanitizedSearchString + '*} IN ALL FIELDS RETURNING ' + sanitizedSObjectAPIName + '(id,name) Limit 50';
            } else {
                searchQuery = 'FIND {' + sanitizedSearchString + '*} IN ALL FIELDS RETURNING ' + sanitizedSObjectAPIName +
                    '(id,name WHERE ' + sanitizedSObjectFilterCondition + ' ) Limit 50';
            }
            System.debug('lookup searchQuery2: ' + searchQuery);
            // Execute the Query
            List < List < SObject >> searchList = search.query(searchQuery);
            if (searchList.size() > 0) {
                // Create a list of matches to return
                for (SObject so: searchList[0]) {
                    results.add(new Result((String) so.get('Name'), so.Id));
                }
            }
        }
        return results;
    }

    /**
     * @description Query list of records matching the search string and return with extra fields.
     * @param searchString : Search String corresponding to which records with same name and extra list of fields will be fetched.
     * @param sObjectAPIName: object apiname wrt to which query will be done.
     * @param FilterCondition : Extenal Filter condition to be applied in query.
     * @param isClickOnSearch : TRUE : SOQL ; FALSE : SOSL. 
     * @param listOfFieldsToBeQueried : Extra fields for which search string can match to.
     *
     */
    @AuraEnabled
    public static Result[] lookupByFields(String searchString, String sObjectAPIName, String FilterCondition, boolean isClickOnSearch, List < String > listOfFieldsToBeQueried) {
        // Sanitze the input
        String sanitizedSObjectAPIName = String.isBlank(sObjectAPIName) ? '' : String.escapeSingleQuotes(sObjectAPIName);
        String sanitizedSearchString = String.isBlank(searchString) ? 'a' : String.escapeSingleQuotes(searchString);
        String sanitizedSObjectFilterCondition = String.isBlank(FilterCondition) ? '' : FilterCondition;

        List < Result > results = new List < Result > ();
        String ActiveProduct = 'Active';
        String searchQuery;
        // Build our SOSL query

        if (listOfFieldsToBeQueried == null)
            listOfFieldsToBeQueried = new List < String > ();
        listOfFieldsToBeQueried.add('Id');
        List < String > listOfFieldsToBeQueriedWithoutName = listOfFieldsToBeQueried.clone();
        listOfFieldsToBeQueried.add('Name');

        if (isClickOnSearch == true) {
            string orderbyquery = 'ORDER BY LastModifiedDate DESC';
            if (String.isBlank(FilterCondition)) {
                searchQuery = 'SELECT ' + String.join(listOfFieldsToBeQueried, ', ');
                searchQuery += ' FROM ' + sanitizedSObjectAPIName + ' WHERE (';

                for (String field: listOfFieldsToBeQueried) {
                    if (field != 'Id')
                        searchQuery += field + ' like \'%' + sanitizedSearchString + '%\' or ';
                }

                if (listOfFieldsToBeQueried != null && listOfFieldsToBeQueried.size() > 0) {
                    searchQuery = searchQuery.substring(0, searchQuery.length() - 3);
                    searchQuery += ' ) ';
                }

                searchQuery += ' ' + orderbyquery + ' Limit 10';

            } else {

                searchQuery = 'SELECT ' + String.join(listOfFieldsToBeQueried, ', ');
                searchQuery += ' FROM ' + sanitizedSObjectAPIName + ' WHERE (';

                for (String field: listOfFieldsToBeQueried) {
                    if (field != 'Id')
                        searchQuery += field + ' like \'%' + sanitizedSearchString + '%\' or ';
                }

                if (listOfFieldsToBeQueried != null && listOfFieldsToBeQueried.size() > 0) {
                    searchQuery = searchQuery.substring(0, searchQuery.length() - 3);
                    searchQuery += ' ) ';
                }
                searchQuery += ' and ' + FilterCondition + ' ' + orderbyquery + ' Limit 10';
            }
            System.debug('lookupByFields searchQuery1: ' + searchQuery);
            List < sObject > searchList = Database.query(searchQuery);

            for (SObject so: searchList) {
                String key = '';
                String value = '';
                //key += '-' + so.get('Name');
                for (String field: listOfFieldsToBeQueriedWithoutName) {
                    if (field.toLowerCase() == 'id')
                        continue;
                    value = (String) so.get(field);
                    if (value != null)
                        key += value + ' -- ';
                }

                key += so.get('Name');
                //key = key.substring(1);
                results.add(new Result(key, so.Id));
            }

        } else {
            if (String.isBlank(FilterCondition)) {
                searchQuery = 'FIND {' + sanitizedSearchString + '*} IN ALL FIELDS RETURNING ' + sanitizedSObjectAPIName;
                searchQuery += '(' + String.join(listOfFieldsToBeQueried, ', ') + ' ) Limit 50';
            } else {
                searchQuery = 'FIND {' + sanitizedSearchString + '*} IN ALL FIELDS RETURNING ' + sanitizedSObjectAPIName +
                    '(' + String.join(listOfFieldsToBeQueried, ', ') + ' WHERE ' + sanitizedSObjectFilterCondition + ' ) Limit 50';
            }
            System.debug('lookupByFields searchQuery2: ' + searchQuery);
            // Execute the Query
            List < List < SObject >> searchList = search.query(searchQuery);

            // Create a list of matches to return
            for (SObject so: searchList[0]) {
                String key = '';
                String value = '';
                key += '-' + so.get('Name');
                for (String field: listOfFieldsToBeQueriedWithoutName) {
                    if (field.toLowerCase() == 'id')
                        continue;
                    value = (String) so.get(field);
                    if (value != null)
                        key += ' -- ' + value;
                }

                key = key.substring(1);
                results.add(new Result(key, so.Id));
                // results.add(new Result((String)so.get('Name'), so.Id));
            }
        }

        return results;
    }

    /**
     * Inner class to wrap up an SObject Label and its Id
     */
    public class Result {
        @AuraEnabled public String SObjectLabel {
            get;
            set;
        }
        @AuraEnabled public Id SObjectId {
            get;
            set;
        }

        public Result(String sObjectLabel, Id sObjectId) {
            this.SObjectLabel = sObjectLabel;
            this.SObjectId = sObjectId;
        }
    }


}
trigger LeadMergeResultTrigger on Lead (after delete) {

    // Initialize the list of merge results to create
    List<MergeResult__c> results = new List<MergeResult__c>();

    // Get the merge result service for the correct object
    MergeResultService service =
            MergeResultService.getInstance(Lead.sobjectType);

    for (Sobject eachRecord : Trigger.old) {
        if (String.isNotBlank((Id)eachRecord.get('MasterRecordId'))) {
            results.add(service.getMergeResult(eachRecord));
        }
    }

    // Create the merge results
    insert results;
}
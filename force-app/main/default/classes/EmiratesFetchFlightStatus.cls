public class EmiratesFetchFlightStatus {
    public class ActionInput {
        @InvocableVariable
        public String flight_id;
    }

    public class ActionOutput {
        @InvocableVariable
        public String flight_status_result;
    }

    @InvocableMethod(label='EmiratesFetchFlightStatus' description='Stub action for EmiratesFetchFlightStatus')
    public static List<ActionOutput> invoke(List<ActionInput> requests) {
        List<ActionOutput> results = new List<ActionOutput>();
        ActionOutput result = new ActionOutput();
        
        String responseText = 'unavailable';
        for (ActionInput request : requests){
            if (request.flight_id == 'FL001' || request.flight_id == 'FL002'){
                responseText = 'available';
            }
        }
        
        result.flight_status_result = responseText;
        results.add(result);
        return results;
    }
}
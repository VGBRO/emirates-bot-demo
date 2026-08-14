public class EmiratesCancelBooking {
    public class ActionInput {
        @InvocableVariable
        public String booking_id;
    }

    public class ActionOutput {
        @InvocableVariable
        public String cancel_result;
    }

    @InvocableMethod(label='EmiratesCancelBooking' description='Stub action for EmiratesCancelBooking')
    public static List<ActionOutput> invoke(List<ActionInput> requests) {
        List<ActionOutput> results = new List<ActionOutput>();
        ActionOutput result = new ActionOutput();
        String responseText = 'failed';
        for (ActionInput request : requests){
            if (request.booking_id == 'booking_12345'){
                responseText = 'successful';
            }
        }
        
        result.cancel_result = responseText;
        results.add(result);
        return results;
    }
}
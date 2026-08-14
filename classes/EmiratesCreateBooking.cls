public class EmiratesCreateBooking {
    public class ActionInput {
        @InvocableVariable(required=true)
        public String booking_flight;
        @InvocableVariable
        public String booking_date;
        @InvocableVariable
        public String profile_id;
        @InvocableVariable(required=true)
        public String source;
        @InvocableVariable(required=true)
        public String destination;
    }

    public class ActionOutput {
        @InvocableVariable
        public String created_booking_id;
    }

    @InvocableMethod(label='EmiratesCreateBooking' description='Stub action for EmiratesCreateBooking')
    public static List<ActionOutput> invoke(List<ActionInput> inputs) {
        List<ActionOutput> results = new List<ActionOutput>();
        ActionOutput result = new ActionOutput();
        result.created_booking_id = 'booking_12345';
        results.add(result);
        return results;
    }
}
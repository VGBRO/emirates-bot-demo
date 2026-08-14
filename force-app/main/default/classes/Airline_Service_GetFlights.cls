public class Airline_Service_GetFlights {
    private static List<String> airports = new List<String>{
        'FL001',
        'FL002'
    };
    
    @InvocableMethod(label='Emirates Get Flights' description = 'Get list of all the avaiable flights')
    public static List<List<String>> getListOfAllFlights(List<Request> requests) {
        List<List<String>> responseFlights = new List<List<String>>();
        List<String> availableAirports = new List<String>();
        for (Request request : requests){
            responseFlights.add(airports);
        }
        return responseFlights;
    }
    
    public class Request {
        @InvocableVariable(label='Origin' description='IATA code or city for departure airport' required=true)
        public String originCode;
        @InvocableVariable(label='Destination' description='IATA code or city for destination airport' required=true)
        public String destinationCode;
        @InvocableVariable(label='Departure Date' description='Departure date' required=true)
        public String departureDate;
        @InvocableVariable(label='Return Date' description='Return date for round trips')
        public String returnDate;
        @InvocableVariable(label='Passengers' description='Number of passengers')
        public Integer passengerCount;
    }
}
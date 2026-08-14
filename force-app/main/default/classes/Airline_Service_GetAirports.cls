public class Airline_Service_GetAirports {
    private static List<String> airports = new List<String>{
        'JFK - New York',
        'LAX - Los Angeles',
        'ORD - Chicago',
        'LHR - London',
        'CDG - Paris',
        'DXB - Dubai',
        'HND - Tokyo',
        'PEK - Beijing',
        'SIN - Singapore',
        'SYD - Sydney',
        'DEL - Delhi Indira Gandhi International',
        'BOM - Mumbai Chhatrapati Shivaji',
        'BLR - Bengaluru Kempegowda International',
        'HYD - Hyderabad Rajiv Gandhi International',
        'MAA - Chennai International',
        'CCU - Kolkata Netaji Subhas Chandra Bose',
        'COK - Kochi International',
        'PNQ - Pune International',
        'AMD - Ahmedabad Sardar Vallabhbhai Patel',
        'GOI - Goa Dabolim',
        'JAI - Jaipur International',
        'IXC - Chandigarh International',
        'PAT - Patna Jay Prakash Narayan',
        'LKO - Lucknow Chaudhary Charan Singh',
        'IXB - Bagdogra International'
    };
    
    @InvocableMethod(label='Get Airports' description = 'Get list of all the avaiable airports')
    public static List<List<String>> getListOfAllAirports(List<AirportRequest> requests) {
        List<List<String>> responseAirports = new List<List<String>>();
        List<String> availableAirports = new List<String>();
        for (AirportRequest request : requests){
            String boardingPoint = request.airportName;
            if(boardingPoint != '' && boardingPoint != null) {
                System.debug('Remove boarding point: '+boardingPoint);
                for (String airport : airports) {
                    if (!airport.equalsIgnoreCase(boardingPoint)) {
                        availableAirports.add(airport);
                    }
                }
            } else {
                availableAirports = airports;
            }
            responseAirports.add(availableAirports);
        }
        System.debug('AvailableAirports are: '+availableAirports);
        return responseAirports;
    }
    
    public class AirportRequest {
        @InvocableVariable(required = false label='Airport to Remove')
        public String airportName;
    }
}
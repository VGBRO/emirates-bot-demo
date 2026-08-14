public class EmiratesGetAirports {
      private static List<String> airports = new List<String>{
          'DXB - Dubai International',
          'AUH - Abu Dhabi Zayed International',
          'LHR - London Heathrow',
          'LGW - London Gatwick',
          'CDG - Paris Charles de Gaulle',
          'FRA - Frankfurt',
          'AMS - Amsterdam Schiphol',
          'IST - Istanbul',
          'JFK - New York John F. Kennedy',
          'LAX - Los Angeles',
          'ORD - Chicago \'O Hare',
          'YYZ - Toronto Pearson',
          'GRU - Sao Paulo Guarulhos',
          'JNB - Johannesburg O.R. Tambo',
          'NBO - Nairobi Jomo Kenyatta',
          'SIN - Singapore Changi',
          'HKG - Hong Kong International',
          'NRT - Tokyo Narita',
          'ICN - Seoul Incheon',
          'SYD - Sydney Kingsford Smith',
          'MEL - Melbourne',
          'DEL - Delhi Indira Gandhi International',
          'BOM - Mumbai Chhatrapati Shivaji',
          'BLR - Bengaluru Kempegowda International',
          'MAA - Chennai International',
          'HYD - Hyderabad Rajiv Gandhi International',
          'COK - Kochi International',
          'CCU - Kolkata Netaji Subhas Chandra Bose'
      };

      @InvocableMethod(label='Get Airports' description='Get list of all the available airports')
      public static List<List<String>> getListOfAllAirports(List<AirportRequest> requests) {
          List<List<String>> responseAirports = new List<List<String>>();
          for (AirportRequest request : requests) {
              List<String> availableAirports = new List<String>();
              String boardingPoint = request.airportName;
              if (boardingPoint != '' && boardingPoint != null) {
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
          return responseAirports;
      }

      public class AirportRequest {
          @InvocableVariable(required=false label='Airport to Remove')
          public String airportName;
      }
  }
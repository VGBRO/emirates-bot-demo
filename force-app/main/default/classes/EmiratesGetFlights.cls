public class EmiratesGetFlights {

      @InvocableMethod(label='Emirates Get Flights' description='Get available flights for any route')
      public static List<List<String>> getListOfAllFlights(List<Request> requests) {
          List<List<String>> responseFlights = new List<List<String>>();

          for (Request request : requests) {
              String origin = extractCode(request.originCode);
              String dest   = extractCode(request.destinationCode);

              List<String> flights = new List<String>();

              if (String.isBlank(origin)) { origin = 'ORG'; }
              if (String.isBlank(dest))   { dest   = 'DES'; }
  
              // Show the travel date in the label if the bot passed one.
              String dateLabel = (request.departureDate != null)
                                 ? ' on ' + request.departureDate.format()
                                 : '';
  
              Integer seed = Math.abs((origin + dest).hashCode());
              List<String> departures = new List<String>{ '08:15', '13:40', '21:10' };

              for (Integer i = 0; i < departures.size(); i++) {
                  Integer flightNo = 100 + Math.mod(seed + (i * 37), 899);
                  Integer hrs      = 2 + Math.mod(seed + i, 14);
                  Integer mins     = Math.mod(seed + (i * 17), 60);
                  flights.add(
                      'EK' + flightNo + ' - ' + origin + ' to ' + dest + dateLabel +
                      ' - Dep ' + departures[i] +
                      ', ' + hrs + 'h ' + String.valueOf(mins).leftPad(2, '0') + 'm'
                  );
              }
              responseFlights.add(flights);
          }
          return responseFlights;
      }
  
      private static String extractCode(String value) {
          if (String.isBlank(value)) return '';
          String token = value.trim().split(' ')[0];
          return token.toUpperCase();
      }

      public class Request {
          @InvocableVariable(label='Origin' description='IATA code or city for departure airport' required=true)
          public String originCode;
          @InvocableVariable(label='Destination' description='IATA code or city for destination airport' required=true)
          public String destinationCode;
          @InvocableVariable(label='Departure Date' description='Departure date' required=true)
          public Date departureDate;
          @InvocableVariable(label='Arrival Date' description='Arrival date for round trips')
          public Date arrivalDate;
          @InvocableVariable(label='Passengers' description='Number of passengers')
          public Integer passengerCount;
      }
  }
public class EmiratesFetchBookingStatus {
      public class Request {
          @InvocableVariable(required=true) public String booking_id;
      }
      public class Response {
          @InvocableVariable public Boolean is_success;
          @InvocableVariable public String  message;
      }

      @InvocableMethod(label='EmiratesFetchBookingStatus' description='Returns the status of a booking by PNR')
      public static List<Response> invoke(List<Request> requests) {
          List<Response> results = new List<Response>();
          for (Request req : requests) {
              Response out = new Response();
              List<Flight_Booking__c> rows = [SELECT PNR__c, Status__c, Source__c, Destination__c,
                                                     Departure_Date__c, Arrival_Date__c
                                              FROM Flight_Booking__c
                                              WHERE PNR__c = :req.booking_id LIMIT 1];
              if (rows.isEmpty()) {
                  out.is_success = false;
                  out.message    = 'No booking found with ID ' + req.booking_id + '.';
              } else {
                  Flight_Booking__c b = rows[0];
                  out.is_success = true;
                  out.message    = 'Booking ' + b.PNR__c + ' (' + b.Source__c + ' to '
                      + b.Destination__c + ', departing ' + b.Departure_Date__c.format()
                      + ') — Status: ' + b.Status__c + '.';
              }
              results.add(out);
          }
          return results;
      }
  }
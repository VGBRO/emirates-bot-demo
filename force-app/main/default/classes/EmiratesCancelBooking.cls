public class EmiratesCancelBooking {
      public class Request {
          @InvocableVariable(required=true) public String booking_id;   // the PNR
      }
      public class Response {
          @InvocableVariable public Boolean is_success;
          @InvocableVariable public String  message;
      }
      
      @InvocableMethod(label='EmiratesCancelBooking' description='Cancels an existing booking by PNR')
      public static List<Response> invoke(List<Request> requests) {
          List<Response> results = new List<Response>();
          for (Request req : requests) {
              Response out = new Response();
              try {
                  Flight_Booking__c b = [SELECT Id, PNR__c, Status__c
                                         FROM Flight_Booking__c
                                         WHERE PNR__c = :req.booking_id LIMIT 1];
                  if (b.Status__c == 'Cancelled') {
                      out.is_success    = false;
                      out.message = 'Booking ' + b.PNR__c + ' is already cancelled.';
                  } else {
                      b.Status__c        = 'Cancelled';
                      b.Cancelled_On__c  = System.now();
                      update b;
                      out.is_success    = true;
                      out.message = 'Booking ' + b.PNR__c + ' has been cancelled.';
                  }
              } catch (QueryException e) {   // no matching PNR
                  out.is_success    = false;
                  out.message = 'No booking found with ID ' + req.booking_id + '.';
              } catch (Exception e) {
                  out.is_success    = false;
                  out.message = 'Failed to cancel the booking: ' + e.getMessage();
              }
              results.add(out);
          }
          return results;
      }
}
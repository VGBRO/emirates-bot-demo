public class EmiratesCreateBooking {
      public class Request {
          @InvocableVariable(required=true) public String source;
          @InvocableVariable(required=true) public String destination;
          @InvocableVariable(required=true) public String booking_flight;
          @InvocableVariable public Date   departure_date;   // Date slot
          @InvocableVariable public Date   arrival_date;     // optional
          @InvocableVariable public String profile_id;
      }
      public class Response {
          @InvocableVariable public Boolean is_success;
          @InvocableVariable public String  created_booking_id;
          @InvocableVariable public String  message;
      }
      public class CustomException extends Exception {}

      @InvocableMethod(label='EmiratesCreateBooking' description='Creates a flight booking and returns a unique PNR')
      public static List<Response> invoke(List<Request> requests) {
          List<Response> results = new List<Response>();
          for (Request req : requests) {
              Response out = new Response();
              try {
                  Date dDate = (req.departure_date == null)
                               ? Date.today().addDays(1)
                               : req.departure_date;
                  if (dDate <= Date.today()) {
                      throw new CustomException('Departure date must be a future date.');
                  }
                  if (req.arrival_date != null && req.arrival_date < dDate) {
                      throw new CustomException('Arrival date cannot be before the departure date.');
                  }

                  Flight_Booking__c b = new Flight_Booking__c(
                      Booking_User__c   = req.profile_id,
                      Source__c         = req.source,
                      Destination__c    = req.destination,
                      Departure_Date__c = dDate,
                      Arrival_Date__c   = req.arrival_date,   // null if one-way
                      Status__c         = 'Confirmed'
                  );
                  insert b;

                  Flight_Booking__c saved = [SELECT PNR__c FROM Flight_Booking__c WHERE Id = :b.Id LIMIT 1];

                  out.is_success         = true;
                  out.created_booking_id = saved.PNR__c;
                  out.message            = 'Booking confirmed. Your PNR is ' + saved.PNR__c + '.';
              } catch (Exception e) {
                  out.is_success         = false;
                  out.created_booking_id = '';
                  out.message            = 'Could not create booking: ' + e.getMessage();
              }
              results.add(out);
          }
          return results;
      }
  }
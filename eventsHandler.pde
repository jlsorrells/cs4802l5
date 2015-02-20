import java.sql.ResultSet;

String table_name = "FORESTFIRE";

ArrayList<Float> xValues = new ArrayList<Float>();
ArrayList<Float> yValues = new ArrayList<Float>();

/**
 * @author: Fumeng Yang, Lane Harrison
 * @since: 2014
 */

void controlEvent(ControlEvent theEvent) {
    if (interfaceReady) {
        if (theEvent.isFrom("Temp") ||
            theEvent.isFrom("Humidity") ||
            theEvent.isFrom("Wind")) {
            queryReady = true;
        }

        if (theEvent.isFrom("Close")) {
            closeAll();
        }
    }
}

/**
 * generate and submit a query when mouse is released.
 * don't worry about this method
 */
void mouseReleased() {
    if (queryReady == true) {
        submitQuery();
        queryReady = false;
    }
}

void submitQuery() {

    // I'm getting the values of the slider here
    float maxTemp = rangeTemp.getHighValue();
    float minTemp = rangeTemp.getLowValue();
    
    float maxHumidity = rangeHumidity.getHighValue();
    float minHumidity = rangeHumidity.getLowValue();
    
    float maxWind = rangeWind.getHighValue();
    float minWind = rangeWind.getLowValue();

    // Integrate the variables into the sql String to make a valid statement
    String sql = "select * from " + table_name + " where Temp >= " + minTemp + " and Temp <= " + maxTemp + 
      " and Humidity >= " + minHumidity + " and Humidity <= " + maxHumidity + " and Wind >= " + minWind + 
      " and Wind <= " + maxWind;
    
    // This is where SQL will store your results
    ResultSet rs = null;

    try {
        // submit the sql query and get a ResultSet from the database
       rs  = (ResultSet) DBHandler.exeQuery(sql);
       
       xValues.clear();
       yValues.clear();
       
       // If the query was successful, you can iterate through the results here.
       // (Again, see http://docs.oracle.com/javase/tutorial/jdbc/basics/retrieving.html for examples)
        while (rs.next()) {
          
            // Example of extracting results per line
            int id = rs.getInt("id");
            int temp = rs.getInt("Temp");
            float wind = rs.getFloat("Humidity");
            float humidty = rs.getFloat("Wind");
            float x = rs.getFloat("x");
            float y = rs.getFloat("y");
            String month = rs.getString("month");
            String day = rs.getString("day");
            //System.out.println(id + "\t" + temp + "\t" + wind + "\t" + humidty + "\t" + x + "\t" + y + "\t" + month + "\t" + day);
            
            // store x,y for scatter plot
            xValues.add(x);
            yValues.add(y);
        }

    } catch (Exception e) {
        // should be a java.lang.NullPointerException here when rs is empty
        e.printStackTrace();
    } finally {
        closeThisResultSet(rs);
    }
}

void closeThisResultSet(ResultSet rs) {
    if(rs == null){
        return;
    }
    try {
        rs.close();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
}

void closeAll() {
    DBHandler.closeConnection();
    frame.dispose();
    exit();
}

<%-- 
    Document   : InfoChart
    Created on : Feb 5, 2018, 2:26:11 PM
    Author     : Vedant
--%>
<%@page import="java.util.*;"%>
<%@page import="com.mongodb.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Info Chart</title>
    </head>
    <body>
    <center><h3>Log Information Charts</h3></center>
        <%
            //  MongoClient ip and port no
            MongoClient mongoClient = new MongoClient("localhost", 27017);

            // Get handle to "ensat"
            DB db = mongoClient.getDB("ensat");

            // Get collection ensatLogInfo
            DBCollection collectionInfo = db.getCollection("ensatLogInfo");

            // Cursor to get all details from db
            DBCursor cursor = collectionInfo.find();
            List<DBObject> values = new ArrayList<DBObject>();
            List det = new ArrayList();
            List dateValues = new ArrayList();
            int k = 0;
            // Iterating the values and adding to the DBObject list
            while (cursor.hasNext()) {
                values.add(cursor.next());
            }

            Integer sqlDebug = 0;
            Integer sqlError = 0;
            Integer error = 0;
            Integer updatedRecords = 0;
            Integer remaining = 0;
            String logDate = "";
            // Storing value from db in an integer list for google charts
            for (DBObject logInfo : values) {
                sqlDebug = (Integer) logInfo.get("sqlDebugInfo");
                sqlError = (Integer) logInfo.get("sqlErrorInfo");
                error = (Integer) logInfo.get("errorInfo");
                updatedRecords = (Integer) logInfo.get("updatedRecordsInfo");
                remaining = (Integer) logInfo.get("remainingInfo");
                logDate = (String) logInfo.get("logDate");
                dateValues.add(logDate);
                det.add(sqlDebug);
                det.add(sqlError);
                det.add(error);
                det.add(updatedRecords);
                det.add(remaining);
            }
        %>        
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

        // Load the Visualization API and the corechart package.
        google.charts.load('current', {'packages': ['corechart']});

        // Set a callback to run when the Google Visualization API is loaded.
        google.charts.setOnLoadCallback(drawChart);

        // Callback that creates and populates a data table,
        // instantiates the pie chart, passes in the data and
        // draws it.

        function drawChart() {
            // Get details from jsp list
            var details = <%=det%>;
            var j = 1;
            var p = 2;
            var q = 3;
            var r = 4;
            var s = 5;
        <%
                for (int i = 0; i < det.size(); i += 5) {
        %>
            var a = <%=i%>;
            // store those details in js variables
            var sqlDebugInfo = details[a];

            var k = a + j;
            var l = a + p;
            var m = a + q;
            var n = a + r;
            var sqlErrorInfo = details[k];
            var errorInfo = details[l];
            var updatedRecordsInfo = details[m];
            var remainingInfo = details[n];

            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Information');
            data.addColumn('number', 'Slices');
            data.addRows([
                ['SQL Debug Information', sqlDebugInfo],
                ['Errors', errorInfo],
                ['Errors wrt SQL', sqlErrorInfo],
                ['Updated Records', updatedRecordsInfo],
                ['Remaining Information', remainingInfo]
            ]);

            // Set chart options
            var title = 'Log Information ' + <%=i%>;
            var options = {'title': title,
                'width': 700,
                'height': 600};

            // Instantiate and draw our chart, passing in some options.
            var chartid = 'chart_div' + <%=i%>;
            var chart = new google.visualization.PieChart(document.getElementById(chartid));
            chart.draw(data, options);
        <%
                                }%>

        }
    </script>
    <!--Div to hold the pie chart-->
    <% 
        for (int j = 0; j < det.size(); j += 5) {
    %>
    <center><%
            for(; k < dateValues.size();){
            %>
            <p><b>Date: </b><%=dateValues.get(k)%></p>
            <%k++;break;}%>
            <div id="chart_div<%=j%>"></div>
    </center>
        <%
            }
        %>
</body>
</html>

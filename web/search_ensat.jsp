<%-- 
    Document   : search_ensat
    Created on : Jan 25, 2018, 5:08:29 PM
    Author     : Vedant
--%>

<%@page import="java.util.*;"%>
<%@page import="com.mongodb.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Result</title>
        <style>
            * {
                box-sizing: border-box;
            }

            #myTable {
                border-collapse: collapse;
                width: 100%;
                border: 1px solid #ddd;
                font-size: 18px;
            }

            #myTable th, #myTable td {
                text-align: left;
                padding: 12px;
            }

            #myTable tr {
                border-bottom: 1px solid #ddd;
            }

            #myTable tr.header, #myTable tr:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>
        <table id = "myTable">
            <%

                List<DBObject> values = new ArrayList<DBObject>();
                String ensat_id = "";
                String username = "";
                String table = "";
                String date = "";
                DBObject history = new BasicDBObject();
                String field = "";
                String old_value = "";
                String new_value = "";
                // Getting data from database via post request
                values = (ArrayList) request.getAttribute("values");

                if (values.iterator().hasNext()) {

            %>
            <thead>
                <tr>
                    <th>Ensat ID</th>
                    <th>Username</th>
                    <th>Table</th>
                    <th>Date</th>
                    <th colspan="3"><center>History</center></th>
    </tr>
    <tr>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th>Field</th>
        <th>Old Value</th>
        <th>New Value</th>
    </tr>
</thead>
<%// Iterating the values and getting desired values
    for (DBObject db : values) {

        ensat_id = (String) db.get("ensat_id");
        username = (String) db.get("username");
        table = (String) db.get("table");
        date = (String) db.get("date");
        history = (BasicDBObject) db.get("history");

        field = (String) history.get("field");
        old_value = (String) history.get("old_value");
        new_value = (String) history.get("new_value");

%>
<tbody>
    <tr>
        <td><%=ensat_id%></td>
        <td><%=username%></td>
        <td><%=table%></td>
        <td><%=date%></td>
        <td><%=field%></td>
        <td><%=old_value%></td>
        <td><%=new_value%></td>
    </tr>

</tbody>
<%

    }

} else {

%>

No such entries available

<%}%>
</table>
</body>
</html>

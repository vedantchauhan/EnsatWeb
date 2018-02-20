<%-- 
    Document   : searchHistory
    Created on : Feb 11, 2018, 4:45:47 PM
    Author     : Vedant
--%>

<%@page import="java.util.*;"%>
<%@page import="com.mongodb.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            * {
                box-sizing: border-box;
            }

            #myInput {
                background-image: url('/css/searchicon.png');
                background-position: 10px 10px;
                background-repeat: no-repeat;
                width: 100%;
                font-size: 16px;
                padding: 12px 20px 12px 40px;
                border: 1px solid #ddd;
                margin-bottom: 12px;
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
        <input type="text" id="myInput" onkeyup="searchFunction()" placeholder="Search ensat..." title="Type in a name">
        <%
            // MongoClient ip and port no
            MongoClient mongoClient = new MongoClient("localhost", 27017);
            // Get handle to "ensat"
            DB db1 = mongoClient.getDB("ensat");
            // Get collection ensatHistory
            DBCollection collectionInfo = db1.getCollection("ensatHistory");
            // Cursor to get all details from db
            DBCursor cursor = collectionInfo.find();
            List<DBObject> values = new ArrayList<DBObject>();
            // Iterating the values and adding to the DBObject list
            while (cursor.hasNext()) {
                values.add(cursor.next());
            }

            String ensat_id = "";
            String username = "";
            String table = "";
            String date = "";
            DBObject history = new BasicDBObject();
            String field = "";
            String old_value = "";
            String new_value = "";

            if (values.iterator().hasNext()) {

        %>
        <table id="myTable">            
            <thead>
                <tr class="header">
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

Not Available

<%}%>
</table>

<script>
    function searchFunction() {
        var input, filter, table, tr, td, td1, td2, td3, td4, td5, td6, i;
        // text input
        input = document.getElementById("myInput");
        // case insensitive search
        filter = input.value.toUpperCase();
        // table
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");
        // iterating over the columns of table
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
            td1 = tr[i].getElementsByTagName("td")[1];
            td2 = tr[i].getElementsByTagName("td")[2];
            td3 = tr[i].getElementsByTagName("td")[3];
            td4 = tr[i].getElementsByTagName("td")[4];
            td5 = tr[i].getElementsByTagName("td")[5];
            td6 = tr[i].getElementsByTagName("td")[6];
            if (td) {
                if (td.innerHTML.toUpperCase().indexOf(filter) > -1 || td1.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                        td2.innerHTML.toUpperCase().indexOf(filter) > -1 || td3.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                        td4.innerHTML.toUpperCase().indexOf(filter) > -1 || td5.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                        td6.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>
</body>
</html>

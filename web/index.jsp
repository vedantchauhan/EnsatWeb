<%-- 
    Document   : index
    Created on : Jan 22, 2018, 11:52:06 AM
    Author     : Vedant
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ENSAT History</title>
        <style>
            * {
                box-sizing: border-box;
            }

            #myInput {
                background-position: 10px 10px;
                background-repeat: no-repeat;
                width: 100%;
                font-size: 16px;
                padding: 12px 20px;
                border: 1px solid #ccc;
                margin-bottom: 12px;
                border-radius: 4px;
                background-color: #f8f8f8;
                resize: none;
            }

            #select {
                width: 100%;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                margin-bottom: 12px;
                background-color: #f1f1f1;
            }

            .button {
                background-color: #999966;
                border: none;
                color: white;
                padding: 12px 20px;
                text-align: center;
                font-size: 16px;
                margin-bottom: 12px;
                opacity: 0.6;
                transition: 0.3s;
                display: inline-block;
                text-decoration: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .button:hover {opacity: 1}

            a:link, a:visited {
                background-color: #555555;
                color: white;
                padding: 14px 25px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                border-radius: 4px;
            }


            a:hover, a:active {
                background-color: #999966;
            }
        </style>
    </head>
    <body>
    <center>
        <h3>Welcome to ENSAT Audit Log</h3><br>
        <p>Search existing or updated information from one of the two search options.
            Search based on the category by providing the query in the search box or <br>
            Click the below link to check all the data and search the database.</p>
        <a href="searchHistory.jsp">Search Information</a> <br>
        <p><u> OR </u></p><br>
        <form action="${pageContext.request.contextPath}/search_ensat" method="POST">
            <table>
                <tbody>
                    <tr>
                        <td><b>Enter Input</b></td>
                        <td>
                            <br><input id = "myInput" type="text" name="search" />
                        </td>
                        <td><br></td>
                        <td><b>Category</b></td>

                        <td><br><select id = "select" name="categories">

                                <option value="-1">---Select Category---</option>

                                <option value="ensat_id">Ensat ID</option>

                                <option value="username">Username</option>

                                <option value="table">Table</option>

                                <option value="date">Date</option>

                            </select>
                        </td>
                        <td>
                            <br><input class ="button" type="submit" value="Search" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <hr style="border: 1px dashed black;" />
        <br><p>
            Information regarding SQL debug and errors in log files. Click the below link to check log information.
        </p>
        <br> <a href="infoChart.jsp">Log Information</a>
    </center>
</body>
</html>

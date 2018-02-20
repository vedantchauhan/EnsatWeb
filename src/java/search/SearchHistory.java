/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package search;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vedant
 */
public class SearchHistory extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession(true);
        //  MongoClient ip and port no
        MongoClient mongoClient = new MongoClient("localhost", 27017);

        // Get handle to "ensat"
        DB db = mongoClient.getDB("ensat");
        // Get collection ensatHistory
        DBCollection collection = db.getCollection("ensatHistory");

        String search = "";
        String category = "";
        // Get search input from UI
        search = " " + request.getParameter("search");
        // Get search category from UI
        category = request.getParameter("categories");
        List values = new ArrayList();
        if (search != null && !(search.equals("")) && category != null && !(category.equals("-1"))) {
            
            BasicDBObject whereQuery = new BasicDBObject();
            whereQuery.put(category, search);
            // Query the database
            DBCursor cursor = collection.find(whereQuery);

            while (cursor.hasNext()) {
                values.add(cursor.next());
            }

        }
        
        // send data to UI
        request.setAttribute("values", values);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/search_ensat.jsp");
        dispatcher.forward(request, response);
    }
}

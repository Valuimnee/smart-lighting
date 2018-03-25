package app.backend;

import app.config.Options;
import app.models.Road;
import app.models.RoadStat;

import java.sql.*;
import java.util.ArrayList;

/**
 * <p>Class for connecting to database</p>
 *
 */
public class dbDriver {
    private static final String GET_ROADS = "select * from traffic_info right join road on traffic_info.id=road.id " +
            "where date_stamp>'2018-03-24' order by date_stamp desc;";
    private static final String GET_STATS = "select road.id, road.road_name, sum(traffic_counter) as counter, price\n" +
            "from traffic_info right join road  on traffic_info.id=road.id left join sys_price on sys_price.id=road.id group by id";
    private static final String CREATE_ROAD = "insert into traffic_info values (?, ?, ?)";
    private static final String GET_NOT_WORKING_ROADS = "select road.id, road_name, last_date from road " +
            "left join (select id, max(date_stamp) as last_date from traffic_info GROUP BY id) as tr on road.id=tr.id " +
            "where last_date<'2018-03-25' or last_date is NULL";

    private Connection conn = null;
    private Statement stmt = null;
    private PreparedStatement pstmt = null;
    private ResultSet res = null;
    private String sql;

    /**
     * Wrapper on {@link dbDriver#connect()}
     *
     * @see dbDriver#connect()
     */
    public dbDriver() {
        connect();
    }

    /**
     * Create new database connection
     *
     * @see Options#JDBC_DRIVER
     * @see Options#DB_URL
     * @see Options#DB_USER
     * @see Options#DB_PASS
     */
    private void connect() {
        try {
            Class.forName(Options.JDBC_DRIVER);
            System.out.println("[dbDriver] Connecting to database...");
            conn = DriverManager.getConnection(Options.DB_URL + Options.DB_NAME, Options.DB_USER, Options.DB_PASS);
            stmt = conn.createStatement();
            System.out.println("[dbDriver] Successfully connect to " + conn.getMetaData().getURL());
        } catch (Exception se) {
            System.out.println("[dbDriver] Some problem with db connection");
            se.printStackTrace();
            System.exit(1);
        }
    }

    /**
     * Create table
     *
     * @see Options#DB_NAME
     */
    private void createTable(String tableName, String sql) {
        System.out.println("[dbDriver] Creating table...");
        try {
            stmt.executeUpdate(sql);
            System.out.println("Table '" + Options.DB_NAME + "." + tableName + "' created successfully.");
        } catch (Exception se) {
            se.printStackTrace();
        }
    }

    /**
     * Drop database if exist, and create new
     *
     * @see Options#DB_NAME
     */
    private void dropDB() {
        try {
            System.out.println("[dbDriver] Drop database...");
            sql = "DROP DATABASE IF EXISTS " + Options.DB_NAME;
            stmt.executeUpdate(sql);

            System.out.println("[dbDriver] Creating database...");
            sql = "CREATE DATABASE " + Options.DB_NAME;
            stmt.executeUpdate(sql);
            System.out.println("[dbDriver] Database '" + Options.DB_NAME + "' created successfully.");
        } catch (Exception se) {
            se.printStackTrace();
        }
    }

    /**
     * Drop database if exist, and create new
     * Create all tables
     *
     * @see dbDriver#dropDB()
     * @see Options#DB_NAME
     */
    public void createDB() {
        dropDB();
        connect();
    }

    private void close() {
        try {
            if (stmt != null)
                stmt.close();
        } catch (SQLException se2) {
            System.out.println(se2.getMessage());
        }

        try {
            if (pstmt != null)
                pstmt.close();
        } catch (SQLException se2) {
            System.out.println(se2.getMessage());
        }

        try {
            if (conn != null)
                conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }

        System.out.println("[dbDriver] Close db connection... Goodbye!");
    }

    public ArrayList<Road> getRoads(){
        System.out.println("[dbDriver] Select students...");
        ArrayList<Road> data = new ArrayList<>();
        try {
            res = stmt.executeQuery(GET_ROADS);
            while (res.next()) {
                int id = res.getInt("id");
                String name=res.getString("road_name");
                int traffic=res.getInt("traffic_counter");
                Date date=res.getDate("date_stamp");
                Road road=new Road(id, name, traffic, date);
                data.add(road);
            }
            System.out.println("[dbDriver] Successfully select " + data.size() + " students.");
        } catch (Exception se) {
            se.printStackTrace();
        }
        return data;
    }

    public ArrayList<RoadStat> getStats(){
        System.out.println("[dbDriver] Select students...");
        ArrayList<RoadStat> data = new ArrayList<>();
        try {
            res = stmt.executeQuery(GET_STATS);
            while (res.next()) {
                int id = res.getInt("id");
                String name=res.getString("road_name");
                int traffic=res.getInt("counter");
                int price=res.getInt("price");
                RoadStat road=new RoadStat(id, name, traffic, price);
                data.add(road);
            }
            System.out.println("[dbDriver] Successfully select " + data.size() + " students.");
        } catch (Exception se) {
            se.printStackTrace();
        }
        return data;
    }

    public void addRoadSensor(int id, int total) {
        try {
            pstmt = conn.prepareStatement(CREATE_ROAD);
            pstmt.setInt(1, id);
            pstmt.setInt(2, total);
            pstmt.setDate(3, Date.valueOf("2018-03-25"));
            pstmt.executeUpdate();
        } catch (Exception se) {
            se.printStackTrace();
        }
    }

    public ArrayList<Road> getNotWorkingRoads(){
        System.out.println("[dbDriver] Select students...");
        ArrayList<Road> data = new ArrayList<>();
        try {
            res = stmt.executeQuery(GET_NOT_WORKING_ROADS);
            while (res.next()) {
                int id = res.getInt("id");
                String name=res.getString("road_name");
                Date date=res.getDate("last_date");
                Road road=new Road(id, name, 0, date);
                data.add(road);
            }
            System.out.println("[dbDriver] Successfully select " + data.size() + " students.");
        } catch (Exception se) {
            se.printStackTrace();
        }
        return data;
    }
}
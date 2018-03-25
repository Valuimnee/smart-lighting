package app.models;

import java.io.Serializable;
import java.sql.Date;

/**
 * @author TsalapovaMD
 * @version 1.0, 3/25/2018
 */
public class Road implements Serializable {
    private int id;
    private String roadName;
    private int trafficInfo;
    private Date date;

    public Road(int id, String roadName, int trafficInfo, Date date) {
        this.id = id;
        this.roadName = roadName;
        this.trafficInfo = trafficInfo;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoadName() {
        return roadName;
    }

    public void setRoadName(String roadName) {
        this.roadName = roadName;
    }

    public int getTrafficInfo() {
        return trafficInfo;
    }

    public void setTrafficInfo(int trafficInfo) {
        this.trafficInfo = trafficInfo;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}

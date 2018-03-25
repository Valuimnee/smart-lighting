package app.models;

import java.io.Serializable;

/**
 * @author TsalapovaMD
 * @version 1.0, 3/25/2018
 */
public class RoadStat implements Serializable {
    private int id;
    private String roadName;
    private int trafficInfo;
    private int price;

    public RoadStat(int id, String roadName, int trafficInfo, int price) {
        this.id = id;
        this.roadName = roadName;
        this.trafficInfo = trafficInfo;
        this.price=price;

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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}

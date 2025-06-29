package dto;

import entity.PricePackage;
import entity.Subject;
import entity.User;

import java.time.LocalDateTime;
import java.util.Map;

public class RegistrationDTO implements Comparable<RegistrationDTO>{
    private int id;
    private String time;
    private double totalCost;
    private Integer duration;
    private String validFrom;
    private String validTo;
    private String status;
    private String note;
    private PricePackage pricePackage;
    private User user;
    private User lastUpdatedBy;
    private Subject subject;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public String getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(String validFrom) {
        this.validFrom = validFrom;
    }

    public String getValidTo() {
        return validTo;
    }

    public void setValidTo(String validTo) {
        this.validTo = validTo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public PricePackage getPricePackage() {
        return pricePackage;
    }

    public void setPricePackage(PricePackage pricePackage) {
        this.pricePackage = pricePackage;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    public void setLastUpdatedBy(User lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    private static final Map<String, Integer> STATUS_PRIORITY = Map.of(
            "Pending Confirmation", 0,
            "Pending Payment", 1,
            "Paid", 2,
            "Expired", 3,
            "Canceled", 4,
            "Rejected", 5
    );

    @Override
    public int compareTo(RegistrationDTO other) {
        return Integer.compare(
                STATUS_PRIORITY.getOrDefault(this.status, Integer.MAX_VALUE),
                STATUS_PRIORITY.getOrDefault(other.status, Integer.MAX_VALUE)
        );
    }
}

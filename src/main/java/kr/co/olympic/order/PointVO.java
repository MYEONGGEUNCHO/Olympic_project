package kr.co.olympic.order;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PointVO {
	private int point_no;
    private String content;
    private String member_no;
    private int point;
    private Timestamp date;
    private boolean isUse;
}

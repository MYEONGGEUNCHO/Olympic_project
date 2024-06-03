package kr.co.olympic.qna;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AttachedVO {
	private int file_no;
	private String original;
	private String real;
	private Timestamp upload_date;
	private int qna_no;
}

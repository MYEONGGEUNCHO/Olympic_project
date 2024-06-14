package kr.co.olympic.qna;

import java.sql.Timestamp;
import java.util.UUID;

import lombok.Data;

@Data
public class AttachedVO {
	private String file_no;
	private String original_name;
	private String forsave_name;
	private Timestamp upload_date;
}

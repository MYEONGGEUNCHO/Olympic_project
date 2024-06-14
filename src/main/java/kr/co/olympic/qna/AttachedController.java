package kr.co.olympic.qna;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class AttachedController {

	@Autowired
	private QnaService service;
	private String uploadDir;

	/**
	 * 에디터 이미지 업로드
	 * 
	 * @param image 파일 객체
	 * @return 업로드된 파일 정보가 담긴 AttachedVO 객체
	 */
	@PostMapping("/qna/upload.do")
	@ResponseBody
	public AttachedVO upload(@RequestPart(value = "file") MultipartFile file, HttpServletRequest request) {
		this.uploadDir = request.getRealPath("/uploads/");
//		System.out.println("uploadDir : " + uploadDir);
		AttachedVO vo = new AttachedVO();
		if (!file.isEmpty()) {
			String org = file.getOriginalFilename();
//			System.out.println("파일이 존재하긴함" + org);
			String ext = org.substring(org.lastIndexOf("."));
			String file_uuid = UUID.randomUUID().toString();
			String forSave = file_uuid.replaceAll("-", "") + ext;
			String path = Paths.get(uploadDir, forSave).toString();
			File dir = new File(uploadDir);
			if (!dir.exists()) {
//				System.out.println("경로가 없어서 만든다" + dir.toURI());
				dir.mkdirs();
			}
			try {
				file.transferTo(new File(path));
				vo.setFile_no(file_uuid);
				vo.setOriginal_name(org);
				vo.setForsave_name(forSave);
				return vo;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * 디스크에 업로드된 파일을 byte[]로 반환
	 * 
	 * @param filename 디스크에 업로드된 파일명
	 * @return image byte array
	 */
	@ResponseBody
	@GetMapping(value = "/qna/download.do", produces = { MediaType.IMAGE_GIF_VALUE, MediaType.IMAGE_JPEG_VALUE,
			MediaType.IMAGE_PNG_VALUE })
	public byte[] download(@RequestParam final String filename) {
//		System.out.println("다운로드 요청 : " + uploadDir);

		// 업로드된 파일의 전체 경로
		String fileFullPath = Paths.get(uploadDir, filename).toString();

		// 파일이 없는 경우 예외 throw
		File uploadedFile = new File(fileFullPath);
		if (uploadedFile.exists() == false) {
			throw new RuntimeException();
		}

		try {
			// 이미지 파일을 byte[]로 변환 후 반환
			byte[] imageBytes = Files.readAllBytes(uploadedFile.toPath());
			return imageBytes;

		} catch (IOException e) {
			// 예외 처리는 따로 해주는 게 좋습니다.
			throw new RuntimeException(e);
		}
	}
}

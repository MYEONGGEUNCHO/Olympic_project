package kr.co.olympic;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	@GetMapping("/index.do")
	public String index(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "index";
	}

	/**
	 * 디스크에 업로드된 파일을 byte[]로 반환
	 *
	 * @param filename 디스크에 업로드된 파일명
	 * @return image byte array
	 */
	@ResponseBody
	@GetMapping(value = "carousel", produces = { MediaType.IMAGE_GIF_VALUE, MediaType.IMAGE_JPEG_VALUE,
			MediaType.IMAGE_PNG_VALUE })
	public byte[] download(@RequestParam final String filename, HttpServletRequest request) {
		String uploadDir = request.getRealPath("/carousel-img/");
		// 업로드된 파일의 전체 경로
		String fileFullPath = Paths.get(uploadDir, filename).toString();

		// 파일이 없는 경우 예외 throw
		File uploadedFile = new File(fileFullPath);
		if (!uploadedFile.exists()) {
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

	/**
	 * 디렉토리 내의 모든 파일명을 리스트로 반환
	 *
	 * @param request HttpServletRequest
	 * @return list of filenames
	 */
	@ResponseBody
	@GetMapping(value = "carousel-images")
	public List<String> listAllImages(HttpServletRequest request) {
		String uploadDir = request.getRealPath("/carousel-img/");
		File dir = new File(uploadDir);
		List<String> fileNames = new ArrayList<>();

		if (dir.exists() && dir.isDirectory()) {
			File[] files = dir.listFiles();
			if (files != null) {
				for (File file : files) {
					if (file.isFile()) {
						fileNames.add(file.getName());
					}
				}
			}
		} else {
			throw new RuntimeException("Directory not found or is not a directory.");
		}

		return fileNames;
	}
}

package config;

import java.util.Properties;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = "kr.co.olympic")
@MapperScan(basePackages = "kr.co.olympic", annotationClass = Mapper.class)
@EnableWebMvc
@EnableTransactionManagement
@EnableScheduling
public class MvcConfig implements WebMvcConfigurer {
	
	@Value("${email.username}")
	private String emailId;
	@Value("${email.password}")
	private String emailPwd;
	
	// 이메일 전송
	@Bean
	public JavaMailSender NaverMailService() {
		JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
		javaMailSender.setHost("smtp.naver.com"); // SMTP 서버명
		javaMailSender.setUsername(emailId); // 네이버 아이디
		javaMailSender.setPassword(emailPwd); // 네이버 비밀번호

		javaMailSender.setPort(465); // SMTP 포트

		javaMailSender.setJavaMailProperties(getMailProperties()); // 메일 인증서버 가져오기

		return javaMailSender;

	}

	private Properties getMailProperties() {
		Properties properties = new Properties();
		properties.setProperty("mail.transport.protocol", "smtp"); // 프로토콜 설정
		properties.setProperty("mail.smtp.auth", "true"); // smtp 인증
		properties.setProperty("mail.smtp.starttls.enable", "true"); // smtp strattles 사용
		properties.setProperty("mail.debug", "true"); // 디버그 사용
		properties.setProperty("mail.smtp.ssl.trust", "smtp.naver.com"); // ssl 인증 서버 (smtp 서버명)
		properties.setProperty("mail.smtp.ssl.enable", "true"); // ssl 사용
		properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		return properties;
	}

	// 파일업로드
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipart = new CommonsMultipartResolver();
		// 파일사이즈
		multipart.setMaxUploadSize(1024 * 1024 * 5);
		multipart.setDefaultEncoding("utf-8");
		return multipart;
	}

	// db.properties에 있는 속성
	@Value("${db.driver}")
	private String driver;
	@Value("${db.url}")
	private String url;
	@Value("${db.username}")
	private String username;
	@Value("${db.password}")
	private String password;

	// ViewResolver 설정(JSP 경로)
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	// 정적페이지 처리(컨트롤러가 아니라 톰캣에서 처리하기 위해)
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	// 비즈니스 로직이 필요없는 URL 매핑
	@Override
	public void addViewControllers(ViewControllerRegistry reg) {
		reg.addViewController("/member/event.do");
	}

	// HikariCP
	@Bean
	public HikariDataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource();
//		dataSource.setDriverClassName("oracle.jdbc.OracleDriver");
//		dataSource.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:XE");
		dataSource.setDriverClassName(driver);
		dataSource.setJdbcUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		return dataSource;
	}

	// MyBatis
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean ssf = new SqlSessionFactoryBean();
		ssf.setDataSource(dataSource()); // CP 객체 주입

		// xml 파일(Mapper파일) 위치(경로)
//		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
//		ssf.setMapperLocations(resolver.getResources("classpath:/mapper/**/*.xml"));
		return ssf.getObject();
	}
	// DAO에서 주입받을 객체
//	@Bean
//	public SqlSessionTemplate sqlSessionTemplate() throws Exception {
//		return new SqlSessionTemplate(sqlSessionFactory()); // MyBatis 객체(빈)를 주입
//	}

	// 트랜잭션 설정
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager dtm = new DataSourceTransactionManager(dataSource());
//		dtm.setDataSource(dataSource());
		return dtm;
	}

	// 로그인인터셉터 빈등록
//	@Bean
//	public LoginInterceptor loginInterception() {
//		return new LoginInterceptor();
//	}

	// 인터셉터 설정
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// url 설정
//		registry.addInterceptor(loginInterception())
//				.addPathPatterns("/member/mypage.do")
//				.addPathPatterns("/member/order.do");
		/*
		 * 관리자페이지 .addPathPatterns("/admin/**") .excludePathPatterns("/admin/login.do")
		 */
	}

	// properties 설정
	@Bean
	public static PropertyPlaceholderConfigurer propreties() {
		PropertyPlaceholderConfigurer config = new PropertyPlaceholderConfigurer();
		config.setLocations(new ClassPathResource("db.properties"), new ClassPathResource("email.properties")
							, new ClassPathResource("order.properties"));
		return config;
	}

}

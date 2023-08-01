package com.bitc.board.config;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@PropertySources({
	@PropertySource("classpath:prop/db.properties")
})
@ComponentScan(basePackages = {"com.bitc.board.service"})
@MapperScan(basePackages = {"com.bitc.board.dao"})
public class RootConfig {
	
	// 연결한 프로퍼티에서 EL태그로 변수명으로 사용가능 - 만약 값이 없을 경우 넣은 문자열로 대체
	// EX - jdbc.username이 존재하지 않으면 username에는 jdbc.username이라는 값이 들어간다.
	@Value("${jdbc.log4j.driver}")
	private String driver;
	@Value("${jdbc.log4j.url}")
	private String jdbcUrl;
	@Value("${jdbc.username}")
	private String username;
	@Value("${jdbc.password}")
	private String password;
	
	@PostConstruct
	public void init() {
		System.out.println("init ------------------");
		System.out.println("driver : " + driver);
		System.out.println("jdbcUrl : " +  jdbcUrl);
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		System.out.println("------------------ init");
	}
	
	@Bean("hc")
	public HikariConfig hikariConfig() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName(driver);
		hikariConfig.setJdbcUrl(jdbcUrl);
		hikariConfig.setUsername(username);
		hikariConfig.setPassword(password);
		hikariConfig.setMaximumPoolSize(20);
		return hikariConfig;
	}
	
	@Bean
	public DataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource(hikariConfig());
		return dataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory
			= new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource());
		// sqlSessionFactory.setTypeAliasesPackage("com.bitc.board.vo , com.bitc.board.util");
		// Resource res = new ClassPathResource("mybatis/sql/boardMapper.xml");
		// sqlSessionFactory.setMapperLocations(res);
		return sqlSessionFactory.getObject();
	}
	
}

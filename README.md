# Olympic_project
![Generic badge](https://img.shields.io/badge/Spring_Legacy_Project-sky.svg)  ![Generic badge](https://img.shields.io/badge/Docker-blue.svg)  ![Generic badge](https://img.shields.io/badge/Airflow-red.svg)  ![Generic badge](https://img.shields.io/badge/Mysql-skyblue.svg)  ![Generic badge](https://img.shields.io/badge/MongoDB-sky.svg)  ![Generic badge](https://img.shields.io/badge/github-black.svg)  ![Generic badge](https://img.shields.io/badge/Jenkinds-navy.svg)  

![](src/main/webapp/img/main.png)


## 목차  
1. [프로젝트 구조](#1-프로젝트-설명)  
2. [ERD 및 테이블](#2-erd-및-테이블)  
3. [프로젝트 목표](#3-프로젝트-목표)  
4. [결제프로세스](#4-결제프로세스) 

## 1. 프로젝트 설명
프로젝트 주제: 티켓 판매 쇼핑몰 구현

특별한 시즌 티켓 판매 사이트(올림픽, FIFA, E-Sport 등)

실제 파리 올림픽 데이터 이용(경기 일정, 경기장 정보 등)

## 2. ERD 및 테이블
![](src/main/webapp/img/erd.png)

## 3. 프로젝트 목표
- 주문, 취소, 환불, 포인트, 쿠폰 기능 구현
- Ajax를 이용한 SPA 구현
- 데이터파이프라인 구현

## 4. 결제프로세스
```mermaid
sequenceDiagram
    participant 유저
    participant DB
    participant BE
    participant 포트원
    
    유저 ->> BE: ① 결제요청(3분간 좌석선점)
    BE ->> 포트원: ② 결제 요청
    Note right of 포트원: ② 결제 요청 ③ 결제 정보저장<br/>주문코드(order_no)<br/>좌석총가격<br/>상태코드(결제, 취소)<br/>쿠폰번호<br/>
    BE ->> DB: ③ 결제 정보 저장
    포트원 ->> BE: ④ 결제키 발급
    포트원 ->> BE: ⑤ 결제키, 결제 토큰
    BE ->> 포트원: ⑥ 주문 정보
    포트원 ->> BE: ⑧ OK
    BE ->> DB: ⑦ 유효성 검사

```

## 5. 데이터프로세스
```mermaid
sequenceDiagram
    participant DSIO
    participant MongoDB
    participant Mysql

    DSIO ->> MongoDB: ① 크롤링
    loop
        MongoDB ->> MongoDB: ② 전처리
    end
    MongoDB ->> Mysql: ③저장
```
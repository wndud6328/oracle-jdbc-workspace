package model;

import java.util.List;

public class Restaurant {
	
	private String name;      // 이름
	private List menu;        // 메뉴
	private int searchScore;  // 검색횟수
	private String foodKind;  // 음식종류
    private int reserScore;   // 예약확정수
	private double Ratings; // 평점
	private List<Comment> comments; // 댓글, 리뷰
	private String popularTime;   // 피크타임
	private List waitingCustomer;	   // 웨이팅 고객 리스트(수)
	private int waitingTime;	 	     // 웨이팅 예상시간 (실시간)
	private int tableNum; 	 	 // 테이블 수
	private String address; //식당의 주소
    private String phoneNumber; //식당의 전화번호
    private String operatingHours; //식당의 영업시간
    private String discounts; //식당의 할인 정보
    private double latitude; //식당의 위치 정보 위도
    private double longitude; //식당의 위치 정보 경도
	private String bestMenu; //대표메뉴1개
	private String imgUrl; //대표메뉴1개 사진
	private String imgUrl2; // 각 메뉴 사진
	private String imgUrl3; //식당사진 -수정,삭제
	private String operatingInfo; // 휴무일
	private String facility; //편의시설 - 남녀화장실구분, 무선인터넷, 단체석구비, 등
	private String introduction; // 매장소개
	private boolean Picked;   //매장Pick

}
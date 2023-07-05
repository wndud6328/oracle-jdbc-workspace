package com.kh.model.vo;
// 테이블 : TB_BOOK / 컬럼 : bk_no , bk_title , bk_author

public class Book {
	
	public Book(String title, String author) {
	}
	private int bkno;
	private String bkTitle;
	private String bkAuthor;
	
	public Book(int bkno, String bkTitle, String bkAuthor) {
		this.bkno = bkno;
		this.bkTitle = bkTitle;
		this.bkAuthor = bkAuthor;
	}
	public int getBkno() {
		return bkno;
	}
	public void setBkno(int bkno) {
		this.bkno = bkno;
	}
	public String getBkTitle() {
		return bkTitle;
	}
	public void setBkTitle(String bkTitle) {
		this.bkTitle = bkTitle;
	}
	public String getBkAuthor() {
		return bkAuthor;
	}
	public void setBkAuthor(String bkAuthor) {
		this.bkAuthor = bkAuthor;
	}
	
	@Override
	public String toString() {
		return "Book [bkno=" + bkno + ", bkTitle=" + bkTitle + ", bkAuthor=" + bkAuthor + "]";
	}
	
}

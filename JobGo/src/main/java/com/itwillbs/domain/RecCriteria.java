package com.itwillbs.domain;

public class RecCriteria {
	
	private int recPage;		// 페이지 정보
	private int recPageSize;   // 페이지 크기
	private String search;  // 검색
	
	public RecCriteria() {
		this.recPage = 1;
		this.recPageSize = 12;
	}
	
	// SET
	public void setRecPage(int recPage) {
		if(recPage <= 0) {
			this.recPage = 1;
			return;
		}
		this.recPage = recPage;
	}
	
	public void setRecPageSize(int recPageSize) {
		if(recPageSize <= 0 || recPageSize >= 100) {
			this.recPageSize = 12;
		}
		this.recPageSize = recPageSize;
	}
	
	public void setSearch(String search) {
		this.search = search;
	}
	
	// GET
	public int getRecPage() {
		return recPage;
	}
	
	// 페이지 정보를 받아서 mapper에서 사용할 인덱스로 전환
	public int getRecPageStart() {
		return (this.recPage - 1) * this.recPageSize;
	}

	public int getRecPageSize() {
		return recPageSize;
	}

	public String getSearch() {
		return search;
	}





}

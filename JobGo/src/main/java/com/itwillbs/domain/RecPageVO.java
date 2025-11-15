package com.itwillbs.domain;

// 채용공고 전용 페이징 처리 객체
public class RecPageVO {
    
    private int totalCount;     // 총 글 개수
    private int startPage;      // 페이징 블럭 시작 번호
    private int endPage;        // 페이징 블럭 끝 번호
    
    private boolean prev;       // 이전 페이지 이동 여부
    private boolean next;       // 다음 페이지 이동 여부
    
    private int pageBlock = 10; // 페이징 블럭 크기 (1~10, 11~20 ...)
    
    private RecCriteria cri;    // 채용공고 전용 Criteria
    
    // RecCriteria 세팅
    public void setCri(RecCriteria cri) {
        this.cri = cri;
    }
    
    // 총 게시물 수 세팅 → 페이징 계산 자동 실행
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcPageData();
    }
    
    //  페이징 계산 핵심 로직
    private void calcPageData() {
        System.out.println(" RecPageVO: 페이징 계산 시작");
        
        // 현재 블럭의 끝 페이지 번호 계산
        endPage = (int)(Math.ceil(cri.getRecPage() / (double) pageBlock) * pageBlock);
        
        // 현재 블럭의 시작 페이지 번호 계산
        startPage = (endPage - pageBlock) + 1;
        
        // 전체 페이지 수 계산 (실제 존재하는 페이지)
        int tmpEndPage = (int)Math.ceil(totalCount / (double) cri.getRecPageSize());
        
        // endPage가 실제 페이지 수보다 크면 보정
        if (endPage > tmpEndPage) {
            endPage = tmpEndPage;
        }
        
        // 이전 버튼 표시 여부
        prev = startPage != 1;
        
        // 다음 버튼 표시 여부
        next = endPage * cri.getRecPageSize() < totalCount;
        
        System.out.println("▶ RecPageVO: 페이징 계산 완료");
    }
    
    //      Getter
    public int getTotalCount() {
        return totalCount;
    }

    public int getStartPage() {
        return startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public boolean isNext() {
        return next;
    }

    public int getPageBlock() {
        return pageBlock;
    }

    public RecCriteria getCri() {
        return cri;
    }
    
    //      Setter
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public void setPrev(boolean prev) {
        this.prev = prev;
    }

    public void setNext(boolean next) {
        this.next = next;
    }

    public void setPageBlock(int pageBlock) {
        this.pageBlock = pageBlock;
    }

    @Override
    public String toString() {
        return "RecPageVO [totalCount=" + totalCount 
                + ", startPage=" + startPage 
                + ", endPage=" + endPage 
                + ", prev=" + prev 
                + ", next=" + next 
                + ", pageBlock=" + pageBlock 
                + ", cri=" + cri + "]";
    }
}
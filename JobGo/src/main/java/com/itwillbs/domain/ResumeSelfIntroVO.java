package com.itwillbs.domain;

import lombok.Data;

@Data
public class ResumeSelfIntroVO {
    private int resumeId;         // 이력서 ID (PK + FK)
    private String motivation;    // 지원 동기
    private String strengths;     // 강점 및 역량
    private String keyExperience; // 성과나 중요한 경험
    private String futurePlan;    // 입사 후 포부
}

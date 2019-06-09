package com.experiment.entity;

public class Work {
    private String workId;
    private String workName;
    private String workLesson;
    private String workRequirement;
    private String workOutline;
    private String workGuide;
    private String workDesign;
    private String workInitiator;
    private String workCreateTime;
    private String workEndTime;
    private String workStatus;
    private String workDetailPart;
    private String workDetailContent;
    private String workDetailScore;

    public String getWorkDetailPart() {
        return workDetailPart;
    }

    public void setWorkDetailPart(String workDetailPart) {
        this.workDetailPart = workDetailPart;
    }

    public String getWorkDetailContent() {
        return workDetailContent;
    }

    public void setWorkDetailContent(String workDetailContent) {
        this.workDetailContent = workDetailContent;
    }

    public String getWorkDetailScore() {
        return workDetailScore;
    }

    public void setWorkDetailScore(String workDetailScore) {
        this.workDetailScore = workDetailScore;
    }

    /**
     *  0:规划中
     *  1:提交中
     *  2:批阅中
     *  3:公示中
     */

    private String workType;
    private String workTarget;

    public String getWorkTarget() {
        return workTarget;
    }

    public void setWorkTarget(String workTarget) {
        this.workTarget = workTarget;
    }

    public String getWorkId() {
        return workId;
    }

    public void setWorkId(String workId) {
        this.workId = workId;
    }

    public String getWorkName() {
        return workName;
    }

    public void setWorkName(String workName) {
        this.workName = workName;
    }

    public String getWorkLesson() {
        return workLesson;
    }

    public void setWorkLesson(String workLesson) {
        this.workLesson = workLesson;
    }

    public String getWorkRequirement() {
        return workRequirement;
    }

    public void setWorkRequirement(String workRequirement) {
        this.workRequirement = workRequirement;
    }

    public String getWorkOutline() {
        return workOutline;
    }

    public void setWorkOutline(String workOutline) {
        this.workOutline = workOutline;
    }

    public String getWorkGuide() {
        return workGuide;
    }

    public void setWorkGuide(String workGuide) {
        this.workGuide = workGuide;
    }

    public String getWorkDesign() {
        return workDesign;
    }

    public void setWorkDesign(String workDesign) {
        this.workDesign = workDesign;
    }

    public String getWorkInitiator() {
        return workInitiator;
    }

    public void setWorkInitiator(String workInitiator) {
        this.workInitiator = workInitiator;
    }

    public String getWorkCreateTime() {
        return workCreateTime;
    }

    public void setWorkCreateTime(String workCreateTime) {
        this.workCreateTime = workCreateTime;
    }

    public String getWorkEndTime() {
        return workEndTime;
    }

    public void setWorkEndTime(String workEndTime) {
        this.workEndTime = workEndTime;
    }

    public String getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(String workStatus) {
        this.workStatus = workStatus;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }
}

package com.example.asmnews.entity;

import java.util.Date;

/**
 * Entity class cho bảng News
 * Đại diện cho tin tức
 */
public class News {
    private String id;
    private String title;
    private String content;
    private String image;
    private Date postedDate;
    private String author;
    private Integer viewCount;
    private String categoryId;
    private Boolean home; // true: Hiển thị trên trang chủ

    // Thuộc tính bổ sung để join với bảng khác
    private String categoryName;
    private String authorName;

    // Constructor mặc định
    public News() {
        this.viewCount = 0;
        this.home = false;
        this.postedDate = new Date();
    }

    // Constructor có tham số
    public News(String id, String title, String content, String image,
            Date postedDate, String author, Integer viewCount,
            String categoryId, Boolean home) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.postedDate = postedDate;
        this.author = author;
        this.viewCount = viewCount != null ? viewCount : 0;
        this.categoryId = categoryId;
        this.home = home != null ? home : false;
    }

    // Getter và Setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public Boolean getHome() {
        return home;
    }

    public void setHome(Boolean home) {
        this.home = home;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    // Phương thức tiện ích
    public void increaseViewCount() {
        if (this.viewCount == null) {
            this.viewCount = 1;
        } else {
            this.viewCount++;
        }
    }

    public boolean isOnHomePage() {
        return home != null && home;
    }

    public String getShortContent(int maxLength) {
        if (content == null)
            return "";
        if (content.length() <= maxLength)
            return content;
        return content.substring(0, maxLength) + "...";
    }

    @Override
    public String toString() {
        return "News{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", categoryId='" + categoryId + '\'' +
                ", viewCount=" + viewCount +
                ", home=" + home +
                '}';
    }
}

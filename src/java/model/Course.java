package model;

import java.util.Date;
import java.util.List;

public class Course {

    private int id;
    private String courseName;
    private String courseTitle;
    private String courseDescription;
    private String courseImage;
    private Date startDate;
    private Date endDate;
    private String status;
    private int courseCategoryId;

    private String requirements;
    private Instructor instructor;
    private List<String> learningOutcomes;

    // Reference to CourseCategory object
    private CourseCategory courseCategory;

    public Course() {
    }

    public Course(int id, String courseName, String courseTitle, String courseDescription,
            String courseImage, Date startDate, Date endDate, String status, int courseCategoryId) {
        this.id = id;
        this.courseName = courseName;
        this.courseTitle = courseTitle;
        this.courseDescription = courseDescription;
        this.courseImage = courseImage;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.courseCategoryId = courseCategoryId;
    }

    // Constructor with CourseCategory object
    public Course(int id, String courseName, String courseTitle, String courseDescription,
            String courseImage, Date startDate, Date endDate, String status,
            int courseCategoryId, CourseCategory courseCategory) {
        this.id = id;
        this.courseName = courseName;
        this.courseTitle = courseTitle;
        this.courseDescription = courseDescription;
        this.courseImage = courseImage;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.courseCategoryId = courseCategoryId;
        this.courseCategory = courseCategory;
    }

    public int getId() {
        return id;
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }

    public Instructor getInstructor() {
        return instructor;
    }

    public void setInstructor(Instructor instructor) {
        this.instructor = instructor;
    }

    public List<String> getLearningOutcomes() {
        return learningOutcomes;
    }

    public void setLearningOutcomes(List<String> learningOutcomes) {
        this.learningOutcomes = learningOutcomes;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public String getCourseDescription() {
        return courseDescription;
    }

    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }

    public String getCourseImage() {
        return courseImage;
    }

    public void setCourseImage(String courseImage) {
        this.courseImage = courseImage;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCourseCategoryId() {
        return courseCategoryId;
    }

    public void setCourseCategoryId(int courseCategoryId) {
        this.courseCategoryId = courseCategoryId;
    }

    public CourseCategory getCourseCategory() {
        return courseCategory;
    }

    public void setCourseCategory(CourseCategory courseCategory) {
        this.courseCategory = courseCategory;
    }

    @Override
    public String toString() {
        return "Course{" + "id=" + id + ", courseName=" + courseName + ", courseTitle=" + courseTitle
                + ", courseDescription=" + courseDescription + ", courseImage=" + courseImage
                + ", startDate=" + startDate + ", endDate=" + endDate + ", status=" + status
                + ", courseCategoryId=" + courseCategoryId + '}';
    }
}

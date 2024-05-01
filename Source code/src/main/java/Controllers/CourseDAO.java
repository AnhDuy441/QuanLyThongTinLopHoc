package Controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Objects.Course;

public class CourseDAO {
    // Lấy danh sách tất cả khóa học
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT * FROM Course";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Course course = new Course();
                course.setId(resultSet.getString("Id"));
                course.setName(resultSet.getString("Name"));
                course.setLecture(resultSet.getString("Lecture"));
                course.setYear(resultSet.getInt("Year"));
                course.setNotes(resultSet.getString("Notes"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    // Thêm khóa học mới
    public void addCourse(Course course) {
        String query = "INSERT INTO Course (Id, Name, Lecture, Year, Notes) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, course.getId());
            statement.setString(2, course.getName());
            statement.setString(3, course.getLecture());
            statement.setInt(4, course.getYear());
            statement.setString(5, course.getNotes());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa khóa học bằng ID
    public boolean removeCourse(String courseId) {
        String query = "DELETE FROM Course WHERE Id=?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Lấy thông tin khóa học bằng ID
    public Course getCourseById(String courseId) {
        String query = "SELECT * FROM Course WHERE Id=?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Course course = new Course();
                    course.setId(resultSet.getString("Id"));
                    course.setName(resultSet.getString("Name"));
                    course.setLecture(resultSet.getString("Lecture"));
                    course.setYear(resultSet.getInt("Year"));
                    course.setNotes(resultSet.getString("Notes"));
                    return course;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Cập nhật thông tin khóa học
    public boolean editCourse(Course course) {
        String query = "UPDATE Course SET Name=?, Lecture=?, Year=?, Notes=? WHERE Id=?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, course.getName());
            statement.setString(2, course.getLecture());
            statement.setInt(3, course.getYear());
            statement.setString(4, course.getNotes());
            statement.setString(5, course.getId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

 // Sắp xếp danh sách các khóa học theo tên
    public List<Course> sortCoursesByName() {
        List<Course> sortedCourses = new ArrayList<>();
        String query = "SELECT * FROM Course ORDER BY Name";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Course course = new Course();
                course.setId(resultSet.getString("Id"));
                course.setName(resultSet.getString("Name"));
                course.setLecture(resultSet.getString("Lecture"));
                course.setYear(resultSet.getInt("Year"));
                course.setNotes(resultSet.getString("Notes"));
                sortedCourses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sortedCourses;
    }

    // Tìm kiếm các khóa học theo tên
    public List<Course> searchCoursesByName(String name) {
        List<Course> foundCourses = new ArrayList<>();
        String query = "SELECT * FROM Course WHERE Name LIKE ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + name + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Course course = new Course();
                    course.setId(resultSet.getString("Id"));
                    course.setName(resultSet.getString("Name"));
                    course.setLecture(resultSet.getString("Lecture"));
                    course.setYear(resultSet.getInt("Year"));
                    course.setNotes(resultSet.getString("Notes"));
                    foundCourses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return foundCourses;
    }

    // Tìm kiếm khóa học theo năm
    public List<Course> searchCoursesByYear(int year) {
        List<Course> foundCourses = new ArrayList<>();
        String query = "SELECT * FROM Course WHERE Year = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Course course = new Course();
                    course.setId(resultSet.getString("Id"));
                    course.setName(resultSet.getString("Name"));
                    course.setLecture(resultSet.getString("Lecture"));
                    course.setYear(resultSet.getInt("Year"));
                    course.setNotes(resultSet.getString("Notes"));
                    foundCourses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return foundCourses;
    }

    // Tìm kiếm khóa học
    public List<Course> searchCourses(String name, int year) {
        List<Course> foundCourses = new ArrayList<>();
        String query = "SELECT * FROM Course WHERE Name LIKE ? AND Year = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + name + "%");
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Course course = new Course();
                    course.setId(resultSet.getString("Id"));
                    course.setName(resultSet.getString("Name"));
                    course.setLecture(resultSet.getString("Lecture"));
                    course.setYear(resultSet.getInt("Year"));
                    course.setNotes(resultSet.getString("Notes"));
                    foundCourses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return foundCourses;
    }

}

package Controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Objects.Student;

public class CourseStudentDAO {
    // Lấy danh sách sinh viên theo mã khoá học
    public List<Student> getStudentsByCourseId(String courseId) {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.* FROM Student s JOIN Course_Student cs ON s.Id = cs.Student_Id WHERE cs.Course_Id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Student student = new Student();
                    student.setId(resultSet.getString("Id"));
                    student.setName(resultSet.getString("Name"));
                    student.setBirthday(resultSet.getDate("Birthday"));
                    student.setAddress(resultSet.getString("Address"));
                    student.setNotes(resultSet.getString("Notes"));
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return students;
    }
    
    // Lấy danh sách sinh viên chưa có trong khoá học
    public List<Student> getStudentsNotInCourse(String courseId) {
        List<Student> studentsNotInCourse = new ArrayList<>();
        String query = "SELECT * FROM Student WHERE Id NOT IN (SELECT Student_Id FROM Course_Student WHERE Course_Id=?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Student student = new Student();
                    student.setId(resultSet.getString("Id"));
                    student.setName(resultSet.getString("Name"));
                    student.setBirthday(resultSet.getDate("Birthday"));
                    student.setAddress(resultSet.getString("Address"));
                    student.setNotes(resultSet.getString("Notes"));
                    studentsNotInCourse.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return studentsNotInCourse;
    }

    // Thêm sinh viên vào khóa học
    public void addStudentToCourse(String courseStudentId, String studentId, String courseId, float grade) {
        String query = "INSERT INTO Course_Student (Id, Student_Id, Course_Id, Grade) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseStudentId);
            statement.setString(2, studentId);
            statement.setString(3, courseId);
            statement.setFloat(4, grade);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Kiểm tra sự trùng lặp của IdCourseStudent
    public boolean isDuplicateCourseStudentId(String courseStudentId) {
        String query = "SELECT COUNT(*) FROM Course_Student WHERE Id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseStudentId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    
    // Xoá sinh viên khỏi khoá học
    public boolean removeStudentFromCourse(String courseId, String studentId) {
        String query = "DELETE FROM Course_Student WHERE Course_Id = ? AND Student_Id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, courseId);
            statement.setString(2, studentId);
            int rowsAffected = statement.executeUpdate();
            // Trả về true nếu có dòng được xoá
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

package Controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Objects.Student;

public class StudentDAO {
    // Lấy danh sách tất cả sinh viên
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM Student";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Student student = new Student();
                student.setId(resultSet.getString("Id"));
                student.setName(resultSet.getString("Name"));
                student.setBirthday(resultSet.getDate("Birthday"));
                student.setAddress(resultSet.getString("Address"));
                student.setNotes(resultSet.getString("Notes"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return students;
    }

    // Thêm sinh viên mới
    public void addStudent(Student student) {
        String query = "INSERT INTO Student (Id, Name, Birthday, Address, Notes) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, student.getId());
            statement.setString(2, student.getName());
            statement.setDate(3, new java.sql.Date(student.getBirthday().getTime()));
            statement.setString(4, student.getAddress());
            statement.setString(5, student.getNotes());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa sinh viên bằng ID
    public boolean removeStudent (String studentId) {
        String query = "DELETE FROM Student WHERE Id=?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, studentId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Lấy thông tin sinh viên bằng ID
    public Student getStudentById(String studentId) {
    	String query = "SELECT * FROM Student WHERE Id=?";

        try (Connection connection = DatabaseConnection.getConnection();
        		PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setString(1, studentId);
        	try (ResultSet resultSet = statement.executeQuery()) {
        		if (resultSet.next()) {
                    Student student = new Student();
                    student.setId(resultSet.getString("Id"));
                    student.setName(resultSet.getString("Name"));
                    student.setBirthday(resultSet.getDate("Birthday"));
                    student.setAddress(resultSet.getString("Address"));
                    student.setNotes(resultSet.getString("Notes"));
                    return student;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Cập nhật thông tin sinh viên
    public boolean editStudent(Student student) {
        String query = "UPDATE Student SET Name=?, Birthday=?, Address=?, Notes=? WHERE Id=?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, student.getName());
            statement.setDate(2, new java.sql.Date(student.getBirthday().getTime()));
            statement.setString(3, student.getAddress());
            statement.setString(4, student.getNotes());
            statement.setString(5, student.getId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Sắp xếp danh sách theo tên
    public List<Student> sortStudentsByName() {
        List<Student> sortedStudents = new ArrayList<>();
        String query = "SELECT * FROM Student ORDER BY Name";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Student student = new Student();
                student.setId(resultSet.getString("Id"));
                student.setName(resultSet.getString("Name"));
                student.setBirthday(resultSet.getDate("Birthday"));
                student.setAddress(resultSet.getString("Address"));
                student.setNotes(resultSet.getString("Notes"));
                sortedStudents.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sortedStudents;
    }

    // Tìm sinh viên theo tên
    public List<Student> searchStudentsByName(String name) {
        List<Student> foundStudents = new ArrayList<>();
        String query = "SELECT * FROM Student WHERE Name LIKE ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + name + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Student student = new Student();
                    student.setId(resultSet.getString("Id"));
                    student.setName(resultSet.getString("Name"));
                    student.setBirthday(resultSet.getDate("Birthday"));
                    student.setAddress(resultSet.getString("Address"));
                    student.setNotes(resultSet.getString("Notes"));
                    foundStudents.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return foundStudents;
    }
}

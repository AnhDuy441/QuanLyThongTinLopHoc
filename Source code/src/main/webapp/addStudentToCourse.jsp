<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Controllers.CourseStudentDAO" %>
<%@ page import="Controllers.StudentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="Objects.Student" %>
<%@ page import="Objects.Course" %>
<%@ page import="Controllers.CourseDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student to Course</title>
</head>
<body>
    <h1>Add Student to Course</h1>
    <form action="addStudentToCourse.jsp" method="post">
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Birthday</th>
                <th>Address</th>
                <th>Notes</th>
                <th>Action</th>
            </tr>
            <% 
                // Lấy danh sách sinh viên chưa được thêm vào khoá học
                String courseIdParam = request.getParameter("courseId");
                CourseStudentDAO courseStudentDAOParam = new CourseStudentDAO();
                List<Student> studentsNotInCourse = courseStudentDAOParam.getStudentsNotInCourse(courseIdParam);

                // Hiển thị danh sách sinh viên chưa được thêm vào trong bảng
                for (Student student : studentsNotInCourse) { %>
                    <tr>
                        <td><%= student.getId() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getBirthday() %></td>
                        <td><%= student.getAddress() %></td>
                        <td><%= student.getNotes() %></td>
                        <td>
                            <button type="button" onclick="showAddForm('<%= student.getId() %>')">Add</button>
                        </td>
                    </tr>
                <% } %>
        </table>
    	<br>
        <div id="addForm" style="display: none;">
            <label for="courseStudentId">Course Student ID:</label>
            <input type="text" id="courseStudentId" name="courseStudentId" required>
            <label for="grade">Grade:</label>
            <input type="text" id="grade" name="grade" required>
            <input type="hidden" name="courseId" value="<%= courseIdParam %>">
            <input type="submit" value="Add">
        </div>
    </form>
    <br>
    <form action="courseStudents.jsp" method="get">
        <input type="hidden" name="courseId" value="<%= courseIdParam %>">
        <input type="submit" value="Go back">
    </form>
    <script>
        function showAddForm(studentId) {
            document.getElementById('addForm').style.display = 'block';
            document.getElementById('courseStudentId').value = studentId;
        }
    </script>
    <% 
        // Xử lý khi người dùng gửi form
        if (request.getMethod().equalsIgnoreCase("post")) {
            String[] studentIds = request.getParameterValues("studentIds");
            String courseId = request.getParameter("courseId");
            String courseStudentId = request.getParameter("courseStudentId");
            float grade = Float.parseFloat(request.getParameter("grade"));

            // Kiểm tra sự trùng lặp của IdCourseStudent trước khi thêm vào cơ sở dữ liệu
            boolean isDuplicate = courseStudentDAOParam.isDuplicateCourseStudentId(courseStudentId);

            // Nếu không có trùng lặp, thêm sinh viên vào khoá học
            if (!isDuplicate) {
                for (String studentId : studentIds) {
                    courseStudentDAOParam.addStudentToCourse(courseStudentId, studentId, courseId, grade);
                }
                // Hiển thị thông báo sau khi thêm sinh viên thành công
                out.println("<p>Student(s) added to course successfully.</p>");
            } else {
                // Hiển thị thông báo khi có sự trùng lặp của IdCourseStudent
                out.println("<p>Error: Course Student ID already exists.</p>");
            }
        }
    %>
</body>
</html>

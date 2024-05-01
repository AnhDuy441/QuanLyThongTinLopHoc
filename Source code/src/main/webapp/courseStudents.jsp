<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Objects.Student" %>
<%@ page import="Controllers.CourseStudentDAO" %>
<%@ page import="Objects.Course" %>
<%@ page import="Controllers.CourseDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Students</title>
    <script>
        function redirectToAddCourseStudentsPage(courseId) {
            window.location.href = "addStudentToCourse.jsp?courseId=" + courseId;
        }
        function redirectToCoursesPage() {
	        window.location.href = "courses.jsp";
	    }
        function removeStudentFromCourse(courseId, studentId) {
            if (confirm("Are you sure you want to remove this student from the course?")) {
                window.location.href = "removeStudentFromCourse.jsp?courseId=" + courseId + "&studentId=" + studentId;
            }
        }
    </script>
</head>
<body>
    <% 
        String courseId = request.getParameter("courseId");
        if (courseId != null) {
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseById(courseId);
            if (course != null) { %>
                <h1><%= course.getId() %>: <%= course.getName() %></h1>
            <% }
            CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
            List<Student> students = courseStudentDAO.getStudentsByCourseId(courseId);
            if (!students.isEmpty()) { %>
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Birthday</th>
                        <th>Address</th>
                        <th>Notes</th>
                        <th>Action</th>
                    </tr>
                    <% for (Student student : students) { %>
                        <tr>
                            <td><%= student.getId() %></td>
                            <td><%= student.getName() %></td>
                            <td><%= student.getBirthday() %></td>
                            <td><%= student.getAddress() %></td>
                            <td><%= student.getNotes() %></td>
                            <td>
                                <button onclick="removeStudentFromCourse('<%= courseId %>', '<%= student.getId() %>')">Remove</button>
                            </td>
                        </tr>
                    <% } %>
                </table>
                <br>
                <button onclick="redirectToAddCourseStudentsPage('<%= course.getId() %>')">Add Student</button>
                <br>
                <br>
                <button onclick="redirectToCoursesPage()">Go back</button>
            <% } else { %>
                <p>No students found for this course.</p>
            <% }
        } else { %>
            <p>No course ID provided.</p>
        <% } %>
</body>
</html>

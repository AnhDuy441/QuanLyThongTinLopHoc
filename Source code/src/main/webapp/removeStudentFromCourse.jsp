<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Controllers.CourseStudentDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove Student From Course</title>
    <script>
    function redirectToCourseStudentsPage(courseId) {
        window.location.href = "courseStudents.jsp?courseId=" + courseId;
    }
</script>
</head>
<body>
    <h1>Remove Student From Course</h1>
    <% 
        String courseId = request.getParameter("courseId");
        String studentId = request.getParameter("studentId");

        if (courseId != null && studentId != null) {
            CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
            boolean removed = courseStudentDAO.removeStudentFromCourse(courseId, studentId);

            if (removed) { %>
                <p>Student removed from course successfully.</p>
            <% } else { %>
                <p>Failed to remove student from course.</p>
            <% }
        } else { %>
            <p>No course ID or student ID provided.</p>
        <% } %>
    <br>
    <button onclick="redirectToCourseStudentsPage('<%= courseId %>')">Go back</button>
</body>
</html>

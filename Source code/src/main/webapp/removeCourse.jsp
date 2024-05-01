<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Controllers.CourseDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove Course</title>
    <script>
        function redirectToCoursesPage() {
            window.location.href = "courses.jsp";
        }
    </script>
</head>
<body>
    <h1>Remove Course</h1>
    <% 
        String courseId = request.getParameter("id");
        if (courseId != null) {
            CourseDAO courseDAO = new CourseDAO();
            boolean removed = courseDAO.removeCourse(courseId);
            if (removed) { %>
                <p>Course removed successfully.</p>
            <% } else { %>
                <p>Failed to remove course.</p>
            <% }
        } else { %>
            <p>No course ID provided.</p>
        <% } %>
    <br>
    <button onclick="redirectToCoursesPage()">Go back</button>
</body>
</html>

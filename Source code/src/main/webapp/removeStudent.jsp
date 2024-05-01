<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Controllers.StudentDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove Student</title>
    <script>
        function redirectToStudentsPage() {
            window.location.href = "students.jsp";
        }
    </script>
</head>
<body>
    <h1>Remove Student</h1>
    <% 
        String studentId = request.getParameter("id");
        if (studentId != null) {
            StudentDAO studentDAO = new StudentDAO();
            boolean removed = studentDAO.removeStudent(studentId);
            if (removed) { %>
                <p>Student removed successfully.</p>
            <% } else { %>
                <p>Failed to remove student.</p>
            <% }
        } else { %>
            <p>No student ID provided.</p>
        <% } %>
    <br>
    <button onclick="redirectToStudentsPage()">Go back</button>
</body>
</html>

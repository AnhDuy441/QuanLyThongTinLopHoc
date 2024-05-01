<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat, java.text.ParseException" %>
<%@ page import="Objects.Course" %>
<%@ page import="Controllers.CourseDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Course</title>
    <script>
        function redirectToCoursesPage() {
            window.location.href = "courses.jsp";
        }
    </script>
</head>
<body>
    <h1>Add Course</h1>
    <form action="addCourse.jsp" method="post">
        <label for="id">ID:</label><br>
        <input type="text" id="id" name="id" required><br>
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br>
        <label for="lecture">Lecture:</label><br>
        <input type="text" id="lecture" name="lecture" required><br>
        <label for="year">Year:</label><br>
        <input type="number" id="year" name="year" required><br>
        <label for="notes">Notes:</label><br>
        <textarea id="notes" name="notes"></textarea><br><br>
        <input type="submit" value="Add course">
    </form>
    <br>
    <button onclick="redirectToCoursesPage()">Go back</button>
    <% 
        if (request.getMethod().equals("POST")) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String lecture = request.getParameter("lecture");
            int year = Integer.parseInt(request.getParameter("year"));
            String notes = request.getParameter("notes");

            if (id != null && name != null && lecture != null) {
                Course course = new Course();
                course.setId(id);
                course.setName(name);
                course.setLecture(lecture);
                course.setYear(year);
                course.setNotes(notes);

                CourseDAO courseDAO = new CourseDAO();
                courseDAO.addCourse(course);
            }
        }
    %>
</body>
</html>

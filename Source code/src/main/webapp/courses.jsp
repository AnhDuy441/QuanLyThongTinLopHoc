<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Objects.Course" %>
<%@ page import="Controllers.CourseDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course List</title>
    <script>
	    function redirectToStudentsPage() {
	        window.location.href = "students.jsp";
	    }
        function redirectToAddCoursePage() {
            window.location.href = "addCourse.jsp";
        }
        function redirectToEditCoursePage(id) {
            window.location.href = "editCourse.jsp?id=" + id;
        }
        function redirectToRemoveCoursePage(id) {
            window.location.href = "removeCourse.jsp?id=" + id;
        }
        function viewCourseStudents(courseId) {
            window.location.href = "courseStudents.jsp?courseId=" + courseId;
        }
        function sortCoursesByName() {
            window.location.href = "courses.jsp?sort=name";
        }
        function searchCourses() {
            var name = document.getElementById("searchName").value;
            var year = document.getElementById("year").value;
            var searchUrl = "courses.jsp?";
            if (name !== "" && year !== "") {
                searchUrl += "search=" + name + "&year=" + year;
            } else if (name !== "") {
                searchUrl += "search=" + name;
            } else if (year !== "") {
                searchUrl += "year=" + year;
            }
            window.location.href = searchUrl;
        }
    </script>
</head>
<body>
	<button onclick="redirectToStudentsPage()">Student List</button>
	<br>
    <h1>Course List</h1>
    <div>
        <label for="searchName">Search by Name:</label>
        <input type="text" id="searchName" name="searchName">
        <label for="year">Search by Year:</label>
        <input type="text" id="year" name="year">
        <button onclick="searchCourses()">Search</button>
    </div>
    <br>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Lecture</th>
            <th>Year</th>
            <th>Notes</th>
            <th>Actions</th>
        </tr>
        <% 
           String sort = request.getParameter("sort");
           String searchName = request.getParameter("search");
           String searchYear = request.getParameter("year");
           CourseDAO courseDAO = new CourseDAO();
           List<Course> courses;
           if (sort != null && sort.equals("name")) {
               courses = courseDAO.sortCoursesByName();
           } else if (searchName != null && !searchName.isEmpty()) {
               if (searchYear != null && !searchYear.isEmpty()) {
                   courses = courseDAO.searchCourses(searchName, Integer.parseInt(searchYear));
               } else {
                   courses = courseDAO.searchCoursesByName(searchName);
               }
           } else if (searchYear != null && !searchYear.isEmpty()) {
               courses = courseDAO.searchCoursesByYear(Integer.parseInt(searchYear));
           } else {
               courses = courseDAO.getAllCourses();
           }
           for (Course course : courses) { %>
        <tr>
            <td><%= course.getId() %></td>
            <td><%= course.getName() %></td>
            <td><%= course.getLecture() %></td>
            <td><%= course.getYear() %></td>
            <td><%= course.getNotes() %></td>
            <td>
                <button onclick="viewCourseStudents('<%= course.getId() %>')">View Students</button>
                <button onclick="redirectToEditCoursePage('<%= course.getId() %>')">Edit</button>
                <button onclick="redirectToRemoveCoursePage('<%= course.getId() %>')">Remove</button>
            </td>
        </tr>
        <% } %>
    </table>
    <br>
    <button onclick="redirectToAddCoursePage()">Add course</button>
    <button onclick="sortCoursesByName()">Sort by Name</button>
</body>
</html>

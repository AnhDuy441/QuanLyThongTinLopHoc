<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Objects.Student" %>
<%@ page import="Controllers.StudentDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <script>
	    function redirectToCoursesPage() {
	        window.location.href = "courses.jsp";
	    }
        function redirectToAddStudentPage() {
            window.location.href = "addStudent.jsp";
        }
        function redirectToEditStudentsPage(id) {
            window.location.href = "editStudent.jsp?id=" + id;
        }
        function redirectToRemoveStudentsPage(id) {
            window.location.href = "removeStudent.jsp?id=" + id;
        }
        function sortStudentsByName() {
            window.location.href = "students.jsp?sort=name";
        }
        function searchStudentsByName() {
            var name = document.getElementById("searchName").value;
            window.location.href = "students.jsp?search=" + name;
        }
    </script>
</head>
<body>
	<button onclick="redirectToCoursesPage()">Course List</button>
	<br>
    <h1>Student List</h1>
    <div>
        <label for="searchName">Search by Name:</label>
        <input type="text" id="searchName" name="searchName">
        <button onclick="searchStudentsByName()">Search</button>
    </div>
    <br>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Birthday</th>
            <th>Address</th>
            <th>Notes</th>
            <th>Actions</th>
        </tr>
        <% 
           // Kiểm tra xem có yêu cầu sắp xếp không
           String sort = request.getParameter("sort");
           // Kiểm tra xem có yêu cầu tìm kiếm theo tên không
           String searchName = request.getParameter("search");
           StudentDAO studentDAO = new StudentDAO();
           List<Student> students;
           // Nếu có yêu cầu sắp xếp theo tên, thực hiện sắp xếp
           if (sort != null && sort.equals("name")) {
               students = studentDAO.sortStudentsByName();
           } else if (searchName != null && !searchName.isEmpty()) {
               // Nếu có yêu cầu tìm kiếm theo tên, thực hiện tìm kiếm
               students = studentDAO.searchStudentsByName(searchName);
           } else {
               // Nếu không có yêu cầu nào, lấy danh sách sinh viên theo thứ tự mặc định
               students = studentDAO.getAllStudents();
           }
           for (Student student : students) { %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getName() %></td>
            <td><%= student.getBirthday() %></td>
            <td><%= student.getAddress() %></td>
            <td><%= student.getNotes() %></td>
            <td>
                <button onclick="redirectToEditStudentsPage('<%= student.getId() %>')">Edit</button>
                <button onclick="redirectToRemoveStudentsPage('<%= student.getId() %>')">Remove</button>
            </td>
        </tr>
        <% } %>
    </table>
    <br>
    <button onclick="redirectToAddStudentPage()">Add student</button>
    <button onclick="sortStudentsByName()">Sort by Name</button>
</body>
</html>

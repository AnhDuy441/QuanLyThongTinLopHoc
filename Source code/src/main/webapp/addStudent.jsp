<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat, java.text.ParseException" %>
<%@ page import="Objects.Student" %>
<%@ page import="Controllers.StudentDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
    <script>
        function redirectToStudentsPage() {
            window.location.href = "students.jsp";
        }
    </script>
</head>
<body>
    <h1>Add Student</h1>
    <form action="addStudent.jsp" method="post">
        <label for="id">ID:</label><br>
        <input type="text" id="id" name="id" required><br>
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br>
        <label for="birthday">Birthday:</label><br>
        <input type="date" id="birthday" name="birthday" required><br>
        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" required><br>
        <label for="notes">Notes:</label><br>
        <textarea id="notes" name="notes"></textarea><br><br>
        <input type="submit" value="Add student">
    </form>
    <br>
    <button onclick="redirectToStudentsPage()">Go back</button>
    <% 
        if (request.getMethod().equals("POST")) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String birthdayStr = request.getParameter("birthday");
            Date birthday = null;
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    birthday = sdf.parse(birthdayStr);
                } catch (java.text.ParseException e) {
                    e.printStackTrace();
                }
            }
            String address = request.getParameter("address");
            String notes = request.getParameter("notes");

            if (id != null && name != null && birthday != null && address != null) {
                Student student = new Student();
                student.setId(id);
                student.setName(name);
                student.setBirthday(birthday);
                student.setAddress(address);
                student.setNotes(notes);

                StudentDAO studentDAO = new StudentDAO();
                studentDAO.addStudent(student);
            }
        }
    %>
</body>
</html>

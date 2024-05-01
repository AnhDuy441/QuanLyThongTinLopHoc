<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Objects.Student" %>
<%@ page import="Controllers.StudentDAO" %>

<%
    // Kiểm tra xem người dùng đã gửi dữ liệu hay chưa
    if (request.getMethod().equalsIgnoreCase("post")) {
        // Lấy thông tin sinh viên từ form
        String studentId = request.getParameter("id");
        String name = request.getParameter("name");
        String birthdayStr = request.getParameter("birthday");
        String address = request.getParameter("address");
        String notes = request.getParameter("notes");

        // Kiểm tra xem các trường không được để trống
        if (studentId != null && name != null && !name.isEmpty() && birthdayStr != null && !birthdayStr.isEmpty() && address != null && !address.isEmpty()) {
            try {
                // Chuyển đổi chuỗi ngày sinh thành đối tượng Date
                java.util.Date birthday = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr);

                // Tạo đối tượng sinh viên từ dữ liệu nhận được
                Student student = new Student();
                student.setId(studentId);
                student.setName(name);
                student.setBirthday(birthday);
                student.setAddress(address);
                student.setNotes(notes);

                // Cập nhật thông tin sinh viên trong cơ sở dữ liệu
                StudentDAO studentDAO = new StudentDAO();
                studentDAO.editStudent(student);

                // Chuyển hướng người dùng đến trang students.jsp sau khi cập nhật thành công
                response.sendRedirect("students.jsp");
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        } else {
            // Nếu các trường bắt buộc không được điền đầy đủ, hiển thị thông báo lỗi
            out.println("Please fill in all information.");
        }
    } else {
        // Nếu không có dữ liệu được gửi, hiển thị form để chỉnh sửa thông tin sinh viên
        String studentId = request.getParameter("id");
        if (studentId != null) {
            StudentDAO studentDAO = new StudentDAO();
            Student student = studentDAO.getStudentById(studentId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
</head>
<body>
    <h1>Edit Student</h1>
    <form action="editStudent.jsp" method="post">
        <input type="hidden" name="id" value="<%= student.getId() %>">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" value="<%= student.getName() %>"><br>
        <label for="birthday">Birthday:</label><br>
        <input type="date" id="birthday" name="birthday" value="<%= student.getBirthday() %>"><br>
        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" value="<%= student.getAddress() %>"><br>
        <label for="notes">Notes:</label><br>
        <textarea id="notes" name="notes"><%= student.getNotes() %></textarea><br><br>
        <input type="submit" value="Save">
    </form>
</body>
</html>
<%
        } else {
            // Nếu không có ID sinh viên được cung cấp, hiển thị thông báo lỗi
            out.println("No student ID provided.");
        }
    }
%>

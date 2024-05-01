<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Objects.Course" %>
<%@ page import="Controllers.CourseDAO" %>

<%
    // Kiểm tra xem người dùng đã gửi dữ liệu hay chưa
    if (request.getMethod().equalsIgnoreCase("post")) {
        // Lấy thông tin khóa học từ form
        String courseId = request.getParameter("id");
        String name = request.getParameter("name");
        String lecture = request.getParameter("lecture");
        int year = Integer.parseInt(request.getParameter("year"));
        String notes = request.getParameter("notes");

        // Kiểm tra xem các trường không được để trống
        if (courseId != null && name != null && !name.isEmpty() && lecture != null && !lecture.isEmpty()) {
            // Tạo đối tượng khóa học từ dữ liệu nhận được
            Course course = new Course();
            course.setId(courseId);
            course.setName(name);
            course.setLecture(lecture);
            course.setYear(year);
            course.setNotes(notes);

            // Cập nhật thông tin khóa học trong cơ sở dữ liệu
            CourseDAO courseDAO = new CourseDAO();
            courseDAO.editCourse(course);

            // Chuyển hướng người dùng đến trang courses.jsp sau khi cập nhật thành công
            response.sendRedirect("courses.jsp");
        } else {
            // Nếu các trường bắt buộc không được điền đầy đủ, hiển thị thông báo lỗi
            out.println("Please fill in all information.");
        }
    } else {
        // Nếu không có dữ liệu được gửi, hiển thị form để chỉnh sửa thông tin khóa học
        String courseId = request.getParameter("id");
        if (courseId != null) {
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseById(courseId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Course</title>
</head>
<body>
    <h1>Edit Course</h1>
    <form action="editCourse.jsp" method="post">
        <input type="hidden" name="id" value="<%= course.getId() %>">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" value="<%= course.getName() %>"><br>
        <label for="lecture">Lecture:</label><br>
        <input type="text" id="lecture" name="lecture" value="<%= course.getLecture() %>"><br>
        <label for="year">Year:</label><br>
        <input type="number" id="year" name="year" value="<%= course.getYear() %>"><br>
        <label for="notes">Notes:</label><br>
        <textarea id="notes" name="notes"><%= course.getNotes() %></textarea><br><br>
        <input type="submit" value="Save">
    </form>
</body>
</html>
<%
        } else {
            // Nếu không có ID khóa học được cung cấp, hiển thị thông báo lỗi
            out.println("No course ID provided.");
        }
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Students - Admin Console</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="flex-1 flex flex-col overflow-hidden">
            <!-- Top Header -->
            <header class="bg-white shadow-sm z-10">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
                    <h1 class="text-2xl font-semibold text-gray-900">Students for ${course.courseName}</h1>
                    <a href="${pageContext.request.contextPath}/admin/courses" class="text-blue-600 hover:text-blue-800">
                        <i class="fas fa-arrow-left mr-1"></i> Back to Courses
                    </a>
                </div>
            </header>
            
            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto bg-gray-100 p-4 sm:p-6 lg:p-8">
                <!-- Success Message -->
                <c:if test="${param.message == 'success'}">
                    <div class="mb-4 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md" role="alert">
                        <div class="flex">
                            <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                            <div>
                                <p class="font-medium">Student status updated successfully!</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${param.message == 'error' || param.message == 'invalidstatus'}">
                    <div class="mb-4 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded shadow-md" role="alert">
                        <div class="flex">
                            <div class="py-1"><i class="fas fa-exclamation-circle text-red-500 mr-3"></i></div>
                            <div>
                                <p class="font-medium">
                                    <c:choose>
                                        <c:when test="${param.message == 'invalidstatus'}">Invalid status provided.</c:when>
                                        <c:otherwise>An error occurred while updating student status.</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Course Info Card -->
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <img class="h-20 w-20 object-cover rounded-md" 
                                 src="${not empty course.courseImage ? course.courseImage : 'https://via.placeholder.com/150'}" 
                                 alt="${course.courseName}">
                        </div>
                        <div class="ml-6">
                            <h2 class="text-xl font-semibold text-gray-900">${course.courseName}</h2>
                            <p class="text-gray-600">${course.courseTitle}</p>
                            <div class="mt-2 flex items-center text-sm text-gray-500">
                                <i class="fas fa-users mr-1"></i>
                                <span>${students.size()} enrolled students</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Students Table -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h3 class="text-lg font-medium leading-6 text-gray-900">Enrolled Students</h3>
                        <p class="mt-1 text-sm text-gray-500">Manage students enrolled in this course</p>
                    </div>
                    
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Student
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Contact
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Student ID
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Enrollment Date
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Status
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:choose>
                                    <c:when test="${not empty students && students.size() > 0}">
                                        <c:forEach items="${students}" var="student">
                                            <tr>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <div class="flex items-center">
                                                        <div class="ml-4">
                                                            <div class="text-sm font-medium text-gray-900">
                                                                ${student.student.username}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <div class="text-sm text-gray-900">${student.student.email}</div>
                                                    <div class="text-sm text-gray-500">${student.student.phoneNumber}</div>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    ${student.student.studentID}
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <fmt:formatDate value="${student.enrollDate}" pattern="dd/MM/yyyy" />
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                                ${student.status == 'Active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                        ${student.status}
                                                    </span>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                    <form action="${pageContext.request.contextPath}/admin/update-student-status" method="post" class="inline">
                                                        <input type="hidden" name="studentId" value="${student.studentId}">
                                                        <input type="hidden" name="courseId" value="${course.id}">
                                                        <input type="hidden" name="status" value="${student.status == 'Active' ? 'Inactive' : 'Active'}">
                                                        <button type="submit" class="text-indigo-600 hover:text-indigo-900">
                                                            ${student.status == 'Active' ? 'Deactivate' : 'Activate'}
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="px-6 py-4 text-center text-sm text-gray-500">
                                                No students enrolled in this course yet.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
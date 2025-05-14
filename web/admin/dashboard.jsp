<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Course Management System</title>
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
                    <h1 class="text-2xl font-semibold text-gray-900">Dashboard</h1>
                    <div class="flex items-center">
                        <span class="text-gray-700 mr-2">Welcome, Admin</span>
                        <a href="${pageContext.request.contextPath}/logout" class="text-red-600 hover:text-red-800">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </div>
                </div>
            </header>
            
            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto bg-gray-100 p-4 sm:p-6 lg:p-8">
                <!-- Stats Cards -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                    <!-- Total Courses -->
                    <div class="bg-white rounded-lg shadow-md p-6 flex items-center">
                        <div class="rounded-full bg-blue-100 p-3 mr-4">
                            <i class="fas fa-book text-blue-600 text-xl"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Total Courses</p>
                            <p class="text-2xl font-semibold">${totalCourses}</p>
                        </div>
                    </div>
                    
                    <!-- Total Students -->
                    <div class="bg-white rounded-lg shadow-md p-6 flex items-center">
                        <div class="rounded-full bg-green-100 p-3 mr-4">
                            <i class="fas fa-user-graduate text-green-600 text-xl"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Total Students</p>
                            <p class="text-2xl font-semibold">${totalStudents}</p>
                        </div>
                    </div>
                    
                    <!-- Total Instructors -->
                    <div class="bg-white rounded-lg shadow-md p-6 flex items-center">
                        <div class="rounded-full bg-purple-100 p-3 mr-4">
                            <i class="fas fa-chalkboard-teacher text-purple-600 text-xl"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Total Instructors</p>
                            <p class="text-2xl font-semibold">${totalInstructors}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                    <h2 class="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h2>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <a href="${pageContext.request.contextPath}/admin/course-edit" class="flex items-center p-4 bg-blue-50 rounded-lg hover:bg-blue-100 transition duration-300">
                            <i class="fas fa-plus-circle text-blue-600 mr-3"></i>
                            <span>Add New Course</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/courses" class="flex items-center p-4 bg-green-50 rounded-lg hover:bg-green-100 transition duration-300">
                            <i class="fas fa-list text-green-600 mr-3"></i>
                            <span>Manage Courses</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users" class="flex items-center p-4 bg-purple-50 rounded-lg hover:bg-purple-100 transition duration-300">
                            <i class="fas fa-users text-purple-600 mr-3"></i>
                            <span>Manage Users</span>
                        </a>
                    </div>
                </div>
                
                <!-- Recent Activity -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h2 class="text-lg font-semibold text-gray-900 mb-4">Recent Activity</h2>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Action
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        User
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Date
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <!-- Sample activity data - in a real app, this would come from the database -->
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">New course created</div>
                                        <div class="text-sm text-gray-500">Java Programming Basics</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">Admin</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        Today, 10:30 AM
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">New student enrolled</div>
                                        <div class="text-sm text-gray-500">Data Science Fundamentals</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">John Doe</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        Yesterday, 3:45 PM
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">Course updated</div>
                                        <div class="text-sm text-gray-500">Web Design Essentials</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">Admin</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        2 days ago, 11:20 AM
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses - Course Management System</title>
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
        .gradient-text {
            background: linear-gradient(90deg, #3b82f6, #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="bg-gray-50">
    <jsp:include page="header.jsp" />

    <!-- Main Content -->
    <main class="pt-16">
        <!-- Page Header -->
        <div class="bg-gradient-to-r from-blue-600 to-indigo-700 text-white py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h1 class="text-3xl font-bold">Explore Our Courses</h1>
                <p class="mt-2 text-blue-100">Find the perfect course to enhance your skills</p>
            </div>
        </div>
        
        <!-- Course List with Sidebar -->
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="lg:flex lg:gap-8">
                <!-- Sidebar -->
                <div class="lg:w-1/4 mb-8 lg:mb-0">
                    <div class="bg-white p-6 rounded-xl shadow-md sticky top-24">
                        <h2 class="text-xl font-bold text-gray-900 mb-6">Filter Courses</h2>
                        
                        <!-- Search Form -->
                        <form action="courses" method="get" class="mb-6">
                            <div class="relative">
                                <input type="text" name="search" value="${searchQuery}" placeholder="Search courses..." 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                <button type="submit" class="absolute right-2 top-2 text-gray-500">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                        
                        <!-- Categories -->
                        <div>
                            <h3 class="font-semibold text-gray-900 mb-3">Categories</h3>
                            <ul class="space-y-2">
                                <li>
                                    <a href="courses" class="block text-gray-700 hover:text-blue-600 transition duration-300 ${empty selectedCategoryId ? 'font-semibold text-blue-600' : ''}">
                                        All Categories
                                    </a>
                                </li>
                                <c:forEach items="${categories}" var="category">
                                    <li>
                                        <a href="courses?category=${category.id}" 
                                           class="block text-gray-700 hover:text-blue-600 transition duration-300 ${selectedCategoryId == category.id ? 'font-semibold text-blue-600' : ''}">
                                            ${category.name}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        
                        <!-- Clear Filters -->
                        <div class="mt-6 pt-6 border-t border-gray-200">
                            <a href="courses" class="inline-flex items-center text-blue-600 hover:text-blue-800 transition duration-300">
                                <i class="fas fa-times-circle mr-2"></i> Clear All Filters
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Course Grid -->
                <div class="lg:w-3/4">
                    <c:choose>
                        <c:when test="${not empty courses && courses.size() > 0}">
                            <!-- Results Count -->
                            <div class="mb-6">
                                <p class="text-gray-600">Showing ${courses.size()} course(s)</p>
                            </div>
                            
                            <!-- Course Grid -->
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-8">
                                <c:forEach items="${courses}" var="course">
                                    <div class="bg-white rounded-xl overflow-hidden shadow-lg transition duration-500 hover:shadow-2xl">
                                        <div class="relative">
                                            <img src="${not empty course.courseImage ? course.courseImage : 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?ixlib=rb-4.0.3&auto=format&fit=crop&w=2128&q=80'}" 
                                                 alt="${course.courseName}" class="w-full h-48 object-cover">
                                            <c:if test="${not empty course.status}">
                                                <div class="absolute top-4 right-4 bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-full">
                                                    ${course.status}
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="p-6">
                                            <div class="flex justify-between items-center mb-4">
                                                <span class="text-xs font-semibold text-blue-600 bg-blue-100 px-3 py-1 rounded-full">
                                                    ${course.courseCategory.name}
                                                </span>
                                                <div class="flex items-center">
                                                    <i class="fas fa-calendar-alt text-gray-500 mr-1"></i>
                                                    <span class="text-sm text-gray-500">
                                                        <fmt:formatDate value="${course.startDate}" pattern="MMM dd, yyyy" />
                                                    </span>
                                                </div>
                                            </div>
                                            <h3 class="text-xl font-bold text-gray-900 mb-2">${course.courseName}</h3>
                                            <p class="text-gray-600 mb-4 text-sm">${course.courseDescription}</p>
                                            <div class="flex justify-between items-center">
                                                <a href="course-details?id=${course.id}" class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300 w-full text-center">
                                                    View Details
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- No Courses Found -->
                            <div class="bg-white p-8 rounded-xl shadow-md text-center">
                                <i class="fas fa-search text-gray-400 text-5xl mb-4"></i>
                                <h3 class="text-xl font-bold text-gray-900 mb-2">No courses found</h3>
                                <p class="text-gray-600 mb-6">We couldn't find any courses matching your criteria.</p>
                                <a href="courses" class="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 transition duration-300">
                                    View All Courses
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                <div>
                    <h3 class="text-xl font-bold mb-4">Course<span class="text-blue-400">Management</span></h3>
                    <p class="text-gray-400 mb-4">
                        Providing quality education and professional development opportunities for everyone.
                    </p>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
                    <ul class="space-y-2">
                        <li><a href="home" class="text-gray-400 hover:text-white transition duration-300">Home</a></li>
                        <li><a href="courses" class="text-gray-400 hover:text-white transition duration-300">Courses</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">About Us</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Contact</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">FAQ</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Course Categories</h3>
                    <ul class="space-y-2">
                        <c:forEach items="${categories}" var="category" begin="0" end="4">
                            <li><a href="courses?category=${category.id}" class="text-gray-400 hover:text-white transition duration-300">${category.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Contact Us</h3>
                    <ul class="space-y-2 text-gray-400">
                        <li class="flex items-start">
                            <i class="fas fa-map-marker-alt mt-1 mr-3"></i>
                            <span>123 Education St, Learning City, 10001</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fas fa-phone-alt mr-3"></i>
                            <span>+1 (123) 456-7890</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fas fa-envelope mr-3"></i>
                            <span>info@coursemanagement.com</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-gray-800 mt-12 pt-8 text-center text-gray-400">
                <p>&copy; 2023 Course Management System. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
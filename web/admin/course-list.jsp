<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Courses - Admin Console</title>
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
                        <h1 class="text-2xl font-semibold text-gray-900">Manage Courses</h1>
                        <a href="${pageContext.request.contextPath}/admin/course-edit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-plus mr-2"></i> Add New Course
                        </a>
                    </div>
                </header>

                <!-- Main Content -->
                <main class="flex-1 overflow-y-auto bg-gray-100 p-4 sm:p-6 lg:p-8">
                    <!-- Success/Error Messages -->
                    <c:if test="${param.message == 'success'}">
                        <div class="mb-4 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md" role="alert">
                            <div class="flex">
                                <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                                <div>
                                    <p class="font-medium">Course saved successfully!</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${param.message == 'deleted'}">
                        <div class="mb-4 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md" role="alert">
                            <div class="flex">
                                <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                                <div>
                                    <p class="font-medium">Course deleted successfully!</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${param.message == 'error'}">
                        <div class="mb-4 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded shadow-md" role="alert">
                            <div class="flex">
                                <div class="py-1"><i class="fas fa-exclamation-circle text-red-500 mr-3"></i></div>
                                <div>
                                    <p class="font-medium">An error occurred. Please try again.</p>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Filters and Search -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <div class="flex flex-col md:flex-row md:items-center md:justify-between space-y-4 md:space-y-0">
                            <div class="flex flex-col sm:flex-row sm:items-center space-y-4 sm:space-y-0 sm:space-x-4">
                                <!-- Search -->
                                <form action="${pageContext.request.contextPath}/admin/courses" method="get" class="flex-1">
                                    <div class="relative">
                                        <input type="text" name="search" value="${searchQuery}" placeholder="Search courses..." 
                                               class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <i class="fas fa-search text-gray-400"></i>
                                        </div>
                                        <button type="submit" class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                            <i class="fas fa-arrow-right text-gray-400 hover:text-blue-500"></i>
                                        </button>
                                    </div>
                                </form>

                                <!-- Category Filter -->
                                <form id="categoryForm" action="${pageContext.request.contextPath}/admin/courses" method="get">
                                    <select id="categoryFilter" name="category" onchange="document.getElementById('categoryForm').submit()" 
                                            class="w-full sm:w-48 border border-gray-300 rounded-md py-2 pl-3 pr-10 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">All Categories</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}" ${selectedCategoryId == category.id ? 'selected' : ''}>
                                                ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>

                            <!-- Clear Filters -->
                            <a href="${pageContext.request.contextPath}/admin/courses" class="text-blue-600 hover:text-blue-800">
                                <i class="fas fa-times-circle mr-1"></i> Clear Filters
                            </a>
                        </div>
                    </div>

                    <!-- Course Table -->
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Course
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Category
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Status
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Dates
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:choose>
                                        <c:when test="${not empty courses && courses.size() > 0}">
                                            <c:forEach items="${courses}" var="course">
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="flex items-center">
                                                            <div class="flex-shrink-0 h-10 w-10">
                                                                <img class="h-10 w-10 rounded-md object-cover" 
                                                                     src="${not empty course.courseImage ? course.courseImage : 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?ixlib=rb-4.0.3&auto=format&fit=crop&w=2128&q=80'}" 
                                                                     alt="${course.courseName}">
                                                            </div>
                                                            <div class="ml-4">
                                                                <div class="text-sm font-medium text-gray-900">
                                                                    ${course.courseName}
                                                                </div>
                                                                <div class="text-sm text-gray-500">
                                                                    ${course.courseTitle}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">${course.courseCategory.name}</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                                              ${course.status == 'Open' ? 'bg-green-100 text-green-800' : 
                                                                course.status == 'Closed' ? 'bg-red-100 text-red-800' : 
                                                                'bg-yellow-100 text-yellow-800'}">
                                                                  ${course.status}
                                                              </span>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            <div>
                                                                <span class="font-medium">Start:</span> 
                                                                <fmt:formatDate value="${course.startDate}" pattern="MMM dd, yyyy" />
                                                            </div>
                                                            <div>
                                                                <span class="font-medium">End:</span> 
                                                                <fmt:formatDate value="${course.endDate}" pattern="MMM dd, yyyy" />
                                                            </div>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                            <div class="flex justify-end space-x-2">
                                                                <a href="${pageContext.request.contextPath}/admin/course-students?courseId=${course.id}" class="text-indigo-600 hover:text-indigo-900 mr-3">
                                                                    <i class="fas fa-users mr-1"></i> Students
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/admin/course-edit?id=${course.id}" 
                                                                   class="text-blue-600 hover:text-blue-900" title="Edit">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <a href="#" onclick="confirmDelete(${course.id}, '${course.courseName}')" 
                                                                   class="text-red-600 hover:text-red-900" title="Delete">
                                                                    <i class="fas fa-trash-alt"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/course-detail?id=${course.id}" 
                                                                   class="text-gray-600 hover:text-gray-900" title="View" target="_blank">
                                                                    <i class="fas fa-external-link-alt"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" class="px-6 py-4 text-center text-gray-500">
                                                        No courses found. <a href="${pageContext.request.contextPath}/admin/course-edit" class="text-blue-600 hover:text-blue-800">Add a new course</a>.
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

            <!-- Delete Confirmation Modal -->
            <div id="deleteModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center z-50 hidden">
                <div class="bg-white rounded-lg p-8 max-w-md w-full">
                    <h3 class="text-xl font-bold text-gray-900 mb-4">Confirm Deletion</h3>
                    <p class="text-gray-600 mb-6">Are you sure you want to delete <span id="courseName" class="font-medium"></span>? This action cannot be undone.</p>
                    <div class="flex justify-end space-x-4">
                        <button onclick="closeModal()" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">
                            Cancel
                        </button>
                        <a id="deleteLink" href="#" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">
                            Delete
                        </a>
                    </div>
                </div>
            </div>

            <script>
                function filterByCategory(categoryId) {
                    // Debug log
                    console.log("Filter by category called with ID:", categoryId);

                    try {
                        // Get current URL and parameters
                        const url = new URL(window.location.href);
                        console.log("Current URL:", url.toString());

                        const params = new URLSearchParams(url.search);
                        console.log("Current params:", params.toString());

                        // Update or remove category parameter
                        if (categoryId) {
                            params.set('category', categoryId);
                        } else {
                            params.delete('category');
                        }

                        console.log("Updated params:", params.toString());

                        // Construct the new URL
                        const newUrl = `${url.pathname}?${params.toString()}`;
                                    console.log("Redirecting to:", newUrl);

                                    // Redirect to the new URL
                                    window.location.href = newUrl;
                                } catch (error) {
                                    console.error("Error in filterByCategory:", error);
                                }
                            }

                            function confirmDelete(courseId, courseName) {
                                document.getElementById('courseName').textContent = courseName;
                                document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/course-delete?id=' + courseId;
                                document.getElementById('deleteModal').classList.remove('hidden');
                            }

                            function closeModal() {
                                document.getElementById('deleteModal').classList.add('hidden');
                            }
            </script>
        </body>
    </html>
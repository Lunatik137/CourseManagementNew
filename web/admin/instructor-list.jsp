<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Instructors - Admin Console</title>
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
                    <h1 class="text-2xl font-semibold text-gray-900">Manage Instructors</h1>
                    <a href="${pageContext.request.contextPath}/admin/instructor-edit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <i class="fas fa-plus mr-2"></i> Add New Instructor
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
                                <p class="font-medium">Instructor saved successfully!</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${param.message == 'deleted'}">
                    <div class="mb-4 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md" role="alert">
                        <div class="flex">
                            <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                            <div>
                                <p class="font-medium">Instructor deleted successfully!</p>
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
                
                <!-- Search -->
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <form action="${pageContext.request.contextPath}/admin/instructors" method="get" class="flex flex-col sm:flex-row sm:items-center space-y-4 sm:space-y-0 sm:space-x-4">
                        <div class="flex-1">
                            <label for="search" class="sr-only">Search</label>
                            <div class="relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-search text-gray-400"></i>
                                </div>
                                <input type="text" name="search" id="search" value="${param.search}" 
                                       class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-12 py-2 sm:text-sm border-gray-300 rounded-md" 
                                       placeholder="Search instructors...">
                            </div>
                        </div>
                        <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            Search
                        </button>
                        <c:if test="${not empty param.search}">
                            <a href="${pageContext.request.contextPath}/admin/instructors" class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Clear
                            </a>
                        </c:if>
                    </form>
                </div>
                
                <!-- Instructors List -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Instructor
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Description
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:choose>
                                    <c:when test="${not empty instructors && instructors.size() > 0}">
                                        <c:forEach items="${instructors}" var="instructor">
                                            <tr>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <div class="flex items-center">
                                                        <div class="flex-shrink-0 h-10 w-10">
                                                            <img class="h-10 w-10 rounded-full object-cover" 
                                                                 src="${not empty instructor.image ? instructor.image : 'https://via.placeholder.com/150'}" 
                                                                 alt="${instructor.name}">
                                                        </div>
                                                        <div class="ml-4">
                                                            <div class="text-sm font-medium text-gray-900">
                                                                ${instructor.name}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <div class="text-sm text-gray-900 max-w-md truncate">
                                                        ${instructor.description}
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                    <div class="flex space-x-3">
                                                        <a href="${pageContext.request.contextPath}/admin/instructor-edit?id=${instructor.id}" 
                                                           class="text-blue-600 hover:text-blue-900" title="Edit">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="javascript:void(0)" onclick="confirmDelete(${instructor.id}, '${instructor.name}')" 
                                                           class="text-red-600 hover:text-red-900" title="Delete">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="3" class="px-6 py-4 text-center text-gray-500">
                                                No instructors found. <a href="${pageContext.request.contextPath}/admin/instructor-edit" class="text-blue-600 hover:text-blue-800">Add a new instructor</a>.
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
            <p class="text-gray-600 mb-6">Are you sure you want to delete <span id="instructorName" class="font-medium"></span>? This action cannot be undone.</p>
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
        function confirmDelete(instructorId, instructorName) {
            document.getElementById('instructorName').textContent = instructorName;
            document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/instructor-delete?id=' + instructorId;
            document.getElementById('deleteModal').classList.remove('hidden');
        }
        
        function closeModal() {
            document.getElementById('deleteModal').classList.add('hidden');
        }
        
        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target === modal) {
                closeModal();
            }
        });
    </script>
</body>
</html>
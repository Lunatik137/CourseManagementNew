<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${mode == 'edit' ? 'Edit' : 'Add'} Instructor - Admin Console</title>
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
                    <h1 class="text-2xl font-semibold text-gray-900">${mode == 'edit' ? 'Edit' : 'Add'} Instructor</h1>
                    <a href="${pageContext.request.contextPath}/admin/instructors" class="text-blue-600 hover:text-blue-800">
                        <i class="fas fa-arrow-left mr-1"></i> Back to Instructors
                    </a>
                </div>
            </header>
            
            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto bg-gray-100 p-4 sm:p-6 lg:p-8">
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="mb-4 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded shadow-md" role="alert">
                        <div class="flex">
                            <div class="py-1"><i class="fas fa-exclamation-circle text-red-500 mr-3"></i></div>
                            <div>
                                <p class="font-medium">${errorMessage}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Instructor Form -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <form action="${pageContext.request.contextPath}/admin/instructor-edit" method="post" class="p-6">
                        <c:if test="${mode == 'edit'}">
                            <input type="hidden" name="id" value="${instructor.id}">
                        </c:if>
                        
                        <div class="grid grid-cols-1 gap-6">
                            <div>
                                <label for="name" class="block text-sm font-medium text-gray-700">Name *</label>
                                <input type="text" id="name" name="name" value="${instructor.name}" required
                                       class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            
                            <div>
                                <label for="imageUrl" class="block text-sm font-medium text-gray-700">Profile Image URL</label>
                                <input type="text" id="imageUrl" name="imageUrl" value="${instructor.image}"
                                       placeholder="https://example.com/profile.jpg"
                                       class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                <p class="mt-1 text-sm text-gray-500">
                                    Enter a URL for the instructor's profile image
                                </p>
                                <c:if test="${not empty instructor.image}">
                                    <div class="mt-2">
                                        <img src="${instructor.image}" alt="Instructor profile" class="h-32 w-32 object-cover rounded-full">
                                    </div>
                                </c:if>
                            </div>
                            
                            <div>
                                <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                                <textarea id="description" name="description" rows="4"
                                          class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">${instructor.description}</textarea>
                                <p class="mt-1 text-sm text-gray-500">
                                    Provide a brief description of the instructor's background, expertise, and teaching experience.
                                </p>
                            </div>
                        </div>
                        
                        <div class="mt-6 flex justify-end">
                            <a href="${pageContext.request.contextPath}/admin/instructors" class="mr-4 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Cancel
                            </a>
                            <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                ${mode == 'edit' ? 'Update' : 'Create'} Instructor
                            </button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
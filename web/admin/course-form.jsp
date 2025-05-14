<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${mode == 'edit' ? 'Edit' : 'Add'} Course - Admin Console</title>
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
                        <h1 class="text-2xl font-semibold text-gray-900">${mode == 'edit' ? 'Edit' : 'Add'} Course</h1>
                        <a href="${pageContext.request.contextPath}/admin/courses" class="text-blue-600 hover:text-blue-800">
                            <i class="fas fa-arrow-left mr-1"></i> Back to Courses
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

                    <!-- Course Form -->
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <form action="${pageContext.request.contextPath}/admin/course-edit" method="post" enctype="multipart/form-data" class="p-6">
                            <c:if test="${mode == 'edit'}">
                                <input type="hidden" name="id" value="${course.id}">
                            </c:if>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Left Column -->
                                <div class="space-y-6">
                                    <div>
                                        <label for="courseName" class="block text-sm font-medium text-gray-700">Course Name *</label>
                                        <input type="text" id="courseName" name="courseName" value="${course.courseName}" required
                                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                    </div>

                                    <div>
                                        <label for="courseTitle" class="block text-sm font-medium text-gray-700">Course Title *</label>
                                        <input type="text" id="courseTitle" name="courseTitle" value="${course.courseTitle}" required
                                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                    </div>

                                    <div>
                                        <label for="courseDescription" class="block text-sm font-medium text-gray-700">Description *</label>
                                        <textarea id="courseDescription" name="courseDescription" rows="4" required
                                                  class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">${course.courseDescription}</textarea>
                                    </div>

                                    <div>
                                        <label for="requirements" class="block text-sm font-medium text-gray-700">Requirements</label>
                                        <textarea id="requirements" name="requirements" rows="4"
                                                  class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">${course.requirements}</textarea>
                                    </div>

                                    
                                    <div>
                                        <label for="courseImageUrl" class="block text-sm font-medium text-gray-700">Course Image URL</label>
                                        <input type="text" id="courseImageUrl" name="courseImageUrl" value="${course.courseImage}"
                                               placeholder="https://example.com/image.jpg"
                                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                        <p class="mt-1 text-sm text-gray-500">
                                            Enter a URL for the course image
                                        </p>
                                        <c:if test="${not empty course.courseImage}">
                                            <div class="mt-2">
                                                <img src="${course.courseImage}" alt="Course image preview" class="h-32 w-auto object-cover rounded-md">
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Right Column -->
                                <div class="space-y-6">
                                    <div>
                                        <label for="category" class="block text-sm font-medium text-gray-700">Category *</label>
                                        <select id="category" name="category" required
                                                class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                            <option value="">Select a category</option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.id}" ${course.courseCategoryId == category.id ? 'selected' : ''}>${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div>
                                        <label for="instructor" class="block text-sm font-medium text-gray-700">Instructor</label>
                                        <select id="instructor" name="instructor"
                                                class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                            <option value="">Select an instructor</option>
                                            <c:forEach items="${instructors}" var="instructor">
                                                <option value="${instructor.id}" ${course.instructor != null && course.instructor.id == instructor.id ? 'selected' : ''}>${instructor.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div>
                                        <label for="startDate" class="block text-sm font-medium text-gray-700">Start Date</label>
                                        <input type="date" id="startDate" name="startDate" 
                                               value="<fmt:formatDate value="${course.startDate}" pattern="yyyy-MM-dd" />"

                                               ## Tiếp tục trang admin/course-form.jsp

                                               ```jsp
                                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                    </div>

                                    <div>
                                        <label for="endDate" class="block text-sm font-medium text-gray-700">End Date</label>
                                        <input type="date" id="endDate" name="endDate" 
                                               value="<fmt:formatDate value="${course.endDate}" pattern="yyyy-MM-dd" />"
                                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                    </div>

                                    <div>
                                        <label for="status" class="block text-sm font-medium text-gray-700">Status *</label>
                                        <select id="status" name="status" required
                                                class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                            <option value="Active" ${course.status == 'Active' ? 'selected' : ''}>Open</option>
                                            <option value="Inactive" ${course.status == 'Inactive' ? 'selected' : ''}>Closed</option>
                                            
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">Learning Outcomes</label>
                                        <div id="learningOutcomes" class="space-y-2">
                                            <c:choose>
                                                <c:when test="${not empty course.learningOutcomes}">
                                                    <c:forEach items="${course.learningOutcomes}" var="outcome" varStatus="status">
                                                        <div class="flex items-center">
                                                            <input type="text" name="learningOutcomes" value="${outcome}" 
                                                                   class="flex-1 border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                                            <button type="button" onclick="removeOutcome(this)" class="ml-2 text-red-600 hover:text-red-800">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="flex items-center">
                                                        <input type="text" name="learningOutcomes" 
                                                               class="flex-1 border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                                        <button type="button" onclick="removeOutcome(this)" class="ml-2 text-red-600 hover:text-red-800">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <button type="button" onclick="addOutcome()" class="mt-2 inline-flex items-center px-3 py-1 border border-transparent text-sm leading-4 font-medium rounded-md text-blue-700 bg-blue-100 hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                            <i class="fas fa-plus mr-1"></i> Add Outcome
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-8 flex justify-end">
                                <a href="${pageContext.request.contextPath}/admin/courses" class="mr-4 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    Cancel
                                </a>
                                <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    ${mode == 'edit' ? 'Update' : 'Create'} Course
                                </button>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>

        <script>
            function addOutcome() {
                const container = document.getElementById('learningOutcomes');
                const newOutcome = document.createElement('div');
                newOutcome.className = 'flex items-center';
                newOutcome.innerHTML = `
                    <input type="text" name="learningOutcomes" 
                           class="flex-1 border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    <button type="button" onclick="removeOutcome(this)" class="ml-2 text-red-600 hover:text-red-800">
                        <i class="fas fa-times"></i>
                    </button>
                `;
                container.appendChild(newOutcome);
            }

            function removeOutcome(button) {
                const container = document.getElementById('learningOutcomes');
                const outcomeDiv = button.parentNode;

                // Don't remove if it's the last one
                if (container.children.length > 1) {
                    container.removeChild(outcomeDiv);
                } else {
                    // Clear the input instead
                    outcomeDiv.querySelector('input').value = '';
                }
            }
        </script>
    </body>
</html>


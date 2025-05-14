<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Courses - Course Management System</title>
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
        <!-- Include Header -->
        <jsp:include page="header.jsp" />

        <!-- Main Content -->
        <main class="pt-16">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                <div class="text-center mb-12">
                    <h1 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        My <span class="gradient-text">Courses</span>
                    </h1>
                    <p class="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
                        Manage your enrolled courses and track your learning progress
                    </p>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.unenrollMessage}">
                    <div id="unenrollMessage" class="mb-8 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md" role="alert">
                        <div class="flex">
                            <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                            <div>
                                <p class="font-medium">${sessionScope.unenrollMessage}</p>
                            </div>
                            <button onclick="this.parentElement.parentElement.style.display = 'none'" class="ml-auto">
                                <i class="fas fa-times text-green-700"></i>
                            </button>
                        </div>
                    </div>
                    <c:remove var="unenrollMessage" scope="session" />
                </c:if>
                <!-- Ban Message -->
                <c:if test="${not empty banMessage}">
                    <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded shadow-md" role="alert">
                        <div class="flex">
                            <div class="py-1"><i class="fas fa-ban text-red-500 mr-3"></i></div>
                            <div>
                                <p class="font-bold">Access Restricted</p>
                                <p>${banMessage}</p>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Course List -->
                <div class="mt-8">
                    <c:choose>
                        <c:when test="${empty enrollments}">
                            <div class="text-center py-12 bg-white rounded-lg shadow-md">
                                <i class="fas fa-book-open text-5xl text-gray-300 mb-4"></i>
                                <h3 class="text-xl font-medium text-gray-900 mb-2">No courses yet</h3>
                                <p class="text-gray-500 mb-6">You haven't enrolled in any courses yet.</p>
                                <a href="courses" class="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700">
                                    Browse Courses
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Course Grid -->
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                                <c:forEach items="${enrollments}" var="enrollment">
                                    <div class="bg-white rounded-xl overflow-hidden shadow-lg transition duration-500 hover:shadow-2xl">
                                        <div class="relative">
                                            <img src="${not empty enrollment.course.courseImage ? enrollment.course.courseImage : 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?ixlib=rb-4.0.3&auto=format&fit=crop&w=2128&q=80'}" 
                                                 alt="${enrollment.course.courseName}" class="w-full h-48 object-cover">
                                            <div class="absolute top-4 right-4 bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-full">
                                                ${enrollment.course.status}
                                            </div>
                                            <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black to-transparent p-4">
                                                <h3 class="text-white font-bold text-lg">${enrollment.course.courseName}</h3>
                                                <p class="text-gray-200 text-sm">${enrollment.course.courseTitle}</p>
                                            </div>
                                        </div>
                                        <div class="p-6">
                                            <div class="flex items-center mb-4">
                                                <c:if test="${not empty enrollment.course.instructor}">
                                                    <img src="${not empty enrollment.course.instructor.image ? enrollment.course.instructor.image : 'https://ui-avatars.com/api/?name=Instructor&background=random'}" 
                                                         alt="${enrollment.course.instructor.name}" class="w-10 h-10 rounded-full mr-3">
                                                    <span class="text-gray-700">${enrollment.course.instructor.name}</span>
                                                </c:if>
                                                <c:if test="${empty enrollment.course.instructor}">
                                                    <img src="https://ui-avatars.com/api/?name=Instructor&background=random" 
                                                         alt="Instructor" class="w-10 h-10 rounded-full mr-3">
                                                    <span class="text-gray-700">Instructor</span>
                                                </c:if>
                                            </div>

                                            <div class="mb-4">
                                                <p class="text-gray-600 text-sm mb-2">
                                                    <i class="far fa-calendar-alt mr-2"></i> 
                                                    <fmt:formatDate value="${enrollment.course.startDate}" pattern="MMM dd, yyyy" /> - 
                                                    <fmt:formatDate value="${enrollment.course.endDate}" pattern="MMM dd, yyyy" />
                                                </p>
                                                <p class="text-gray-600 text-sm">
                                                    <i class="far fa-clock mr-2"></i> Enrolled on: 
                                                    <fmt:formatDate value="${enrollment.enrollDate}" pattern="MMM dd, yyyy" />
                                                </p>
                                            </div>
                                            <!-- Course actions -->
                                            <div class="mt-4">
                                                <c:choose>
                                                    <c:when test="${enrollment.status == 'Active'}">
                                                        <div class="flex justify-between items-center mt-6">
                                                            <a href="course-details?id=${enrollment.courseId}" class="text-blue-600 hover:text-blue-800 font-medium">
                                                                View Course
                                                            </a>
                                                            <button onclick="confirmUnenroll(${enrollment.courseId}, '${enrollment.course.courseName}')" 
                                                                    class="text-red-600 hover:text-red-800">
                                                                <i class="fas fa-times-circle mr-1"></i> Unenroll
                                                            </button>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button disabled class="bg-gray-300 text-gray-500 px-4 py-2 rounded cursor-not-allowed">
                                                            Access Restricted
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>


                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>

        <!-- Include Footer -->
        <jsp:include page="footer.jsp" />

        <!-- Unenroll Confirmation Modal -->
        <div id="unenrollModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-lg p-8 max-w-md w-full">
                <h3 class="text-xl font-bold text-gray-900 mb-4">Confirm Unenrollment</h3>
                <p class="text-gray-600 mb-6">Are you sure you want to unenroll from <span id="courseName" class="font-medium"></span>? This action cannot be undone.</p>
                <div class="flex justify-end space-x-4">
                    <button onclick="closeModal()" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">
                        Cancel
                    </button>
                    <a id="unenrollLink" href="#" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">
                        Unenroll
                    </a>
                </div>
            </div>
        </div>

        <script>
            function confirmUnenroll(courseId, courseName) {
                document.getElementById('courseName').textContent = courseName;
                document.getElementById('unenrollLink').href = 'unenroll?courseId=' + courseId;
                document.getElementById('unenrollModal').classList.remove('hidden');
            }

            function closeModal() {
                document.getElementById('unenrollModal').classList.add('hidden');
            }

            // Close modal when clicking outside
            window.addEventListener('click', function (event) {
                const modal = document.getElementById('unenrollModal');
                if (event.target === modal) {
                    closeModal();
                }
            });

            // Auto-hide messages after 5 seconds
            setTimeout(function () {
                const message = document.getElementById('unenrollMessage');
                if (message) {
                    message.style.display = 'none';
                }
            }, 5000);
        </script>
    </body>
</html>
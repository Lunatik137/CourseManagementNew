<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${course.courseName} - Course Management System</title>
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
        <main>
            <!-- Enrollment Success Message -->
            <c:if test="${not empty sessionScope.enrollMessage}">
                <div id="enrollMessage" class="fixed top-20 right-4 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 z-50 shadow-md" role="alert">
                    <p>${sessionScope.enrollMessage}</p>
                    <button onclick="this.parentElement.style.display = 'none'" class="absolute top-2 right-2 text-green-700">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <c:remove var="enrollMessage" scope="session" />
            </c:if>
            <!-- Ban Message -->
            <c:if test="${isBanned}">
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

            <div class="pt-16 pb-12">
                <!-- Course Header -->
                <div class="bg-gradient-to-r from-blue-600 to-indigo-700 text-white py-16">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="lg:flex lg:items-center lg:justify-between">
                            <div class="lg:w-2/3">
                                <div class="flex items-center mb-4">
                                    <span class="bg-white text-blue-600 text-xs font-semibold px-3 py-1 rounded-full mr-3">
                                        ${course.courseCategory.name}
                                    </span>
                                    <c:if test="${not empty course.status}">
                                        <span class="bg-blue-500 text-white text-xs font-semibold px-3 py-1 rounded-full">
                                            ${course.status}
                                        </span>
                                    </c:if>
                                </div>
                                <h1 class="text-3xl md:text-4xl font-bold mb-4">${course.courseName}</h1>
                                <p class="text-lg text-blue-100 mb-6">${course.courseTitle}</p>

                                <div class="flex flex-wrap items-center text-sm">
                                    <div class="flex items-center mr-6 mb-2">
                                        <i class="far fa-calendar-alt mr-2"></i>
                                        <span>Start Date: <fmt:formatDate value="${course.startDate}" pattern="MMM dd, yyyy" /></span>
                                    </div>
                                    <div class="flex items-center mr-6 mb-2">
                                        <i class="far fa-calendar-check mr-2"></i>
                                        <span>End Date: <fmt:formatDate value="${course.endDate}" pattern="MMM dd, yyyy" /></span>
                                    </div>
                                    <c:if test="${not empty course.instructor}">
                                        <div class="flex items-center mb-2">
                                            <i class="fas fa-chalkboard-teacher mr-2"></i>
                                            <span>Instructor: ${course.instructor.name}</span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="lg:w-1/3 mt-6 lg:mt-0">
                                <img src="${not empty course.courseImage ? course.courseImage : 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?ixlib=rb-4.0.3&auto=format&fit=crop&w=2128&q=80'}" 
                                     alt="${course.courseName}" class="w-full h-48 object-cover rounded-lg shadow-lg">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course Content -->
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                    <div class="lg:flex lg:gap-8">
                        <!-- Main Content -->
                        <div class="lg:w-2/3">
                            <!-- Course Description -->
                            <div class="bg-white p-6 rounded-xl shadow-md mb-8">
                                <h2 class="text-2xl font-bold text-gray-900 mb-4">Course Description</h2>
                                <p class="text-gray-700 mb-0">${course.courseDescription}</p>
                            </div>

                            <!-- What You'll Learn -->
                            <div class="bg-white p-6 rounded-xl shadow-md mb-8">
                                <h2 class="text-2xl font-bold text-gray-900 mb-4">What You'll Learn</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <c:choose>
                                        <c:when test="${not empty course.learningOutcomes && course.learningOutcomes.size() > 0}">
                                            <c:forEach items="${course.learningOutcomes}" var="outcome">
                                                <div class="flex items-start">
                                                    <i class="fas fa-check text-green-500 mt-1 mr-3"></i>
                                                    <span>${outcome}</span>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="flex items-start">
                                                <i class="fas fa-check text-green-500 mt-1 mr-3"></i>
                                                <span>No learning outcomes specified for this course yet.</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Requirements -->
                            <div class="bg-white p-6 rounded-xl shadow-md mb-8">
                                <h2 class="text-2xl font-bold text-gray-900 mb-4">Requirements</h2>
                                <div class="flex items-start">
                                    <i class="fas fa-info-circle text-blue-500 mt-1 mr-3"></i>
                                    <span>${not empty course.requirements ? course.requirements : 'No specific requirements for this course.'}</span>
                                </div>
                            </div>



                            <!-- Instructor -->
                            <div class="bg-white p-6 rounded-xl shadow-md mb-8">
                                <h2 class="text-2xl font-bold text-gray-900 mb-4">Your Instructor</h2>

                                <c:choose>
                                    <c:when test="${not empty course.instructor}">
                                        <div class="flex flex-col md:flex-row items-start">
                                            <div class="flex-shrink-0 mb-4 md:mb-0 md:mr-6">
                                                <img src="${not empty course.instructor.image ? course.instructor.image : 'https://ui-avatars.com/api/?name=Instructor&size=128&background=random'}" 
                                                     alt="${course.instructor.name}" class="w-24 h-24 rounded-full object-cover">
                                            </div>
                                            <div>
                                                <h3 class="text-xl font-semibold text-gray-900 mb-2">${course.instructor.name}</h3>
                                                <p class="text-gray-700">${course.instructor.description}</p>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="flex flex-col md:flex-row items-start">
                                            <div class="flex-shrink-0 mb-4 md:mb-0 md:mr-6">
                                                <img src="https://ui-avatars.com/api/?name=Instructor&size=128&background=random" 
                                                     alt="Instructor" class="w-24 h-24 rounded-full object-cover">
                                            </div>
                                            <div>
                                                <h3 class="text-xl font-semibold text-gray-900 mb-2">Course Instructor</h3>
                                                <p class="text-gray-700">Information about the instructor is not available.</p>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Sidebar -->
                        <div class="lg:w-1/3 mt-8 lg:mt-0">
                            <div class="bg-white p-6 rounded-xl shadow-md sticky top-24">
                                <div class="mb-6">
                                    <div class="mt-4">
                                        <c:choose>
                                            <c:when test="${isEnrolled}">
                                                <c:choose>
                                                    <c:when test="${isBanned}">
                                                        <!-- Người dùng đã bị ban khỏi khóa học này -->
                                                        <button disabled class="w-full bg-gray-300 text-gray-500 py-3 rounded-lg font-medium mb-4 flex items-center justify-center">
                                                            <i class="fas fa-ban mr-2"></i> Access Restricted
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Người dùng đã đăng ký và không bị ban -->
                                                        <button class="w-full bg-green-600 text-white py-3 rounded-lg font-medium mb-4 flex items-center justify-center" disabled>
                                                            <i class="fas fa-check-circle mr-2"></i> Enrolled
                                                        </button>
                                                        <a href="#" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg font-medium mb-4 flex items-center justify-center transition duration-300">
                                                            <i class="fas fa-play-circle mr-2"></i> Continue Learning
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Người dùng chưa đăng ký khóa học này -->
                                                <a href="enroll?courseId=${course.id}" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg font-medium mb-4 flex items-center justify-center transition duration-300">
                                                    <i class="fas fa-graduation-cap mr-2"></i> Enroll Now
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>



                                </div>




                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Related Courses -->
            <div class="bg-gray-50 py-16">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <h2 class="text-3xl font-bold text-gray-900 mb-12 text-center">Related <span class="gradient-text">Courses</span></h2>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                        <c:choose>
                            <c:when test="${not empty relatedCourses && relatedCourses.size() > 0}">
                                <c:forEach items="${relatedCourses}" var="relatedCourse">
                                    <div class="bg-white rounded-xl overflow-hidden shadow-lg transition duration-500 hover:shadow-2xl">
                                        <div class="relative">
                                            <img src="${not empty relatedCourse.courseImage ? relatedCourse.courseImage : 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?ixlib=rb-4.0.3&auto=format&fit=crop&w=2128&q=80'}" 
                                                 alt="${relatedCourse.courseName}" class="w-full h-48 object-cover">
                                        </div>
                                        <div class="p-6">
                                            <div class="flex justify-between items-center mb-4">
                                                <span class="text-xs font-semibold text-blue-600 bg-blue-100 px-3 py-1 rounded-full">
                                                    ${relatedCourse.courseCategory.name}
                                                </span>
                                                <div class="flex items-center">
                                                    <i class="fas fa-star text-yellow-400 mr-1"></i>
                                                    <span class="text-sm font-medium">4.8</span>
                                                </div>
                                            </div>
                                            <h3 class="text-xl font-bold text-gray-900 mb-2">${relatedCourse.courseName}</h3>
                                            <p class="text-gray-600 mb-4 text-sm">${relatedCourse.courseDescription}</p>
                                            <div class="flex justify-between items-center">
                                                <span class="text-lg font-bold text-blue-600">$89.99</span>
                                                <a href="course-details?id=${relatedCourse.id}" class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300">
                                                    View Details
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Placeholder courses if no related courses found -->
                                <div class="col-span-1 md:col-span-2 lg:col-span-3 flex justify-center items-center text-gray-500 text-lg font-medium">
                                    No Related Course Found
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
                            <li><a href="courses" class="text-gray-400 hover:text-white transition duration-300">Courses</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">About Us</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Contact</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">FAQ</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="text-lg font-semibold mb-4">Course Categories</h3>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Web Development</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Data Science</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Mobile Development</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">UI/UX Design</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Business</a></li>
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

        <!-- JavaScript for Course Content Accordion -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Get all accordion headers
                const accordionHeaders = document.querySelectorAll('.bg-gray-50.p-4.flex.justify-between.items-center.cursor-pointer');

                // Add click event to each header
                accordionHeaders.forEach(header => {
                    header.addEventListener('click', function () {
                        // Toggle the content visibility
                        const content = this.nextElementSibling;
                        content.classList.toggle('hidden');

                        // Toggle the icon
                        const icon = this.querySelector('.fas');
                        if (content.classList.contains('hidden')) {
                            icon.classList.remove('fa-chevron-up');
                            icon.classList.add('fa-chevron-down');
                        } else {
                            icon.classList.remove('fa-chevron-down');
                            icon.classList.add('fa-chevron-up');
                        }
                    });
                });

                // Open the first accordion by default
                if (accordionHeaders.length > 0) {
                    const firstContent = accordionHeaders[0].nextElementSibling;
                    firstContent.classList.remove('hidden');
                    const firstIcon = accordionHeaders[0].querySelector('.fas');
                    firstIcon.classList.remove('fa-chevron-down');
                    firstIcon.classList.add('fa-chevron-up');
                }

                // Auto-hide enrollment message after 5 seconds
                const enrollMessage = document.getElementById('enrollMessage');
                if (enrollMessage) {
                    setTimeout(() => {
                        enrollMessage.style.display = 'none';
                    }, 5000);
                }
            });
        </script>
    </body>
</html>
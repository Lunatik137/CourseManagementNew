<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Course Management System</title>
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
            .banner-image {
                background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://demoxml.com/html/edumax/DEMO/images/photoslider1.jpg');
                background-size: cover;
                background-position: center;
                height: 600px;
            }
            .feature-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
            .gradient-text {
                background: linear-gradient(90deg, #3b82f6, #8b5cf6);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .category-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }
        </style>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="header.jsp" />

        <!-- Hero Banner Section -->
        <div class="banner-image flex items-center justify-center">
            <div class="text-center px-4 sm:px-6 lg:px-8">
                <h1 class="text-4xl sm:text-5xl md:text-6xl font-extrabold text-white mb-6 leading-tight">
                    Discover Your <span class="text-blue-400">Learning</span> Journey
                </h1>
                <p class="text-xl md:text-2xl text-gray-200 mb-10 max-w-3xl mx-auto">
                    Explore our wide range of courses designed to help you achieve your academic and professional goals.
                </p>
                <div class="flex flex-col sm:flex-row justify-center gap-4">
                    <button class="bg-blue-600 hover:bg-blue-700 text-white px-8 py-4 rounded-md text-lg font-medium transition duration-300 transform hover:scale-105">
                        Explore Courses
                    </button>
                    <button class="bg-transparent border-2 border-white text-white hover:bg-white hover:text-blue-600 px-8 py-4 rounded-md text-lg font-medium transition duration-300 transform hover:scale-105">
                        Learn More
                    </button>
                </div>
            </div>
        </div>

        <!-- Top Categories Section -->
        <div class="py-16 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Top <span class="gradient-text">Categories</span>
                    </h2>
                    <p class="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
                        Browse our most popular course categories and find the right path for you.
                    </p>
                </div>
                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
                    <!-- Using JSTL to display top categories -->
                    <c:choose>
                        <c:when test="${not empty topCategories}">
                            <c:forEach items="${topCategories}" var="category">
                                <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                    <div class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                        <i class="fas fa-book text-indigo-600 text-2xl"></i>
                                    </div>
                                    <h3 class="font-bold text-gray-900">${category.name}</h3>
                                    <a href="courses?category=${category.id}" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Default categories if none are found in the database -->
                            <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                <div class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-laptop-code text-indigo-600 text-2xl"></i>
                                </div>
                                <h3 class="font-bold text-gray-900">Web Development</h3>
                                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                            </div>

                            <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-chart-line text-purple-600 text-2xl"></i>
                                </div>
                                <h3 class="font-bold text-gray-900">Data Science</h3>
                                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                            </div>

                            <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-mobile-alt text-blue-600 text-2xl"></i>
                                </div>
                                <h3 class="font-bold text-gray-900">Mobile Development</h3>
                                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                            </div>

                            <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-paint-brush text-green-600 text-2xl"></i>
                                </div>
                                <h3 class="font-bold text-gray-900">UI/UX Design</h3>
                                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                            </div>

                            <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-briefcase text-red-600 text-2xl"></i>
                                </div>
                                <h3 class="font-bold text-gray-900">Business</h3>
                                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                            </div>

                            <div class="bg-white p-6 rounded-xl shadow-md text-center transition duration-300 category-card border border-gray-100">
                                <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-language text-yellow-600 text-2xl"></i>
                                </div>
                                <h3 class="font-bold text-gray-900">Languages</h3>
                                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:underline">View Courses</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Features Section -->
        <div class="py-16 bg-gray-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Why Choose <span class="gradient-text">Our Platform</span>
                    </h2>
                    <p class="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
                        We provide a comprehensive learning experience with features designed to help you succeed.
                    </p>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- Feature 1 -->
                    <div class="bg-white p-8 rounded-xl shadow-lg transition duration-500 feature-card border border-gray-100">
                        <div class="w-14 h-14 bg-blue-100 rounded-full flex items-center justify-center mb-6">
                            <i class="fas fa-laptop-code text-blue-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-3">Expert Instructors</h3>
                        <p class="text-gray-600">Learn from industry professionals with years of experience in their respective fields.</p>
                    </div>

                    <!-- Feature 2 -->
                    <div class="bg-white p-8 rounded-xl shadow-lg transition duration-500 feature-card border border-gray-100">
                        <div class="w-14 h-14 bg-indigo-100 rounded-full flex items-center justify-center mb-6">
                            <i class="fas fa-certificate text-indigo-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-3">Certified Courses</h3>
                        <p class="text-gray-600">Earn recognized certificates upon completion to boost your resume and career prospects.</p>
                    </div>

                    <!-- Feature 3 -->
                    <div class="bg-white p-8 rounded-xl shadow-lg transition duration-500 feature-card border border-gray-100">
                        <div class="w-14 h-14 bg-purple-100 rounded-full flex items-center justify-center mb-6">
                            <i class="fas fa-clock text-purple-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-3">Flexible Learning</h3>
                        <p class="text-gray-600">Study at your own pace with 24/7 access to course materials from anywhere.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Popular Courses Section -->
        <div class="py-16 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Popular <span class="gradient-text">Courses</span>
                    </h2>
                    <p class="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
                        Discover our most sought-after courses chosen by thousands of students.
                    </p>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- Using JSTL to display popular courses -->
                    <c:choose>
                        <c:when test="${not empty popularCourses}">
                            <c:forEach items="${popularCourses}" var="course">
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
                                                <i class="fas fa-star text-yellow-400 mr-1"></i>
                                                <span class="text-sm font-medium">4.8 (2.4k)</span>
                                            </div>
                                        </div>
                                        <h3 class="text-xl font-bold text-gray-900 mb-2">${course.courseName}</h3>
                                        <p class="text-gray-600 mb-4 text-sm">${course.courseDescription}</p>
                                        <div class="flex justify-between items-center">
                                            
                                            <a href="course-details?id=${course.id}" class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300">
                                                View Details
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Default courses if none are found in the database -->
                            <div class="bg-white rounded-xl overflow-hidden shadow-lg transition duration-500 hover:shadow-2xl">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1516116216624-53e697fedbea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2128&q=80" alt="Web Development" class="w-full h-48 object-cover">
                                    <div class="absolute top-4 right-4 bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-full">
                                        Bestseller
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-center mb-4">
                                        <span class="text-xs font-semibold text-blue-600 bg-blue-100 px-3 py-1 rounded-full">Programming</span>
                                        <div class="flex items-center">
                                            <i class="fas fa-star text-yellow-400 mr-1"></i>
                                            <span class="text-sm font-medium">4.8 (2.4k)</span>
                                        </div>
                                    </div>
                                    <h3 class="text-xl font-bold text-gray-900 mb-2">Full-Stack Web Development</h3>
                                    <p class="text-gray-600 mb-4 text-sm">Master both frontend and backend development with modern frameworks and tools.</p>
                                    <div class="flex justify-between items-center">
                                        
                                        <button class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300">
                                            Enroll Now
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-white rounded-xl overflow-hidden shadow-lg transition duration-500 hover:shadow-2xl">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Data Science" class="w-full h-48 object-cover">
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-center mb-4">
                                        <span class="text-xs font-semibold text-purple-600 bg-purple-100 px-3 py-1 rounded-full">Data Science</span>
                                        <div class="flex items-center">
                                            <i class="fas fa-star text-yellow-400 mr-1"></i>
                                            <span class="text-sm font-medium">4.7 (1.8k)</span>
                                        </div>
                                    </div>
                                    <h3 class="text-xl font-bold text-gray-900 mb-2">Data Science & Machine Learning</h3>
                                    <p class="text-gray-600 mb-4 text-sm">Learn to analyze data, build models, and make data-driven decisions.</p>
                                    <div class="flex justify-between items-center">
                                        <span class="text-lg font-bold text-blue-600">$79.99</span>
                                        <button class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300">
                                            Enroll Now
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-white rounded-xl overflow-hidden shadow-lg transition duration-500 hover:shadow-2xl">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Mobile App Development" class="w-full h-48 object-cover">
                                    <div class="absolute top-4 right-4 bg-green-600 text-white text-xs font-bold px-3 py-1 rounded-full">
                                        New
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-center mb-4">
                                        <span class="text-xs font-semibold text-green-600 bg-green-100 px-3 py-1 rounded-full">Mobile</span>
                                        <div class="flex items-center">
                                            <i class="fas fa-star text-yellow-400 mr-1"></i>
                                            <span class="text-sm font-medium">4.9 (950)</span>
                                        </div>
                                    </div>
                                    <h3 class="text-xl font-bold text-gray-900 mb-2">Mobile App Development</h3>
                                    <p class="text-gray-600 mb-4 text-sm">Build native mobile applications for iOS and Android platforms.</p>
                                    <div class="flex justify-between items-center">
                                        <span class="text-lg font-bold text-blue-600">$94.99</span>
                                        <button class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300">
                                            Enroll Now
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="text-center mt-12">
                    <a href="courses" class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 transition duration-300">
                        View All Courses
                        <i class="fas fa-arrow-right ml-2"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Testimonials Section -->
        <div class="py-16 bg-gray-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        What Our <span class="gradient-text">Students Say</span>
                    </h2>
                    <p class="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
                        Hear from our students about their learning experience with us.
                    </p>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- Testimonial 1 -->
                    <div class="bg-white p-8 rounded-xl shadow-md">
                        <div class="flex items-center mb-6">
                            <div class="text-yellow-400 flex">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                        <p class="text-gray-600 mb-6 italic">"The courses are well-structured and the instructors are knowledgeable. I've learned so much in just a few weeks!"</p>
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold mr-4">
                                JD
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-900">John Doe</h4>
                                <p class="text-sm text-gray-600">Web Development Student</p>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonial 2 -->
                    <div class="bg-white p-8 rounded-xl shadow-md">
                        <div class="flex items-center mb-6">
                            <div class="text-yellow-400 flex">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                        <p class="text-gray-600 mb-6 italic">"The flexibility of the platform allowed me to learn at my own pace while working full-time. Highly recommended!"</p>
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-purple-600 rounded-full flex items-center justify-center text-white font-bold mr-4">
                                JS
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-900">Jane Smith</h4>
                                <p class="text-sm text-gray-600">Data Science Student</p>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonial 3 -->
                    <div class="bg-white p-8 rounded-xl shadow-md">
                        <div class="flex items-center mb-6">
                            <div class="text-yellow-400 flex">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                        </div>
                        <p class="text-gray-600 mb-6 italic">"The practical projects helped me build a strong portfolio. I landed a job within a month of completing my course!"</p>
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-green-600 rounded-full flex items-center justify-center text-white font-bold mr-4">
                                RJ
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-900">Robert Johnson</h4>
                                <p class="text-sm text-gray-600">Mobile Development Student</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Newsletter Section -->
        <div class="py-16 bg-indigo-600">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="lg:flex lg:items-center lg:justify-between">
                    <div class="lg:w-1/2">
                        <h2 class="text-3xl font-extrabold text-white sm:text-4xl mb-4">
                            Stay Updated with Our Newsletter
                        </h2>
                        <p class="text-lg text-indigo-100 mb-6 lg:mb-0">
                            Get the latest updates on new courses, promotions, and educational resources.
                        </p>
                    </div>
                    <div class="lg:w-1/2">
                        <form class="sm:flex">
                            <input type="email" placeholder="Enter your email" class="w-full px-5 py-3 placeholder-gray-500 focus:ring-2 focus:ring-offset-2 focus:ring-offset-indigo-700 focus:ring-white focus:outline-none rounded-md mb-3 sm:mb-0 sm:mr-3">
                            <button type="submit" class="w-full sm:w-auto flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-indigo-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-indigo-700 focus:ring-white">
                                Subscribe
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Home</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">About Us</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Courses</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Contact</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">FAQ</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="text-lg font-semibold mb-4">Course Categories</h3>
                        <ul class="space-y-2">
                            <c:choose>
                                <c:when test="${not empty topCategories && topCategories.size() > 0}">
                                    <c:forEach items="${topCategories}" var="category" begin="0" end="4">
                                        <li><a href="courses?category=${category.id}" class="text-gray-400 hover:text-white transition duration-300">${category.name}</a></li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Web Development</a></li>
                                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Data Science</a></li>
                                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Mobile Development</a></li>
                                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">UI/UX Design</a></li>
                                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Business</a></li>
                                    </c:otherwise>
                                </c:choose>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <c:forEach items="${applicationScope.categories}" var="category" begin="0" end="4">
                        <li><a href="courses?category=${category.id}" class="text-gray-400 hover:text-white transition duration-300">${category.name}</a></li>
                    </c:forEach>
                    <c:if test="${empty applicationScope.categories}">
                        <li><a href="courses" class="text-gray-400 hover:text-white transition duration-300">All Courses</a></li>
                    </c:if>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="bg-white shadow-md">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/home" class="text-2xl font-bold text-blue-600">
                CourseManagement
            </a>
            
            <!-- Navigation -->
            <nav class="hidden md:flex space-x-8">
                <a href="${pageContext.request.contextPath}/home" class="text-gray-600 hover:text-blue-600">Home</a>
                <a href="${pageContext.request.contextPath}/courses" class="text-gray-600 hover:text-blue-600">Courses</a>
                <a href="${pageContext.request.contextPath}/about" class="text-gray-600 hover:text-blue-600">About Us</a>
                <a href="${pageContext.request.contextPath}/contact" class="text-gray-600 hover:text-blue-600">Contact</a>
            </nav>
            
            <!-- User Menu -->
            <div class="flex items-center space-x-4">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <!-- User is logged in -->
                        <div class="relative">
                            <button id="userMenuButton" class="flex items-center text-gray-700 hover:text-blue-600 focus:outline-none">
                                <span class="mr-1">${sessionScope.user.username}</span>
                                <i class="fas fa-chevron-down text-xs"></i>
                            </button>
                            <div id="userDropdownMenu" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                                <!-- Check if user is admin -->
                                <c:if test="${sessionScope.user.roleId == 1}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-500 hover:text-white">
                                        <i class="fas fa-tachometer-alt mr-2"></i>Admin Console
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/profile" class="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-500 hover:text-white">
                                    <i class="fas fa-user mr-2"></i>My Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/my-courses" class="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-500 hover:text-white">
                                    <i class="fas fa-book mr-2"></i>My Courses
                                </a>
                                <div class="border-t border-gray-100"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-500 hover:text-white">
                                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- User is not logged in -->
                        <a href="${pageContext.request.contextPath}/login" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-md">Sign In</a>
                        <a href="${pageContext.request.contextPath}/register" class="bg-white hover:bg-gray-100 text-blue-500 border border-blue-500 px-4 py-2 rounded-md">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Mobile Menu Button -->
            <div class="md:hidden">
                <button id="mobile-menu-button" class="text-gray-500 hover:text-blue-600 focus:outline-none">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
        </div>
        
        <!-- Mobile Menu -->
        <div id="mobile-menu" class="md:hidden hidden pb-4">
            <a href="${pageContext.request.contextPath}/" class="block py-2 text-gray-600 hover:text-blue-600">Home</a>
            <a href="${pageContext.request.contextPath}/courses" class="block py-2 text-gray-600 hover:text-blue-600">Courses</a>
            <a href="${pageContext.request.contextPath}/about" class="block py-2 text-gray-600 hover:text-blue-600">About Us</a>
            <a href="${pageContext.request.contextPath}/contact" class="block py-2 text-gray-600 hover:text-blue-600">Contact</a>
            
            <c:if test="${sessionScope.user != null}">
                <div class="border-t border-gray-200 my-2 pt-2">
                    <a href="${pageContext.request.contextPath}/profile" class="block py-2 text-gray-600 hover:text-blue-600">
                        <i class="fas fa-user mr-2"></i>My Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/my-courses" class="block py-2 text-gray-600 hover:text-blue-600">
                        <i class="fas fa-book mr-2"></i>My Courses
                    </a>
                    
                    <!-- Admin Console link for mobile -->
                    <c:if test="${sessionScope.user.roleId == 1}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="block py-2 text-gray-600 hover:text-blue-600">
                            <i class="fas fa-tachometer-alt mr-2"></i>Admin Console
                        </a>
                    </c:if>
                    
                    <a href="${pageContext.request.contextPath}/logout" class="block py-2 text-gray-600 hover:text-blue-600">
                        <i class="fas fa-sign-out-alt mr-2"></i>Logout
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</header>

<!-- JavaScript for Mobile Menu Toggle and User Dropdown -->
<script>
    // Mobile menu toggle
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const mobileMenu = document.getElementById('mobile-menu');
        mobileMenu.classList.toggle('hidden');
    });
    
    // User dropdown menu toggle
    const userMenuButton = document.getElementById('userMenuButton');
    const userDropdownMenu = document.getElementById('userDropdownMenu');
    
    if (userMenuButton) {
        userMenuButton.addEventListener('click', function(event) {
            userDropdownMenu.classList.toggle('hidden');
            event.stopPropagation();
        });
        
        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            if (!userMenuButton.contains(event.target) && !userDropdownMenu.contains(event.target)) {
                userDropdownMenu.classList.add('hidden');
            }
        });
    }
</script>